class Clubhouse < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :memberships, dependent: :destroy

  validates :title, presence: true

  def self.with_owner(owner, properties)
    clubhouse = Clubhouse.create(properties)
    membership = Membership.new(
      user: owner,
      clubhouse:,
      role: 'owner'
    )
    return clubhouse if membership.save

    nil
  end

  def owners
    users_of_role('owner')
  end

  def admins
    users_of_role('admin')
  end

  def members
    users_of_role('member')
  end

  private

  def users_of_role(role)
    Membership.where('clubhouse_id = ? AND role = ?', id, role).map(&:user)
  end
end
