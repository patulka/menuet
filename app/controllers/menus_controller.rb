class MenusController < ApplicationController
  skip_before_action :authenticate_user!

  def weekly_menu
    if params[:search].present?
      @menu = Recipe.all.sample(7)
    else
      @menu = Recipe.all.sample(7)
    end
  end

  def save_week
  end
end
