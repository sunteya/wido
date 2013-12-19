require "kramdown"
require "nokogiri"

module ApplicationHelper
  def ok_url_tag
    hidden_field_tag :ok_url, params[:ok_url] if params[:ok_url].present?
  end

  def link_to_add_fields(name, f, association, options = {}, &block)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id

    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      capture(builder, &block)
    end

    (options[:data] ||= {}).update(id: id, fields: fields.gsub("\n", ""))
    options[:class] ||= "add_fields"
    link_to(name, '#', options)
  end

  def article_path(article)
    path_for_article(article)
  end

  def article_url(article)
    path_for_article(article, true)
  end

  def path_for_article(article, with_host = false)
    slug = article.slug.blank? ? "#{article.id}" : "#{article.slug}"

    if with_host
      pattern_article_url(author: article.user.slug, article: slug)
    else
      pattern_article_path(author: article.user.slug, article: slug)
    end
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

    doc = Nokogiri::HTML::DocumentFragment.parse(html)

    figure_role(doc)
    code_block(doc)

    doc.to_html
  end

  def code_block(doc)
    doc.css("pre > code[class^=language]").each do |code_node|
      lang = (code_node["class"].scan(/language-([^\s]+)/).first || []).first
      highlight_code_block(code_node, lang)
    end
    
    doc.css("pre[lang] > code").each do |code_node|
      lang = code_node.parent["lang"]
      highlight_code_block(code_node, lang)
    end
  end
  
  def highlight_code_block(code_node, lang)
    pre = code_node.parent
    code_output = highlight(code_node.content, lang)
    code_doc = Nokogiri::HTML::DocumentFragment.parse(code_output)
    pre.replace code_doc.children
  end
  
  def highlight(content, lang)
    require 'pygments'
    highlighted_code = Pygments.highlight(content, :lexer => lang, :formatter => 'html', :options => {:encoding => 'utf-8'})
    str = highlighted_code.match(/<pre>(.+)<\/pre>/m)[1].to_s.gsub(/ *$/, '')
    tableize_code(str, lang)
  end
  
  def tableize_code(str, lang = '')
    line_number, code = '', ''
    # code = ''
    str.lines.each_with_index do |line, index|
      line_number += "<span class='line-number'>#{index + 1}</span>\n"
      code  += "<span class='line'>#{line}</span>"
    end
    
    table = <<HTML
<div class="highlight">
<table>
  <tr>
    <td class="lines">
      <pre class="line-numbers">#{line_number}</pre>
    </td>
    <td class="code">
      <pre><code>#{code}</code></pre>
    </td>
  </tr>
</table>
</div>
HTML
  end
  
  def figure_role(doc)
    doc.css("p[role=figure]").each do |p|
      p.remove_attribute "role"
      p.name = "figure"
      p["class"] = "thumbnail"
      p.css("em").each {|s| s.name = "figcaption" }
      p.css("strong").each {|s| s.name = "figcaption" }
    end
  end

  def article_content(body)
    content = body.content || ""
    convert = content.gsub(/\{POST_URL\}\/[^"')]+/) do |attachment_name|
      attachment_name.gsub!("{POST_URL}/", "")
      attachment = body.attachments.where(original_filename: attachment_name).first
      attachment.file.url if attachment
    end

    explain(convert)
  end
end
