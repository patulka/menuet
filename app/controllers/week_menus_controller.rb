class WeekMenusController < ApplicationController
  # for now (accesses for not-logged-ins will be set later)
  skip_before_action :authenticate_user!

  # displays the saved menu plans (earlier: weeks) (saved by the create function below)
  def my_weeks
    @week_menus = current_user.week_menus

    # for display of week number on my-menu-plans page (week one on the bottom)
    @week_number = @week_menus.count
    # for display of week number in green navbar on my-menu-plans page (week one on the bottom)
    # @week_number_navbar = @week_menus.count # from x to 1
    @week_number_navbar = 1 # from 1 to x
  end


  $categories = [Ingredient.where("name = 'vegetable'")[0], Ingredient.where("name = 'fruit'")[0], Ingredient.where("name = 'spices'")[0], Ingredient.where("name = 'bread'")[0], Ingredient.where("name = 'dairy'")[0], Ingredient.where("name = 'cheese'")[0], Ingredient.where("name = 'fish'")[0], Ingredient.where("name = 'seafood'")[0], Ingredient.where("name = 'meat'")[0]]

  # creates lines in a week_menu db and menu db == saving weeks to be displayed on my-menu-plans page
  def create
    @week_menu = WeekMenu.new
    @week_menu.user = current_user
    if @week_menu.save
      params["menus"].each { |menu|
        Menu.create(week_menu: @week_menu, recipe_id: menu)
      }
      # creating shopping list
      ingredients = []
      @week_menu.recipes.each do |recipe|
        ingredients << recipe.ingredients
      end
      ingredients = ingredients.flatten.to_set

      ingredients.each do |ingredient|
        if ShoppingList.where("week_menu_id = '#{@week_menu[:id]}'").where("ingredient_id = '#{ingredient[:id]}'")== []
          ShoppingList.create(ingredient: ingredient, week_menu: @week_menu)
        end
      end
      redirect_to my_menu_plans_path
    else
      render 'weekly-menu'
    end
  end

  def shopping_list
    week_menu = WeekMenu.find(params[:id])
    if ShoppingList.where(week_menu: week_menu) == []
      ingredients = []
      week_menu.recipes.each do |recipe|
        ingredients << recipe.ingredients
      end
      ingredients = ingredients.flatten.to_set

      ingredients.each do |ingredient|
        if ShoppingList.where(week_menu: week_menu).where(ingredient: ingredient) == []
          ShoppingList.create(ingredient: ingredient, week_menu: week_menu)
        end
      end
    end
    categorized = []
    @shopping_list = $categories.map do |c|
      ret = ShoppingList.select("shopping_lists.*")
                        .where(week_menu: week_menu)
                        .where("ingredient_id IN (SELECT child_id from ingredient_relations WHERE parent_id = #{c.id})")
      ret.each { |item| categorized << item.id }
      { name: c.name, items: ret.all }
    end
    others = ShoppingList.where(week_menu: week_menu).all.reject { |item| categorized.include? item.id }
    @shopping_list << { name: "Others", items: others}
  end
end
