class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def google_oauth2
    @auth = request.env['omniauth.auth']

    if successful_integration_creation
      sign_in(@user, scope: @user)
      redirect_to root_path, notice: 'Signed in successfully.'
    else
      redirect_to user_session_path, alert: 'Google was unable to authorize this request. Please try again.'
    end
  end

  private

  def create_user
    @user = User.from_omniauth(@auth)
  end

  def successful_integration_creation
    @auth != :invalid_credentials &&
              @auth[:credentials][:token] &&
              create_user
  end
end
