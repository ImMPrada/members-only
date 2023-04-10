class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_many :memberships, dependent: :destroy

  validates :email, presence: true, uniqueness: true, format: {
    with: URI::MailTo::EMAIL_REGEXP,
    message: 'invalid email address'
  }
  validates :username, presence: true, uniqueness: true,
                       length: {
                         in: 3..20,
                         wrong_length: 'must be between 3 and 20 characters'
                       },
                       format: {
                         with: /\A[a-z\d]*\Z/i,
                         message: 'allows only numbers and letters'
                       }
end