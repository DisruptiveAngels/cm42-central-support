module Central
  module Support
    module TeamConcern
      module Scopes
        extend ActiveSupport::Concern

        included do
          scope :not_archived, -> { where(archived_at: nil) }
          scope :archived, -> { where.not(archived_at: nil) }
        end
      end
    end
  end
end

