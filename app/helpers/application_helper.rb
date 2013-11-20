module ApplicationHelper
  def ok_url_tag
    hidden_field_tag :ok_url, params[:ok_url] if params[:ok_url].present?
  end

  def link_to_add_fields(name, f, association, options = {})
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end

    (options[:data] ||= {}).update(id: id, fields: fields.gsub("\n", ""))
    options[:class] ||= "add_fields"
    link_to(name, '#', options)
  end
end
