# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails_pending_migration_errors/version'

Gem::Specification.new do |spec|
  spec.name          = "rails_pending_migration_errors"
  spec.version       = RailsPendingMigrationErrors::VERSION
  spec.authors       = ["Vincent Roy"]
  spec.email         = ["vincentroy8@gmail.com"]
  spec.description   = "Raise errors in development mode when there are pending migrations to run."
  spec.summary       = ""
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
