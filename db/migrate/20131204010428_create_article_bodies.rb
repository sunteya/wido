class CreateArticleBodies < ActiveRecord::Migration
  def change
    create_table :article_bodies do |t|
      t.text :content

      t.string :context, index: true
      t.belongs_to :article, index: true

      t.datetime :posted_at

      t.timestamps
    end
  end
end
