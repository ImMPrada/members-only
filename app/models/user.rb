class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,
         :omniauthable, omniauth_providers: %i[google_oauth2]
  has_many :posts
  has_many :comments
  has_many :memberships, dependent: :destroy
  has_many :clubhouses, through: :memberships

  validates :email, presence: true, uniqueness: true, format: {
    with: URI::MailTo::EMAIL_REGEXP,
    message: 'invalid email address'
  }
  validates :username, presence: true, uniqueness: true,
                       length: {
                         in: 3..20,
                         wrong_length: 'must be between 3 and 20 characters'
                       }

  class << self
    def from_omniauth(auth)
      username = auth.info.email.split('@').first

      find_or_create_by(
        provider: auth.provider,
        uid: auth.uid,
        params: new_user_params(auth, username)
      )
    end

    private

    def can_use_username?(username, email)
      !find_by(username:, email:).blank?
    end

    def new_user_params(auth, username)
      {
        username: can_use_username?(username, auth.info.email) ? username : "johndoe#{rand(1000)}",
        email: auth.info.email,
        password: Devise.friendly_token[0, 20],
        full_name: auth.info.name,
        avatar_url: auth.info.image
      }
    end

    def find_or_create_by(provider:, uid:, params:)
      where(provider:, uid:).first_or_create(params)
    end
  end

  def clubhouses_as_owner
    clubhouses_of_role(Membership::OWNER_ROLE)
  end

  def clubhouses_as_admin
    clubhouses_of_role(Membership::ADMIN_ROLE)
  end

  def clubhouses_as_member
    clubhouses_of_role(Membership::MEMBER_ROLE)
  end

  def member_of?(clubhouse)
    memberships.find_by(clubhouse:).present?
  end

  private

  def clubhouses_of_role(role)
    role_memberships = memberships.where(role:)
    clubhouses.where(id: role_memberships.select(:clubhouse_id))
  end
end
