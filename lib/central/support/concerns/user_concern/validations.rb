module Central
  module Support
    module UserConcern
      module Validations
        extend ActiveSupport::Concern

        included do
          ROLES = %w(manager developer guest).freeze

          validates :name, :username, :initials, presence: true
          validates :username, uniqueness: true

          validates :role, inclusion: { in: ROLES }
        end
      end
    end
  end
end
