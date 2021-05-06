class Ingredient < ApplicationRecord
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients

  has_many :child_relations, class_name: 'IngredientRelation', foreign_key: 'parent_id', dependent: :destroy
  has_many :children, through: :child_relations

  has_many :parent_relations, class_name: 'IngredientRelation', foreign_key: 'child_id', dependent: :destroy
  has_many :parents, through: :parent_relations
end
