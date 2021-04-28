class WeekMenu < ApplicationRecord
  belongs_to :user
  has_many :menus
  has_many :recipes, through: :menus
end
