# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  slug                   :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  authentication_token   :string(255)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :token_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :links
  has_many :lists

  before_save :ensure_authentication_token

  # validates :slug, :presence => true, :uniqueness => true
  
  def inbox
    collation = Collation.new
    collation.user = self
    collation.id   = 'inbox'
    collation
  end

end
