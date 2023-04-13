# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    # before_action :configure_sign_in_params, only: [:create]

    # GET /resource/sign_in
    # def new
    #   super
    # end

    # POST /resource/sign_in
    def create
      puts 'TEA'
      user = find_user

      unless user
        wrong_result and return
      end

      if user&.valid_password?(params[:password])
        set_flash_message :notice, :signed_in
        sign_in(user)
        redirect_to user_path(user)
      else
        wrong_result
      end
      # super
    end

    # DELETE /resource/sign_out
    # def destroy
    #   super
    # end

    protected

    def configure_sign_in_params
      devise_parameter_sanitizer.permit(:sign_in, keys: [:identificator])
    end

    def wrong_result
      flash[:alert] = 'Wrong user or password.'
      redirect_to new_user_session_path
    end

    def find_user
      identificator = params[:identificator]
      user_by_email = User.find_by(email: identificator)
      return user_by_email if user_by_email

      User.find_by(username: identificator)
    end
  end
end
