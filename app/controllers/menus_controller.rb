class MenusController < ApplicationController
  skip_before_action :authenticate_user!

  def get_sql_ids(ingr_list)
    if ingr_list.empty?
      ""
    else
      id_list = ingr_list.map { |q| Ingredient.where("name = '#{q}'")[0] }
                         .select { |x| x }
                         .map { |ingredient| ingredient.id }
                         .join(',')
      "parent_id IN (#{id_list})"
    end
  end

  # filtering out recipes with avoided ingredients and selecting recipes with wanted ingredients
  def get_having_sql(sql_ids, incl)
    if sql_ids == ""
      ""
    else
      "COUNT(CASE WHEN #{sql_ids} THEN 1 ELSE NULL END)#{incl ? '>' : '='}0"
    end
  end

  def weekly_menu
    # puts all searched ingredients (that are not an empty string) to one array
    negative_query_list = ([params[:x]] + params[:xx].split(',')).reject { |x| x == "" }
    sql_exclude_ids = get_sql_ids(negative_query_list)
    sql_exclude_having = get_having_sql(sql_exclude_ids, false)

    # puts all searched ingredients (that are not an empty string) to one array
    query_list = ([params[:q]] + params[:qq].split(',')).reject { |q| q == "" }
    sql_include_ids = get_sql_ids(query_list)
    sql_include_having = get_having_sql(sql_include_ids, true)

    having_sql = [sql_exclude_having, sql_include_having].reject { |x| x == "" }.join(' AND ')

    # we fetch from db 21 recipes (not only 7 as before) to be able to shuffle the recipes
    menus_match = sample_from_db(RecipeIngredient
                    .select(:recipe_id)
                    .joins("JOIN ingredient_relations ON recipe_ingredients.ingredient_id = ingredient_relations.child_id") # connecting ingredient_id with child_id
                    .group(:recipe_id)
                    .having(having_sql)
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
      if (index == 0 || (index) % 3 == 0)
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
