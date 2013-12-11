class ReverseArticleVersionBodyReferences < ActiveRecord::Migration
  class ArticleBody < ActiveRecord::Base
  end

  class ArticleVersion < ActiveRecord::Base
  end

  def change

    change_table :article_versions do |t|
      t.belongs_to :body, index: true
    end

    ArticleBody.where(postable_type: "ArticleVersion").find_each do |body|
      article_version = ArticleVersion.where(id: body.postable_id).first

      if article_version
        article_version.body_id = body.id
        article_version.save!
      end
    end
    
  end
end
