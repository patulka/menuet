class RenameImgUrlInIngredients < ActiveRecord::Migration[6.0]
  def change
    rename_column :ingredients, :img_url, :img_url_ingr
  end
end
