class MenusController < ApplicationController
  skip_before_action :authenticate_user!

  def weekly_menu
    query_list = ([params[:q]] + params[:qq].split(',')).reject { |q| q == "" }
    menus_match = []
    unless query_list.empty?
      sql_like = query_list.map { |q| "ingredients.name LIKE \'%#{q}\'"}.join(' OR ')
      menus_match = RecipeIngredient.joins(:ingredient)
                .where(sql_like)
                .joins(:recipe).all.sample(7).map { |x| x.recipe }
    end
    menus_rand = Recipe.all.sample(7 - menus_match.count)
    @menus = menus_match + menus_rand

    @counter = 0
  end
end
