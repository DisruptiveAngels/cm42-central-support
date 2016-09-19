class Activity < ActiveRecord::Base
  serialize :subject_changes, Hash

  belongs_to :project
  belongs_to :user
  belongs_to :subject, polymorphic: true
end
