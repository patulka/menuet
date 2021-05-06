# turn off sql logging
ActiveRecord::Base.logger = nil

def add_relation(child, parent)
  if IngredientRelation.where(child: child, parent: parent).empty?
    IngredientRelation.create(child: child, parent: parent)
    puts "#{child.name}, #{parent.name}"
  end
end

def ingr_from_name(name)
  name = name.downcase
  ret = Ingredient.where(ActiveRecord::Base::sanitize_sql_array(['name = ?', name]))[0]
  raise "#{name} not found" unless ret

  ret
end

def rel(ingr_name_1, ingr_name_2)
  child = ingr_from_name(ingr_name_1)
  parent = ingr_from_name(ingr_name_2)
  add_relation(child, parent)
  child.children.each { |child2| add_relation(child2, parent) }
  puts "Done"
end
