class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @ingredients = Ingredient.all.map { |ingredient| ingredient['name'] }
  end
end
