class MigrateArticleVersionsContentToArticleBody < ActiveRecord::Migration

  class ArticleBody < ActiveRecord::Base
  end

  class ArticleVersion < ActiveRecord::Base
  end

  class Attachment < ActiveRecord::Base
  end

  def up
    remove_index :article_bodies, :article_id

    change_table :article_bodies do |t|
      t.rename :article_id, :postable_id
      t.string :postable_type
    end

    add_index :article_bodies, [ :postable_type, :postable_id ]

    ArticleBody.reset_column_information
    ArticleBody.update_all(postable_type: "Article")


    ArticleVersion.find_each do |version|
      body = ArticleBody.where(postable_type: "ArticleVersion", postable_id: version.id).first_or_initialize
      if body.new_record?
        body.content = version.content
        body.save

        Attachment.where(attachable_type: "ArticleVersion", attachable_id: version.id)
                  .update_all(attachable_type: "ArticleBody", attachable_id: body.id)
      end
    end

    remove_column :article_versions, :content
  end

  def down
    raise "unsupport down"
  end
end
