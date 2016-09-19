module Central
  module Support
    module ProjectConcern
      module Validations
        extend ActiveSupport::Concern

        included do
          # These are the valid point scales for a project. These represent
          # the set of valid points estimate values for a story in this project.
          POINT_SCALES = {
            'fibonacci'     => [1,2,3,5,8].freeze,
            'powers_of_two' => [1,2,4,8].freeze,
            'linear'        => [1,2,3,4,5].freeze,
          }.freeze

          validates_inclusion_of :point_scale, in: POINT_SCALES.keys,
            message: "%{value} is not a valid estimation scheme"

          ITERATION_LENGTH_RANGE = (1..4).freeze

          validates_numericality_of :iteration_length,
            greater_than_or_equal_to: ITERATION_LENGTH_RANGE.min,
            less_than_or_equal_to: ITERATION_LENGTH_RANGE.max, only_integer: true,
            message: "must be between 1 and 4 weeks"

          validates_numericality_of :iteration_start_day,
            greater_than_or_equal_to: 0, less_than_or_equal_to: 6,
            only_integer: true, message: "must be an integer between 0 and 6"

          validates :name, presence: true

          validates_numericality_of :default_velocity, greater_than: 0,
                                    only_integer: true
        end

        # Returns an array of the valid points values for this project
        def point_values
          POINT_SCALES[point_scale]
        end
      end
    end
  end
end
