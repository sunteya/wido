class Users::SessionsController < Devise::SessionsController
  layout false

  def after_sign_in_path_for(resource_or_scope)
    params[:ok_url] || stored_location_for(resource) || root_path
  end
end
