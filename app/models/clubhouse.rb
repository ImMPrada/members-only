class Clubhouse < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

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
end
