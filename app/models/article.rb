# == Schema Information
#
# Table name: articles
#
#  id                :integer          not null, primary key
#  title             :string(255)
#  slug              :string(255)
#  user_id           :integer
#  list_id           :integer
#  created_at        :datetime
#  updated_at        :datetime
#  disqus_identifier :string(255)
#  published_at      :datetime
#  revised_at        :datetime
#  state             :string(255)
#  posted_at         :datetime
#  body_id           :integer
#  editing_id        :integer
#

class Article < ActiveRecord::Base
  belongs_to :list
  belongs_to :user

  acts_as_taggable
  symbolize :state, in: [ :draft, :published, :archived ], scopes: true, default: :draft, methods: true
  
  belongs_to :body, class_name: ArticleBody.to_s
  accepts_nested_attributes_for :body

  attr_accessor :editing_body_id
  # belongs_to :editing, class_name: ArticleBody.to_s  

  has_many :versions, class_name: ArticleVersion.to_s, autosave: true

  after_initialize :ensure_assign_user_by_list
  before_save :ensure_assign_user_by_list

  after_initialize :build_body, unless: ->(m) { m.body_id }
  before_save :update_posted_at

  before_validation :migrate_editing_body if :editing_body_id

  validates :title, presence: true
  validates :state, presence: true
  validates :posted_at, presence: true, if: :published?
  
  scope :published, -> { state(:published).reorder(posted_at: :desc) }

  def build_body
    body = super
    body.user_id = self.user_id if self.user_id
    body
  end

  def migrate_editing_body
    editing_body = self.user.article_bodies.find(self.editing_body_id)
    self.body = editing_body
  end

  def persisted_editing!
    ArticleBody.duplicate!(self.body)
  end

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

  attr_reader :snapshot
  attr_accessor :store_snapshot_to_version
  before_validation :append_snapshot_to_versions, if: :store_snapshot_to_version?

  def store_snapshot_to_version?
    ActiveRecord::ConnectionAdapters::Column.value_to_boolean(store_snapshot_to_version)
  end

  def append_snapshot_to_versions
    self.versions << @snapshot if @snapshot
  end

  def taken_snapshot
    @snapshot = self.versions.scope.new(
      title:     self.title,
      slug:      self.slug,
      tag_list:  self.tag_list,
      posted_at: self.posted_at,
    )

    @snapshot.body = ArticleBody.duplicate(self.body)
    @snapshot
  end

  def snapshot_attributes=(values)
    @snapshot.attributes = values
  end

end
