class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :original_filename
      t.string :file
      t.belongs_to :article

      t.timestamps
    end

    add_index :attachments, :original_filename
    add_index :attachments, :article_id
  end
end
