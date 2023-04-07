class Admin < ApplicationRecord
  belongs_to :user
  belongs_to :clubhouse
end
