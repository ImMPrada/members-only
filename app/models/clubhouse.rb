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
    users_of_role(Membership::OWNER_ROLE)
  end

  def admins
    users_of_role(Membership::ADMIN_ROLE)
  end

  def members
    users_of_role(Membership::MEMBER_ROLE)
  end

  private

  def users_of_role(role)
    role_memberships = memberships.where(role:)
    users.where(id: role_memberships.select(:user_id))
  end
end
