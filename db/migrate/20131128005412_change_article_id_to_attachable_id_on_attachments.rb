class ChangeArticleIdToAttachableIdOnAttachments < ActiveRecord::Migration
  def change
    remove_index :attachments, :article_id

    change_table :attachments do |t|
      t.rename :article_id, :attachable_id
      t.string :attachable_type
    end

    add_index :attachments, [ :attachable_type, :attachable_id ]
    Attachment.reset_column_information

    Attachment.update_all(attachable_type: "Article")
  end
end
