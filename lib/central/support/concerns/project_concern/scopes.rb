module Central
  module Support
    module ProjectConcern
      module Scopes
        extend ActiveSupport::Concern

        included do
          scope :not_archived, -> { where(archived_at: nil) }
          scope :archived, -> { where.not(archived_at: nil) }
        end

        def archived
          !!(archived_at)
        end

        def archived=(value)
          if !value || value == "0"
            self.archived_at = nil
          else
            self.archived_at = Time.current
          end
        end
      end
    end
  end
end
