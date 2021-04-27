class MenusController < ApplicationController
  skip_before_action :authenticate_user!

  def weekly_menu
    @menus = Recipe.all.sample(7)
  end

  def save_week

  end
end
