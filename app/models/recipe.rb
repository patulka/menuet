class Recipe < ApplicationRecord
  has_many :menus
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients

  def ingredients_list
    ingredients_string.split("\n")
  end
end
