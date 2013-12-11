# == Schema Information
#
# Table name: users
#
#  id                   :integer          not null, primary key
#  slug                 :string(255)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  email                :string(255)      default(""), not null
#  encrypted_password   :string(255)      default(""), not null
#  remember_created_at  :datetime
#  sign_in_count        :integer          default(0)
#  current_sign_in_at   :datetime
#  last_sign_in_at      :datetime
#  current_sign_in_ip   :string(255)
#  last_sign_in_ip      :string(255)
#  authentication_token :string(255)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :database_authenticatable, :recoverable, :registerable, :validatable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :token_authenticatable, :rememberable, :trackable, 
         :omniauthable, :omniauth_providers => [ :google_oauth2 ]

  has_many :links
  has_many :lists
  has_many :articles
  has_many :article_bodies

  before_save :ensure_authentication_token

  validates :slug, presence: true, uniqueness: true, format: { with: /\w+/ }, if: :require_profile_completed?

  def require_profile_completed?
    !!@require_profile_completed
  end

  def require_profile_completed!
    @require_profile_completed = true
  end

  def profile_completed?
    self.require_profile_completed!
    self.valid?
  end

  def inbox
    collation = Collation.new
    collation.user = self
    collation.id   = 'inbox'
    collation
  end

end
