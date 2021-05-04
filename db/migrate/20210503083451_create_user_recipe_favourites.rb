class CreateUserRecipeFavourites < ActiveRecord::Migration[6.0]
  def change
    create_table :user_recipe_favourites do |t|
      t.references :recipe, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
