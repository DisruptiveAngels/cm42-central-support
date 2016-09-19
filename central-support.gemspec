# coding: utf-8
# frozen_string_literal: true
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'central/support/version'

Gem::Specification.new do |spec|
  spec.name          = "central-support"
  spec.version       = Central::Support::VERSION
  spec.authors       = ["Fabio Akita"]
  spec.email         = ["boss@akitaonrails.com"]

  spec.summary       = %q{Support library for the Central project}
  spec.description   = %q{Extraction of part of the intelligence behind Central}
  spec.homepage      = "https://github.com/Codeminer-42/central-support"
  spec.license       = "MIT"

  spec.required_ruby_version = '>= 2.0'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activesupport", ">= 3.2"
  spec.add_runtime_dependency "activerecord", ">= 3.2"
  spec.add_runtime_dependency 'enumerize'
  spec.add_runtime_dependency 'transitions'

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency 'codeclimate-test-reporter'
  spec.add_development_dependency 'database_cleaner'
  spec.add_development_dependency "factory_girl"
  spec.add_development_dependency "factory_girl_rails"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.5"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "rspec-its"
  spec.add_development_dependency "rspec-activemodel-mocks"
  spec.add_development_dependency "shoulda-matchers"
  spec.add_development_dependency 'timecop'

  # These gems are required by the dummy app in spec/support/rails_app
  # but unless it's declared here, they are not being loaded just by the
  # spec/support/rails_app/Gemfile.lock
  spec.add_development_dependency 'devise'
  spec.add_development_dependency 'friendly_id'
  spec.add_development_dependency 'foreigner'
  spec.add_development_dependency 'sqlite3'

  # Debugging
  spec.add_development_dependency 'awesome_print'
  spec.add_development_dependency 'pry-byebug'
end
