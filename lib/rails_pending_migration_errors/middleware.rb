module ActiveRecord
  class PendingMigrationError < ActiveRecordError#:nodoc:
    def initialize
      super("Migrations are pending; run 'bin/rake db:migrate RAILS_ENV=#{::Rails.env}' to resolve this issue.")
    end
  end
end

module RailsPendingMigrationErrors

  class Middleware

    def initialize(app)
      @app = app
    end

    def call(env)
      status, headers, response = @app.call(env)
      response_body = nil

      return [status, headers, response] if status != 200 or !html_request?(headers, response)

      if RailsPendingMigrationErrors.needs_migrations?
        if RailsPendingMigrationErrors.page_load
          raise ActiveRecord::PendingMigrationError

        else
          response_body = append_response_body(headers, response)

        end
      end

      [status, headers, response_body ? [response_body] : response]
    end

    private

    def append_response_body(headers, response)
      response_body = response_body(response)
      response_body << "<div #{footer_div_style}>Migrations are pending; run 'bin/rake db:migrate RAILS_ENV=#{::Rails.env}' to resolve this issue.</div>"
      headers['Content-Length'] = response_body.bytesize.to_s
      response_body
    end

    def html_request?(headers, response)
      headers['Content-Type'] && headers['Content-Type'].include?('text/html') && response_body(response).include?("<html")
    end

    def response_body(response)
      if Array === response
        response.first
      elsif Array === response.body
        response.body.first
      else
        response.body
      end
    end

    def footer_div_style
<<EOF
style="position: fixed; bottom: 0; left: 0; cursor: pointer;
       border-style: solid; border-color: red; border-width: 2px 2px 0 0;
       padding: 6px; background: #FFB7B1; border-top-right-radius: 10px;
       color: red; font-weight: bold; font-size: 18px; z-index: 100000;"
EOF
    end


  end
end
