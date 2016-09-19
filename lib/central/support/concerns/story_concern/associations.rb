module Central
  module Support
    module StoryConcern
      module Associations
        extend ActiveSupport::Concern
        included do
          belongs_to :project, counter_cache: true
          belongs_to :requested_by, class_name: 'User'
          belongs_to :owned_by, class_name: 'User'

          has_many :changesets, dependent: :destroy
          has_many :users, through: :project
          has_many :tasks, dependent: :destroy
        end
      end
    end
  end
end
