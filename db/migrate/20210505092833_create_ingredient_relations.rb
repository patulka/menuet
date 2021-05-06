class CreateIngredientRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :ingredient_relations do |t|
      t.references :child
      t.references :parent

      t.timestamps
    end
  end
end
