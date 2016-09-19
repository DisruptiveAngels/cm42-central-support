class Project < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :ownerships
  has_many :teams, through: :ownerships

  has_many :memberships, dependent: :destroy
  has_many :users, -> { uniq }, through: :memberships

  accepts_nested_attributes_for :users, reject_if: :all_blank

  has_many :stories, dependent: :destroy do
    def with_dependencies
      includes(:notes, :tasks, :document_files)
    end
  end

  scope :not_archived, -> { where(archived_at: nil) }
  scope :archived, -> { where.not(archived_at: nil) }

  attr_writer :suppress_notifications

  def suppress_notifications
    @suppress_notifications || false
  end

  def to_s
    name
  end
end
