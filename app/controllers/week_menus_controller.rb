class WeekMenusController < ApplicationController
  # for now (accesses for not-logged-ins will be set later)
  skip_before_action :authenticate_user!


  # displays all the weeks the user saved (by the create function)
  def my_weeks
    @recipes = current_user.recipes
  end

  # creates a week == saves it to the user and displays it in my_weeks
  def create
    @week_menu = WeekMenu.new
    @week_menu.user = current_user
    if @week_menu.save
      params["menus"].each { |menu|
        Menu.create(week_menu: @week_menu, recipe_id: menu)
      }
      redirect_to my_weeks_path(@booking)
    else
      render 'weekly-menu'
    end
  end

end
