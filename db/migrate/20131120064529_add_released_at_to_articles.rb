class AddReleasedAtToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :published_at, :datetime
    add_column :articles, :revised_at, :datetime
  end
end
