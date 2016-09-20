module Central
  module Support
    module TeamConcern
      module Validations
        extend ActiveSupport::Concern

        included do
          validates :name, presence: true, uniqueness: true
        end
      end
    end
  end
end
