class Recipe < ApplicationRecord
  has_many :menus

  def ingredients_list
    ingredients.split("\n")
  end
end
