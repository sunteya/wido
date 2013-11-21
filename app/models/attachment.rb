# == Schema Information
#
# Table name: attachments
#
#  id                :integer          not null, primary key
#  original_filename :string(255)
#  file              :string(255)
#  article_id        :integer
#  created_at        :datetime
#  updated_at        :datetime
#

class Attachment < ActiveRecord::Base
  belongs_to :article
  mount_uploader :file, FileUploader
end
