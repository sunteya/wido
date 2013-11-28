# == Schema Information
#
# Table name: article_versions
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  slug       :string(255)
#  content    :text
#  posted_at  :datetime
#  article_id :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class ArticleVersions < ActiveRecord::Base
  belongs_to :article
  belongs_to :user
  acts_as_taggable
  has_many :attachments, as: :attachable

  after_initialize :ensure_assign_user_by_article
  before_save :ensure_assign_user_by_article

  def ensure_assign_user_by_article
    self.user ||= self.article.user if self.article
  end
end
