class Team < ActiveRecord::Base
  include Central::Support::TeamConcern::Associations
  include Central::Support::TeamConcern::Validations
  include Central::Support::TeamConcern::Scopes
  include Central::Support::TeamConcern::DomainValidator
end
