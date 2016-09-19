module Central
  module Support
    module StoryConcern
      module Transitions
        extend ActiveSupport::Concern
        include ActiveRecord::Transitions

        included do
          state_machine do
            state :unscheduled
            state :unstarted
            state :started
            state :finished
            state :delivered
            state :accepted
            state :rejected

            event :start do
              transitions to: :started, from: [:unstarted, :unscheduled]
            end

            event :finish do
              transitions to: :finished, from: :started
            end

            event :deliver do
              transitions to: :delivered, from: :finished
            end

            event :accept do
              transitions to: :accepted, from: :delivered
            end

            event :reject do
              transitions to: :rejected, from: :delivered
            end

            event :restart do
              transitions to: :started, from: :rejected
            end
          end
        end

        # Returns the list of state change events that can operate on this story,
        # based on its current state
        def events
          self.class.state_machine.events_for(current_state)
        end

        # Returns the CSS id of the column this story belongs in
        def column
          case state
          when 'unscheduled'
            '#chilly_bin'
          when 'unstarted'
            '#backlog'
          when 'accepted'
            if iteration_service
              if iteration_service.current_iteration_number == iteration_service.iteration_number_for_date(accepted_at)
                return '#in_progress'
              end
            end
            '#done'
          else
            '#in_progress'
          end
        end
      end
    end
  end
end
