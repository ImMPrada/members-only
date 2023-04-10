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
    memberships.where(role: 'owner').map(&:user)
  end

  def admins
    memberships.where(role: 'admin').map(&:user)
  end

  def members
    memberships.where(role: 'member').map(&:user)
  end
end
