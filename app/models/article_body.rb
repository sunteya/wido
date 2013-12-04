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
#

class ArticleBody < ActiveRecord::Base
  belongs_to :article
  acts_as_taggable
  has_many :attachments, as: :attachable, autosave: true
  accepts_nested_attributes_for :attachments, allow_destroy: true
end
