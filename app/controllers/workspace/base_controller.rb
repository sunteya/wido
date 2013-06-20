class Workspace::BaseController < ApplicationController
  layout 'workspace'
  
protected
  def current_user
    @current_user ||= User.first
  end
  helper_method :current_user
  
  def collection_route(collection)
    collection.to_route(self)
  end
  helper_method :collection_route
end
