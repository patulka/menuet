class WeekMenusController < ApplicationController
  # for now (accesses for not-logged-ins will be set later)
  skip_before_action :authenticate_user!

  # displays the recipes the user saved while saving the week_menu (by the create function below)
  # grouped by weeks (NB! GROUPING CURRENTLY MISSING)
  def my_weeks
    @recipes = current_user.recipes

    @week_menus = current_user.week_menus
  end

  # creates lines in a week_menu db and menu db == saving weeks to be displaied it in my_weeks
  def create
    @week_menu = WeekMenu.new
    @week_menu.user = current_user
    if @week_menu.save
      params["menus"].each { |menu|
        Menu.create(week_menu: @week_menu, recipe_id: menu)
      }
      redirect_to my_weeks_path
    else
      render 'weekly-menu'
    end
  end

end
