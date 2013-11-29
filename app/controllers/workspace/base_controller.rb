class Workspace::BaseController < ApplicationController
  layout 'workspace'
  before_filter :require_complete_user_profile!
  
protected
  def collection_route(collection)
    collection.to_route(self)
  end
  helper_method :collection_route

  def require_complete_user_profile!
    if current_user && !current_user.profile_completed?
      redirect_to edit_profile_path(ok_url: request.fullpath)
      false
    else
      warden.authenticate!(scope: :user) if !devise_controller?
    end
  end
end
