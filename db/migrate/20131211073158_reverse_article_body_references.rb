class ReverseArticleBodyReferences < ActiveRecord::Migration

  class ArticleBody < ActiveRecord::Base
  end

  class Article < ActiveRecord::Base
  end

  def change
    change_table :articles do |t|
      t.belongs_to :body, index: true
      t.belongs_to :editing, index: true
    end
    Article.reset_column_information

    ArticleBody.where(postable_type: "Article", context: "current").find_each do |body|
      article = Article.where(id: body.postable_id).first

      if article
        article.body_id = body.id
        article.save!
      end
    end
    
  end
end
