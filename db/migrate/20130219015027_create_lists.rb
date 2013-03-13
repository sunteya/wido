class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.references :user
      t.string :syscode
      t.string :name

      t.timestamps
    end
    
    add_index :lists, :user_id
    add_index :lists, [ :user_id, :syscode ]
  end
end
