class AddUserIdToArticleBodies < ActiveRecord::Migration
  def change
    change_table :article_bodies do |t|
      t.belongs_to :user
    end

    ArticleBody.reset_column_information

    ArticleBody.find_each do |body|
      body.save
    end
  end
end
