class AddPostedAtToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :posted_at, :datetime

    Article.reset_column_information
    Article.find_each do |article|
      article.posted_at = article.revised_at || article.published_at
      article.save
    end
  end
end
