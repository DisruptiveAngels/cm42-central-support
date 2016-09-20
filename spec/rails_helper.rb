# frozen_string_literal: true
ENV['RAILS_ENV'] ||= 'test'

require 'rails/all'

require 'factory_girl'
require 'factory_girl_rails'
require 'rspec/rails'
require 'shoulda/matchers'

`cd spec/support/rails_app ; bin/rails db:drop db:create db:schema:load RAILS_ENV=test`

require 'support/rails_app/config/environment'

require 'support/database_cleaner'
require 'support/factory_girl'
require 'support/factories'
require 'spec_helper'
