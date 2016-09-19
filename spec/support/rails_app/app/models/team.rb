class Team < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :enrollments
  has_many :users, through: :enrollments

  has_many :ownerships
  has_many :projects, through: :ownerships do
    def not_archived
      where(archived_at: nil)
    end
  end

  scope :not_archived, -> { where(archived_at: nil) }
  scope :archived, -> { where.not(archived_at: nil) }

  def is_admin?(user)
    enrollments.find_by_user_id(user.id)&.is_admin?
  end

  def owns?(project)
    ownerships.find_by_project_id(project.id)&.is_owner
  end
end
