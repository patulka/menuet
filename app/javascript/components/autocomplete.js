import autocomplete from 'js-autocomplete';

const autocompleteSearch = function() {
  const ingredients = JSON.parse(document.getElementById('search-data').dataset.ingredients)
  const searchInput = document.getElementById('q');

  if (ingredients && searchInput) {
    new autocomplete({
      selector: searchInput,
      minChars: 1,
      source: function(term, suggest){
          term = term.toLowerCase();
          const choices = ingredients;
          const matches = [];
          for (let i = 0; i < choices.length; i++)
              if (~choices[i]['name'].toLowerCase().indexOf(term)) matches.push(choices[i]['name']);
          suggest(matches);
      },
    });
  }
};

export { autocompleteSearch};
