class CreateArticleVersions < ActiveRecord::Migration
  def change
    create_table :article_versions do |t|
      t.string :title
      t.string :slug
      t.text :content
      t.datetime :posted_at

      t.belongs_to :article
      t.belongs_to :user

      t.timestamps
    end

    add_index :article_versions, :article_id
    add_index :article_versions, :slug
  end
end
