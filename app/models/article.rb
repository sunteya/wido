class Article < ActiveRecord::Base
  belongs_to :user
  belongs_to :list
  acts_as_taggable
  
  has_many :attachments
  accepts_nested_attributes_for :attachments

  after_initialize :ensure_assign_user_by_list
  before_save :ensure_assign_user_by_list
  
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
