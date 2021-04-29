class MenusController < ApplicationController
  skip_before_action :authenticate_user!

  def weekly_menu
    # puts all searched ingredients (that are not an empty string) to one array
    query_list = ([params[:q]] + params[:qq].split(',')).reject { |q| q == "" }
    menus_match = []
    unless query_list.empty?
      # sql query to find all recipes which has at least one of the searched ingredients
      sql_like = query_list.map { |q| "ingredients.name LIKE \'%#{q}\'"}.join(' OR ')
      # set of recipes with searched ingredients
      menus_match = sample_from_db(RecipeIngredient.joins(:ingredient)
                      .where(sql_like)
                      .joins(:recipe), 7)
                    .map { |x| x.recipe } # selecting just recipe from join table
    end
    # set of recipes without searched ingredients
    menus_rand = sample_from_db(Recipe, 7 - menus_match.count)
    # all 7 recipes together
    @menus = menus_match + menus_rand

    @counter = 0
  end

  private
  # selecting number of recipes (query) which has an imgae (img_url is not empty)
  def sample_from_db(query, number)
    query.where("COALESCE(TRIM(img_url, '')) != ''").order('RANDOM()').limit(number)
  end
end
