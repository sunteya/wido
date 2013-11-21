# == Schema Information
#
# Table name: articles
#
#  id                :integer          not null, primary key
#  title             :string(255)
#  slug              :string(255)
#  content           :text
#  user_id           :integer
#  list_id           :integer
#  created_at        :datetime
#  updated_at        :datetime
#  disqus_identifier :string(255)
#  published_at      :datetime
#  revised_at        :datetime
#  state             :string(255)
#

class Article < ActiveRecord::Base
  belongs_to :user
  belongs_to :list
  acts_as_taggable
  
  has_many :attachments
  accepts_nested_attributes_for :attachments, allow_destroy: true

  after_initialize :ensure_assign_user_by_list
  before_save :ensure_assign_user_by_list

  validates :published_at, presence: true
  
  def ensure_assign_user_by_list
    self.user ||= self.list.user if self.list_id_changed?
  end

  def collection
    self.list
  end

  def author
    self.user
  end
end
