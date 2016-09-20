module Central
  module Support
    module UserConcern
      module Validations
        extend ActiveSupport::Concern

        included do
          validates :name, :username, :initials, presence: true
          validates :username, uniqueness: true
        end
      end
    end
  end
end
