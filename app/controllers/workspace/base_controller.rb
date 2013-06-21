class Workspace::BaseController < ApplicationController
  layout 'workspace'
  before_filter :authenticate_user!
  
protected
  def collection_route(collection)
    collection.to_route(self)
  end
  helper_method :collection_route
end
