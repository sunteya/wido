class AddStateToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :state, :string
    Article.update_all state: "published"
  end
end
