class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
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
    !memberships.find_by(clubhouse:).nil?
  end

  private

  def clubhouses_of_role(role)
    role_memberships = memberships.where(role:)
    clubhouses.where(id: role_memberships.select(:clubhouse_id))
  end
end
