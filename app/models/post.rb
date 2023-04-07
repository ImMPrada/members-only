class Post < ApplicationRecord
  belongs_to :user
  belongs_to :clubhouse
  has_many :comments, dependent: :destroy

  validates :content, presence: true
end
