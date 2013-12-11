# == Schema Information
#
# Table name: article_bodies
#
#  id            :integer          not null, primary key
#  content       :text
#  context       :string(255)
#  postable_id   :integer
#  posted_at     :datetime
#  created_at    :datetime
#  updated_at    :datetime
#  postable_type :string(255)
#  user_id       :integer
#

class ArticleBody < ActiveRecord::Base
  belongs_to :postable, polymorphic: true
  belongs_to :user
  acts_as_taggable
  has_many :attachments, as: :attachable, autosave: true
  accepts_nested_attributes_for :attachments, allow_destroy: true

  before_save :ensure_assign_user_by_postable

  def ensure_assign_user_by_postable
    self.user_id = self.postable.user_id if self.postable
  end

  def self.duplicate!(source, override_attributes = {})
    target = self.new
    target.attributes = source.attributes.reject { |k| %w[ id updated_at created_at ].include?(k) }
    target.attributes = override_attributes

    source.attachments.each do |attachment|
      target.attachments.build(
        original_filename: attachment.original_filename,
        file: attachment.file
      )
    end

    target.save
    target
  end
end
