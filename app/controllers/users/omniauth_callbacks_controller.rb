class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    access_token = request.env["omniauth.auth"]
    data = access_token.info

    user_scope = User.where(email: data[:email].downcase)
    @user = user_scope.first
    
    if @user
      sign_in_and_redirect @user, :event => :authentication
    else
      @user = user_scope.create
      
      # TODO slug?
      sign_in_and_redirect @user, :event => :authentication
    end
  end
end