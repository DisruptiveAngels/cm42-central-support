module Central
  module Support
    module ActivityConcern
      module Validations
        extend ActiveSupport::Concern

        included do
          validates :action, presence: true, inclusion: { in: %w(create update destroy) }
          validates :project, presence: true
          validates :user, presence: true
          validates :subject, presence: true, changed: true
        end
      end
    end
  end
end

