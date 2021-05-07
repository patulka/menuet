# turn off sql logging
ActiveRecord::Base.logger = nil

$ADDED_RELATIONS = 0

def add_relation(child, parent)
  if IngredientRelation.where(child: child, parent: parent).empty?
    IngredientRelation.create(child: child, parent: parent)
    $ADDED_RELATIONS += 1
    puts "\tAdd #{child.name} -> #{parent.name}"
  end
end

def remove_relation(child, parent)
  unless IngredientRelation.where(child: child, parent: parent).empty?
    IngredientRelation.where(child: child, parent: parent)[0].destroy
    puts "\tRemove #{child.name} -> #{parent.name}"
  end
end

def ingr_from_name(name)
  name = name.downcase
  ret = Ingredient.where(ActiveRecord::Base::sanitize_sql_array(['name = ?', name]))[0]
  raise "#{name} not found" unless ret

  ret
end

def get_parents(name)
  ingr_from_name(name).parents.reject { |x| x.name == name}
end

def get_children(name)
  ingr_from_name(name).children.reject { |x| x.name == name}
end

def get_siblings(name)
  parents = get_parents(name)
  get_children(name).select { |x| parents.include? x }
end


def rel(ingr_name_1, ingr_name_2)
  child = ingr_from_name(ingr_name_1)
  parent = ingr_from_name(ingr_name_2)
  # any child of child gets any parent of parent
  parent.parents.each { |parent2|
    child.children.each { |child2|
      add_relation(child2, parent2)
    }
  }
  nil
end

def rem(ingr_name_1, ingr_name_2)
  child = ingr_from_name(ingr_name_1)
  parent = ingr_from_name(ingr_name_2)
  remove_relation(child, parent)
end

def remove_all(ingr_name_1, ingr_name_2)
  child = ingr_from_name(ingr_name_1)
  parent = ingr_from_name(ingr_name_2)
  # any child of child gets any parent of parent
  parent.parents.each { |parent2|
    child.children.each { |child2|
      remove_relation(child2, parent2)
    }
  }
  nil

end

def repair_transitive_relations
  IngredientRelation.all.each do |item|
    next if item.child.id == item.parent.id
    old = $ADDED_RELATIONS
    rel(item.child.name, item.parent.name)
    if old != $ADDED_RELATIONS
      puts "ADDED #{$ADDED_RELATIONS-old} WHEN REPAIRING #{item.child.name} -> #{item.parent.name}"
    end
  end
end
