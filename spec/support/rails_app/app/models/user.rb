class User < ActiveRecord::Base
  include Central::Support::UserConcern::Associations
  include Central::Support::UserConcern::Validations
  include Central::Support::UserConcern::Callbacks

  AUTHENTICATION_KEYS = %i[email team_slug]

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :trackable, :validatable,
         authentication_keys:   AUTHENTICATION_KEYS,
         strip_whitespace_keys: AUTHENTICATION_KEYS

end
