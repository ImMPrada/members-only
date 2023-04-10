class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :clubhouse

  validates :role, presence: true, inclusion: { in: %w[member admin owner],
                                                message: "#{value} is not a valid size" }
end
