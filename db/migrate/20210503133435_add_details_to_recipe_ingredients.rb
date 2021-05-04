class AddDetailsToRecipeIngredients < ActiveRecord::Migration[6.0]
  def change
    add_column :recipe_ingredients, :amount, :integer
    add_column :recipe_ingredients, :unit, :string
  end
end
