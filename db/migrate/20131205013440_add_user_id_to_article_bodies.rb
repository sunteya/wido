class AddUserIdToArticleBodies < ActiveRecord::Migration

  class ArticleBody < ActiveRecord::Base
  end

  class ArticleVersion < ActiveRecord::Base
  end

  class Article < ActiveRecord::Base
  end

  def change
    change_table :article_bodies do |t|
      t.belongs_to :user
    end

    ArticleBody.reset_column_information

    ArticleBody.where(postable_type: "ArticleVersion").find_each do |body|
      version = ArticleVersion.find(body.postable_id)
      body.user_id = version.user_id
      body.save
    end

    ArticleBody.where(postable_type: "Article").find_each do |body|
      version = Article.find(body.postable_id)
      body.user_id = version.user_id
      body.save
    end
  end
end
