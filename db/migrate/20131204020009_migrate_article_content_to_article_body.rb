class MigrateArticleContentToArticleBody < ActiveRecord::Migration
  class Article < ActiveRecord::Base
  end

  class ArticleBody <  ActiveRecord::Base
  end

  class Attachment < ActiveRecord::Base
  end

  def up
    Article.find_each do |article|
      body = ArticleBody.where(article_id: article.id, context: "current").first_or_initialize
      if body.new_record?
        body.content = article.content
        body.save

        Attachment.where(attachable_type: "Article", attachable_id: article.id)
                  .update_all(attachable_type: "ArticleBody", attachable_id: body.id)
      end
    end

    remove_column :articles, :content
  end

  def down
    raise "unsupport down"
  end
end
