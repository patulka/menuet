class ShoppingListsController < ApplicationController
  def destroy
  @week_menu = WeekMenu.find(params[:week_menu_id])
  @ingredient = ShoppingList.find(params[:id])
  @ingredient.destroy
  redirect_to shopping_list_week_menu_path(@week_menu)
  end
end
