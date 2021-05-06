class WeekMenu < ApplicationRecord
  belongs_to :user

  has_many :menus
  has_many :recipes, through: :menus

  has_many :shopping_lists
  has_many :ingredients, through: :shopping_lists
end
