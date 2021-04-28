class MenusController < ApplicationController
  skip_before_action :authenticate_user!

  def weekly_menu
    if params[:qq].present?
      menus_match = RecipeIngredient.joins(:ingredient)
                .where("ingredients.name LIKE \'%#{params[:qq]}\'")
                .joins(:recipe).all.sample(7).map { |x| x.recipe }
      menus_rand = Recipe.all.sample(7 - menus_match.count)
      @menus = menus_match + menus_rand
    else
      @menus = Recipe.all.sample(7)
    end
    @counter = 0
  end
end
