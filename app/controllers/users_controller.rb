class UsersController < ApplicationController
  before_action :authenticate_user!

  USERNAME_PLACEHOLDER = 'cosme_fulanito'.freeze
  EMAIL_PLACEHOLDER = 'example@mail.com'.freeze
  PASSWORD_PLACEHOLDER = '********'.freeze

  def show; end
end
