module RailsPendingMigrationErrors

  class Railtie < Rails::Railtie
    initializer "rails_pending_migration_errors.configure_rails_initialization" do
      if Rails.env.development?
        Rails.application.middleware.use RailsPendingMigrationErrors::Middleware
      end
    end
  end

end
