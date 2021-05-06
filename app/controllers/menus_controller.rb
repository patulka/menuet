class MenusController < ApplicationController
  skip_before_action :authenticate_user!

  def weekly_menu
    # puts all searched ingredients (that are not an empty string) to one array
    negative_query_list = ([params[:x]] + params[:xx].split(',')).reject { |x| x == "" }
    if negative_query_list.empty?
      sql_not_like = ""
    else
      sql_not_like = negative_query_list.map { |q| "ingredients.name NOT LIKE \'%#{q}%\'"}.join(' AND ')
    end

    # puts all searched ingredients (that are not an empty string) to one array
    query_list = ([params[:q]] + params[:qq].split(',')).reject { |q| q == "" }
    menus_match = []
    if query_list.empty?
      sql_like = ""
    else
      # sql query to find all recipes which has at least one of the searched ingredients
      sql_like = query_list.map { |q| "ingredients.name LIKE \'%#{q}%\'"}.join(' OR ')
      # set of recipes with searched ingredients
    end

    # we fetch from db 21 recipes (not only 7 as before) to be able to shuffle the recipes
    menus_match = sample_from_db(RecipeIngredient.joins(:ingredient)
                      .where(sql_not_like).where(sql_like)
                      .joins(:recipe), 21)
                    .map { |x| x.recipe } # selecting just recipe from join table

    # set of recipes without searched ingredients
    # (for the case we dont have enough recipes complying the search)
    menus_rand = sample_from_db(Recipe, 21 - menus_match.count)
    # 21 recipes
    @menus = menus_match + menus_rand

    # backup in case JS does not work -- first option for the particular day to be passed to the save button
    @menus_first_option = []
    @menus.each_with_index do |menu, index|
      if (index == 0 || (index) % 3 == 0 )
        @menus_first_option << menu
      end
    end

    # 21 recipes distributed in days (3 recipes == 3 options per day)
    @days = []
    (0..6).each do |day| # 7 days
      menus = []
      (0..2).each do |menu|
        menus << @menus[day * 3 + menu] # 3 options
      end
      # array with 7 elements of arrays of 3 elements
      @days << menus
    end

    # saving the users queries, to be able to use them for "Give me different weekly menu"
    @params_q = params[:q]
    @params_qq = params[:qq]
    @params_x = params[:x]
    @params_xx = params[:xx]

    @counter = 0
  end

  private
  # selecting number of recipes (query) which has an imgae (img_url is not empty)
  def sample_from_db(query, number)
    query.where("COALESCE(TRIM(img_url, '')) != ''").order('RANDOM()').limit(number)
  end

end
