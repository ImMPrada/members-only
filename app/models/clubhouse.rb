class Clubhouse < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  validates :title, presence: true

  def self.create_with_owner(owner, properties)
    clubhouse = Clubhouse.create(properties)
    membership = Membership.new(
      user: owner,
      clubhouse:,
      role: Membership::OWNER_ROLE
    )
    return clubhouse if membership.save

    nil
  end

  def owners
    role_memberships = memberships.where(
      role: Membership::OWNER_ROLE
    )
    users.where(id: role_memberships.select(:user_id))
  end

  def admins
    role_memberships = memberships.where(
      'role = ? OR role = ?',
      Membership::OWNER_ROLE,
      Membership::ADMIN_ROLE
    )
    users.where(id: role_memberships.select(:user_id))
  end

  def members
    role_memberships = memberships.where(
      role: Membership::MEMBER_ROLE
    )
    users.where(id: role_memberships.select(:user_id))
  end
end
