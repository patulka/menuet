class ShoppingList < ApplicationRecord
  belongs_to :ingredient
  belongs_to :week_menu
end
