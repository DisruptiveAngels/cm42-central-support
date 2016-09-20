module Central
  module Support
    module ActivityConcern
      module Associations
        extend ActiveSupport::Concern

        included do
          belongs_to :project
          belongs_to :user
          belongs_to :subject, polymorphic: true
        end
      end
    end
  end
end
