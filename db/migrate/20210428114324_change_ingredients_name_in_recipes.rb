class ChangeIngredientsNameInRecipes < ActiveRecord::Migration[6.0]
  def change
    rename_column :recipes, :ingredients, :ingredients_string
  end
end
