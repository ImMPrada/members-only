class Membership < ApplicationRecord
  OWNER_ROLE = 'owner'.freeze
  ADMIN_ROLE = 'admin'.freeze
  MEMBER_ROLE = 'member'.freeze

  belongs_to :user
  belongs_to :clubhouse

  validates :role, presence: true, inclusion: { in: [OWNER_ROLE, ADMIN_ROLE, MEMBER_ROLE],
                                                message: '%<value>s is not a valid size' }
end
