# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      Rails.logger.debug("User successfully signed in.")
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "Twitter") if is_navigational_format?
    else
      Rails.logger.debug("User not persisted. Twitter data: #{request.env["omniauth.auth"].except("extra").inspect}")
      session["devise.twitter_data"] = request.env["omniauth.auth"].except("extra")
      redirect_to new_user_registration_url
    end
  end

  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
	if @user.persisted?
	      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
	      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
	    else
	      session["devise.facebook_data"] = request.env["omniauth.auth"].except(:extra) # Removing extra as it can overflow some session stores
	      redirect_to new_user_registration_url
	    end
	 end

  def failure
    Rails.logger.debug("Twitter authentication failed.")
    redirect_to root_path
  end
end
