module ApplicationHelper
  def ok_url_tag
    hidden_field_tag :ok_url, params[:ok_url] if params[:ok_url].present?
  end
end
