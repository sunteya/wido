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
    collation = Collation.new
    collation.user = self
    collation.id   = 'inbox'
    collation
  end


end