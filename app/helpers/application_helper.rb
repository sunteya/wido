require "kramdown"

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

  def article_path(article)
    slug = article.slug.blank? ? "#{article.id}" : "#{article.id}-#{article.slug}"
    pattern_article_path(author: article.user.slug, article: slug)
  end

  # Returns an ordidinal date eg July 22 2007 -> July 22nd 2007
  def ordinalize(date)
    "#{date.strftime('%b')} #{ordinal(date.strftime('%e').to_i)}, #{date.strftime('%Y')}".html_safe
  end

  # Returns an ordinal number. 13 -> 13th, 21 -> 21st etc.
  def ordinal(number)
    if (11..13).include?(number.to_i % 100)
      "#{number}<span>th</span>"
    else
      case number.to_i % 10
      when 1; "#{number}<span>st</span>"
      when 2; "#{number}<span>nd</span>"
      when 3; "#{number}<span>rd</span>"
      else    "#{number}<span>th</span>"
      end
    end
  end

  # Used on the blog index to split posts on the <!--more--> marker
  def excerpt(input)
    if input.index(/<!--\s*more\s*-->/i)
      input.split(/<!--\s*more\s*-->/i)[0]
    else
      input
    end
  end

  # Checks for excerpts (helpful for template conditionals)
  def has_excerpt(input)
    input =~ /<!--\s*more\s*-->/i ? true : false
  end

  def explain(content)
    html = Kramdown::Document.new(content, 
      enable_coderay: false,
      toc_levels: [ 2, 3 ]
    ).to_html
  end
end
