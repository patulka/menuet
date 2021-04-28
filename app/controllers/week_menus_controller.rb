class WeekMenusController < ApplicationController
  # for now (accesses for not-logged-ins will be set later)
  skip_before_action :authenticate_user!

  # displays the saved menu plans (earlier: weeks) (saved by the create function below)
  def my_weeks
    @week_menus = current_user.week_menus

    # for display of week number on my-menu-plans page (week one on the bottom)
    @week_number = @week_menus.count
  end

  # creates lines in a week_menu db and menu db == saving weeks to be displayed on my-menu-plans page
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
