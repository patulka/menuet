get_siblings('flour').each { |x| rem('flour', x.name) }
get_siblings('oil').each { |x| rem('oil', x.name) }
rel('gluten free flour', 'flour')
rel('steak', 'red meat')
rel('salt', 'salt and pepper')
rel('pepper', 'salt and pepper')
rel('olive oil', 'oil')
rel('vegetable oil', 'oil')
rel('sweet italian pork sausage', 'italian pork sausage')
rel('italian pork sausage', 'sausage')
rel('ranch steak', 'steak')


rel('new york strip steak', 'steak')
rel('garlic', 'vegetable')
rel('southwest spice blend', 'spices')
rel('tuscan heat spice', 'spices')
rel('fry seasoning', 'spices')
rel('mexican spice blend', 'spices')
rel('crème fraîche', 'dairy')
rel('skin-on salmon', 'fish')
rel('pepper jack cheese', 'cheese')
rel('boneless pork chops', 'pork')
rel('ribeye', 'beef')
rel('beef sirloin tips', 'beef')
rel('cheese', 'dairy')

rel('garlic herb butter', 'butter')

rel('scallions', 'vegetable')

rel('cilantro', 'herbs')

rel('onion', 'vegetable')
rel('sweet potato', 'vegetable')

staples = Ingredient.create(name: 'staples')
IngredientRelation.create(child: staples, parent: staples)
rel('flour', 'staples')
rel('rice', 'staples')
rel('pasta', 'staples')
rel('sugar', 'staples')
rel('oil', 'staples')

