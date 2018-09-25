class CreateGroceryLists < ActiveRecord::Migration
  def change
    create_table :grocery_lists do |t|
      t.string :store_name
      t.string :item_list
    end
  end
end
