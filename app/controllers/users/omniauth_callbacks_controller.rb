class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  skip_before_action :verify_authenticity_token, only: :google_oauth2

  def google_oauth2
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user
    else
      session["devise.google_oauth2_data"] = request.env["omniauth.auth"].except(:extra) 
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end

end
