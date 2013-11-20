class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :slug
      t.text :content
      t.belongs_to :user
      t.belongs_to :list

      t.timestamps
    end

    add_index :articles, :slug
    add_index :articles, :user_id
    add_index :articles, :list_id
  end
end
