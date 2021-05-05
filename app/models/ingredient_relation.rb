class IngredientRelation < ApplicationRecord
  belongs_to :child, class_name: "Ingredient"
  belongs_to :parent, class_name: "Ingredient"
end
