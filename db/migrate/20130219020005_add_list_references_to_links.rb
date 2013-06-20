class AddListReferencesToLinks < ActiveRecord::Migration
  def change
    change_table :links do |t|
      t.references :list
    end
  end
end
