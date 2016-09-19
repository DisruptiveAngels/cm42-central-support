class Story < ActiveRecord::Base
  include Central::Support::StoryConcern::Attributes
  include Central::Support::StoryConcern::Associations
  include Central::Support::StoryConcern::Validations
  include Central::Support::StoryConcern::Transitions
  include Central::Support::StoryConcern::Scopes
  include Central::Support::StoryConcern::Callbacks
  include Central::Support::StoryConcern::CSV
end
