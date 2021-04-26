class AddDetailsToRecipes < ActiveRecord::Migration[6.0]
  def change
    add_column :recipes, :img_url, :string
    add_column :recipes, :time, :integer
    add_column :recipes, :instructions, :string
    add_column :recipes, :url, :string
    add_column :recipes, :author, :string
    add_column :recipes, :ingredients, :string
  end
end
