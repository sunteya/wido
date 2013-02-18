class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :slug
      
      t.timestamps
    end
    
    change_table :users do |t|
      t.index :slug
    end
  end
end
