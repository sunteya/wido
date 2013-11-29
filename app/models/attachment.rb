# == Schema Information
#
# Table name: attachments
#
#  id                :integer          not null, primary key
#  original_filename :string(255)
#  file              :string(255)
#  attachable_id     :integer
#  created_at        :datetime
#  updated_at        :datetime
#  attachable_type   :string(255)
#

class Attachment < ActiveRecord::Base
  belongs_to :article, polymorphic: true
  mount_uploader :file, FileUploader
end
