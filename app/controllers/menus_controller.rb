class MenusController < ApplicationController
  skip_before_action :authenticate_user!

  def weekly_menu
    if params[:search].present?
      @menus = Recipe.all.sample(7)
    else
      @menus = Recipe.all.sample(7)
    end
  end
end
