class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_many :memberships, dependent: :destroy

  validates :email, presence: true, uniqueness: true, format: {
    with: URI::MailTo::EMAIL_REGEXP,
    message: 'invalid email address'
  }
  validates :username, presence: true, uniqueness: true,
                       length: {
                         in: 3..20,
                         wrong_length: 'must be between 3 and 20 characters'
                       },
                       format: {
                         with: /\A[a-z\d]*\Z/i,
                         message: 'allows only numbers and letters'
                       }

  def clubhouses_as_owner
    clubhouses_of_role('owner')
  end

  def clubhouses_as_admin
    clubhouses_of_role('admin')
  end

  def clubhouses_as_member
    clubhouses_of_role('member')
  end

  private

  def clubhouses_of_role(role)
    Membership.where('user_id = ? AND role = ?', id, role).map(&:clubhouse)
  end
end
