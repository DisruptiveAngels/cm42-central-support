module Central
  module Support
    module UserConcern
      module Callbacks
        extend ActiveSupport::Concern

        included do
          attr_accessor :team_slug

          before_validation :set_random_password_if_blank

          after_save :set_team

          before_destroy :remove_story_association
        end

        def set_random_password_if_blank
          if new_record? && self.password.blank? && self.password_confirmation.blank?
            self.password = self.password_confirmation = Digest::SHA1.hexdigest("--#{Time.current.to_s}--#{email}--")[0,8]
          end
        end

        def set_team
          if team_slug
            team = Team.not_archived.find_by_slug(team_slug)
            self.enrollments.create(team: team) if team
          end
        end

        def remove_story_association
          Story.where(requested_by_id: id).update_all(requested_by_id: nil, requested_by_name: nil)
          Story.where(owned_by_id: id).update_all(owned_by_id: nil, owned_by_name: nil)
          Membership.where(user_id: id).delete_all
        end

      end
    end
  end
end
