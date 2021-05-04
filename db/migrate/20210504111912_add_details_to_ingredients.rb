class AddDetailsToIngredients < ActiveRecord::Migration[6.0]
  def change
    add_column :ingredients, :api_id, :integer
    add_column :ingredients, :img_url, :string
  end
end
