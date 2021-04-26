class Menu < ApplicationRecord
  belongs_to :recipe
  belongs_to :user, through: :week_menu
end
