rel('gluten free flour', 'flour')
rel('steak', 'red meat')
rel('salt', 'salt and pepper')
rel('pepper', 'salt and pepper')
get_siblings('flour').each { |x| rem('flour', x.name) }
get_siblings('oil').each { |x| rem('oil', x.name) }

- del side-dish -> gluten-free
- del cooking-fat -> meat
- del vegetable -> veegatble-mix
