class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

protected
  def redirect_to_ok_url_or_default(default)
    redirect_to params[:ok_url] || default
  end

end
