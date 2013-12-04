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
  
  has_one :current, -> { where(context: "current") }, class_name: ArticleBody.to_s, as: :postable
  accepts_nested_attributes_for :current
  after_initialize :build_current, unless: :current

  has_one :editing, -> { where(context: "editing") }, class_name: ArticleBody.to_s
  has_many :archives, -> { where(context: "archive") }, class_name: ArticleBody.to_s

  has_many :versions, class_name: ArticleVersion.to_s, autosave: true

  after_initialize :ensure_assign_user_by_list
  before_save :ensure_assign_user_by_list
  before_save :update_posted_at

  validates :title, presence: true
  validates :state, presence: true
  validates :posted_at, presence: true, if: :published?
  
  default_scope -> { joins(:current).includes(:current) }
  
  scope :published, -> { state(:published).reorder(posted_at: :desc) }

  def editing=(value)
    value.attributes = association(:editing).scope.scope_attributes
    association(:editing).writer(value)
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

  def content
    self.current.content
  end

  def attachments
    self.current.attachments
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

    body = @snapshot.build_body(content: self.content)

    self.attachments.each do |attachment|
      body.attachments.build(
        original_filename: attachment.original_filename,
        file: attachment.file
      )
    end
  end

  def snapshot_attributes=(values)
    @snapshot.attributes = values
  end

end
