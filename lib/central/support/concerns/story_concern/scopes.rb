module Central
  module Support
    module StoryConcern
      module Scopes
        extend ActiveSupport::Concern

        included do
          scope :done,        -> { where(state: :accepted) }
          scope :in_progress, -> { where(state: [:started, :finished, :delivered]) }
          scope :backlog,     -> { where(state: :unstarted) }
          scope :chilly_bin,  -> { where(state: :unscheduled) }
        end
      end
    end
  end
end
