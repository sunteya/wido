class AddDisqusIdentifierToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :disqus_identifier, :string
  end
end
