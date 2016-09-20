source 'https://rubygems.org'

# Specify your gem's dependencies in central-support.gemspec
gemspec

group :test do
  gem 'rspec-rails'
  gem 'rspec-its'
  gem 'rspec-activemodel-mocks'
  gem 'shoulda-matchers'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'codeclimate-test-reporter', require: nil
  gem 'timecop'
end

# for some reason, this set of gems has to also be duplicated in the dummy app Gemfile
gem 'rails'
gem 'devise'
gem 'sqlite3'
gem 'friendly_id'
gem 'enumerize'
gem 'foreigner'
gem 'transitions', '0.1.9', require: ['transitions', 'active_record/transitions']
