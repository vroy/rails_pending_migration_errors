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
      ActiveRecord::Base.logger.quietly do
        check_pending_migrations!
      end

      @app.call(env)
    end

    private

    def check_pending_migrations!
      raise ActiveRecord::PendingMigrationError if needs_migrations?
    end

    def needs_migrations?
      (file_versions - db_versions).size > 0
    end

    def file_versions
      ActiveRecord::Migrator.migrations( ActiveRecord::Migrator.migrations_paths ).map(&:version)
    end

    def db_versions
      ActiveRecord::Migrator.get_all_versions
    end

  end
end
