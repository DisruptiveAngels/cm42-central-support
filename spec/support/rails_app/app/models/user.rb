class User < ActiveRecord::Base
  AUTHENTICATION_KEYS = %i[email team_slug]

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :trackable, :validatable,
         authentication_keys:   AUTHENTICATION_KEYS,
         strip_whitespace_keys: AUTHENTICATION_KEYS

  # Flag used to identify if the user was found or created from find_or_create
  attr_accessor :was_created, :team_slug

  has_many :enrollments
  has_many :teams, through: :enrollments

  has_many :memberships, dependent: :destroy
  has_many :projects, -> { uniq }, through: :memberships do
    def not_archived
      where(archived_at: nil)
    end
  end

  def to_s
    "#{name} (#{initials}) <#{email}>"
  end

  before_validation :set_random_password_if_blank
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
end
