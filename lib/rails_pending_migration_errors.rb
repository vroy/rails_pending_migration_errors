require "rails_pending_migration_errors/version"
require "rails_pending_migration_errors/middleware"
require "rails_pending_migration_errors/rails"

module RailsPendingMigrationErrors
  mattr_accessor :page_load

  def self.needs_migrations?
    (file_versions - db_versions).size > 0
  end

  def self.file_versions
    ActiveRecord::Migrator.migrations( ActiveRecord::Migrator.migrations_paths ).map(&:version)
  end

  def self.db_versions
    ActiveRecord::Migrator.get_all_versions
  end
end
