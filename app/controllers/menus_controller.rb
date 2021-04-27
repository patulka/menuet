class MenusController < ApplicationController
  skip_before_action :authenticate_user!

  def weekly_menu
    if params[:search].present?
      @menu = SpoonacularHelper.get_random(7)
    else
      @menu = SpoonacularHelper.get_random(7)
    end
  end
end
