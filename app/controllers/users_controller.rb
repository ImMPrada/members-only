class UsersController < ApplicationController
  USERNAME_PLACEHOLDER = 'cosme_fulanito'.freeze
  EMAIL_PLACEHOLDER = 'example@mail.com'.freeze
  PASSWORD_PLACEHOLDER = '********'.freeze

  def new
    @user = User.new
  end

  def create; end

  def show; end

  def edit; end

  def update; end

  def destroy; end
end
