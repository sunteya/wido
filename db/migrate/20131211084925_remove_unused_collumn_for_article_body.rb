class RemoveUnusedCollumnForArticleBody < ActiveRecord::Migration
  def change
    remove_column :articles, :editing_id

    remove_column :article_bodies, :context
    remove_column :article_bodies, :postable_type
    remove_column :article_bodies, :postable_id
  end
end
