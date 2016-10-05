module Central
  module Support
    module ActivityConcern
      module Scopes
        extend ActiveSupport::Concern

        included do
          scope :projects, ->(ids) {
            where(project_id: ids) if ids
          }

          scope :since, ->(date) {
            where("created_at > ?", date.beginning_of_day) if date
          }
        end

        def merge_story!(activity)
          return if subject_type != 'Story' # story only
          return if subject_id != activity.subject_id # only merge the exact same story change
          return if updated_at > activity.updated_at # only merge from future changes
          return if activity.subject_changes.blank?

          self.subject_changes = {} if self.subject_changes.nil?

          activity.subject_changes.keys.each do |key|
            if subject_changes[key]
              self.subject_changes[key][-1] = activity.subject_changes[key][-1]
            else
              self.subject_changes[key] = activity.subject_changes[key]
            end
          end
        end

        def decorate
          self
        end

        module ClassMethods
          def fetch_polymorphic(ids, since)
            stories = where("subject_type in ('Project', 'Story')").
              includes(:user, :subject).
              projects(ids).
              since(since).to_a
            stories += where("subject_type in ('Note', 'Task')").
              includes(:user, subject: [:story]).
              projects(ids).
              since(since).to_a
            stories = stories.group_by { |activity| activity.subject_id }

            [].tap do |new_activities|
              stories.values.each do |activities|
                sub_list = activities.sort_by { |story| story.updated_at }
                first_story = sub_list.shift
                while sub_list.size > 0
                  first_story.merge_story!(sub_list.shift)
                end
                new_activities << first_story
              end
            end
          end

          def grouped_activities(allowed_projects, since)
            fetch_polymorphic(allowed_projects.pluck(:id), since).group_by { |activity|
              activity.created_at.beginning_of_day
            }.
            map { |date, activities|
              [
                date,
                activities.group_by { |activity|
                  activity.project_id
                }.
                map { |project_id, activities|
                  [
                    allowed_projects.find { |p| p.id == project_id },
                    activities.group_by { |activity|
                      activity.subject_destroyed_type || activity.subject_type
                    }.
                    map { |subject_type, activities|
                      [
                        subject_type,
                        activities.map(&:decorate)
                      ]
                    }
                  ]
                }
              ]
            }
          end
        end
      end
    end
  end
end

