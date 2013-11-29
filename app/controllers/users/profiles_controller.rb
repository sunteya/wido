class Users::ProfilesController < ApplicationController
  layout "users"

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.require_profile_completed!

    if @user.update_attributes(user_params)
      redirect_to_ok_url_or_default workspace_root_path
    else
      render "edit"
    end
  end

  def user_params
    params.require(:user).permit(:slug) if params[:user]
  end
end
