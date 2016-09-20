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

        module ClassMethods
          def fetch_polymorphic(ids, since)
            stories = where("subject_type in ('Project', 'Story')").includes(:user, :subject).projects(ids).since(since).to_a
            stories + where("subject_type in ('Note', 'Task')").includes(:user, subject: [:story]).projects(ids).since(since).to_a
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

