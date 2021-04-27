class Menu < ApplicationRecord
  belongs_to :recipe
  belongs_to :week_menu
end
