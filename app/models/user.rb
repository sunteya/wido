# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  slug       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  has_many :links
  has_many :lists
  
  def inbox
    self.lists.where(syscode: 'inbox').first_or_create
  end
end
