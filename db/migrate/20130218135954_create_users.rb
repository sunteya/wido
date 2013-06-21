class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :slug
      
      t.timestamps
    end
    
    add_index :users, :slug
  end
end
