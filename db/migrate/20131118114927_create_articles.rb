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
  end
end
