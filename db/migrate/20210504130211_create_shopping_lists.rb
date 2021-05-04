class CreateShoppingLists < ActiveRecord::Migration[6.0]
  def change
    create_table :shopping_lists do |t|
      t.references :ingredient, null: false, foreign_key: true
      t.references :week_menu, null: false, foreign_key: true

      t.timestamps
    end
  end
end
