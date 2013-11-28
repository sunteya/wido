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
#  posted_at         :datetime
#

class Article < ActiveRecord::Base
  belongs_to :user
  belongs_to :list
  acts_as_taggable
  symbolize :state, in: [ :draft, :published, :archived ], scopes: true, default: :draft, methods: true
  
  has_many :attachments, as: :attachable
  accepts_nested_attributes_for :attachments, allow_destroy: true

  after_initialize :ensure_assign_user_by_list
  before_save :ensure_assign_user_by_list
  before_save :update_posted_at

  validates :title, presence: true
  validates :state, presence: true
  validates :posted_at, presence: true, if: :published?
  

  scope :published, -> { state(:published).reorder(posted_at: :desc) }

  def ensure_assign_user_by_list
    self.user ||= self.list.user if self.list_id_changed?
  end
  
  def update_posted_at
    if self.published_at.nil?
      self.published_at = self.posted_at
    else
      self.revised_at = self.posted_at
    end
  end

  def collection
    self.list
  end

  def author
    self.user
  end
end
