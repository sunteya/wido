# == Schema Information
#
# Table name: links
#
#  id         :integer          not null, primary key
#  url        :string(255)
#  title      :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  list_id    :integer
#

class Link < ActiveRecord::Base
  belongs_to :user
  belongs_to :list
  acts_as_taggable
  
  validates :list,  presence: true
  validates :url,   presence: true
  validates :title, presence: true
  
  before_save :assign_user_by_list
  
  def assign_user_by_list
    self.user = self.list.user if self.list_id_changed?
  end

  def collection
    self.list
  end
end
