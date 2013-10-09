# Rails Pending Migration Errors

Raise errors in development mode when there are pending migrations to run.

It is essentially a backport of [this feature](https://github.com/rails/rails/pull/6665) that made it in Rails 4.

![Example](http://f.cl.ly/items/3a3Q0i3e1D0s12420t0v/Screen%20Shot%202013-10-09%20at%207.19.28%20PM.png "Example")

**Note:** this has only been tested against Rails 3.2.13 on ruby 2.0.0p247.

## Installation

Add this line to your application's Gemfile:

    gem 'rails_pending_migration_errors', group: :development

And then execute:

    $ bundle
