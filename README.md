# Rails Pending Migration Errors

Append warnings or raise an exception in development mode when there are pending migrations to run.

It is inspired by [this feature](https://github.com/rails/rails/pull/6665) that made it in Rails 4.

**Note:** this has only been tested against Rails 3.2.13 on ruby 2.0.0p247.

## Installation

Add this line to your application's Gemfile:

    gem 'rails_pending_migration_errors', group: :development

And then execute:

    $ bundle

If you want to raise errors on page load instead of the default warning, add this to `config/environments/development.rb`:

    config.after_initialize do
      RailsPendingMigrationErrors.page_load = true
    end
