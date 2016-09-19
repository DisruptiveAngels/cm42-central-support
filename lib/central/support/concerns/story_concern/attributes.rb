module Central
  module Support
    module StoryConcern
      module Attributes
        extend ActiveSupport::Concern

        included do
          delegate :suppress_notifications, to: :project

          # This attribute is used to store the user who is acting on a story, for
          # example delivering or modifying it.  Usually set by the controller.
          attr_accessor :acting_user, :base_uri
          attr_accessor :iteration_number, :iteration_start_date # helper fields for IterationService
          attr_accessor :iteration_service
        end

        def to_s
          title
        end
      end
    end
  end
end
