class Clubhouse < ApplicationRecord
  has_one :admin

  validates :title, presence: true
end
