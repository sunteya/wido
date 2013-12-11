# == Schema Information
#
# Table name: article_versions
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  slug       :string(255)
#  posted_at  :datetime
#  article_id :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  body_id    :integer
#

class ArticleVersion < ActiveRecord::Base
  belongs_to :article
  belongs_to :user
  acts_as_taggable
  belongs_to :body, class_name: ArticleBody.to_s, autosave: true

  after_initialize :ensure_assign_user_by_article
  before_save :ensure_assign_user_by_article

  validates :posted_at, presence: true
  validates :title, presence: true

  def ensure_assign_user_by_article
    self.user_id = self.article.user_id if self.article
  end
end
