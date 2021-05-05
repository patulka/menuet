import autocomplete from 'js-autocomplete';
// imports edit-distance functions
const ed = require('edit-distance');

const NUM_RESULTS = 20;
const INSERT_COST = 1;
const REMOVE_COST = 1;
const SUBSTITUTE_COST = 10;
const UNMATCH_MUTLIPLIER = 1000;
const MIDDLEMATCH_MULTIPLIER = 100;
const STARTMATCH_MULTIPLIER = 1;
const MAX_DISTANCE = UNMATCH_MUTLIPLIER * 10;


// Computes distance between two strings as a number.
const distance = (sA, sB) => {
  // remove non-alphabetic chars
  const strA = sA.toLowerCase().replace(/[^a-z]+/g, '');
  const strB = sB.toLowerCase().replace(/[^a-z]+/g, '');
  const shorter = strA.length < strB.length ? strA : strB;
  const longer = strA.length >= strB.length ? strA : strB;
  const position = longer.indexOf(shorter);
  let weight = position === -1 ? UNMATCH_MUTLIPLIER : (position === 0 ? STARTMATCH_MULTIPLIER : MIDDLEMATCH_MULTIPLIER);
  // If one is substring of another, make it appear before everything else.
  const magic = ed.levenshtein(strA, strB, () => INSERT_COST, () => REMOVE_COST, (a, b) => a !== b ? SUBSTITUTE_COST : 0);
  // Compute distance as number of operations to transform A into B multiplied by weight.
  return weight * (1 + magic.distance);
}

const autocompleteSearch = function() {
  if (document.getElementById('search-data') == null) {
    return
  }

  const INGREDIENTS = JSON.parse(document.getElementById('search-dislike-data').dataset.ingredients);

  const selectCallback = (event, ingredient) => {
    event.preventDefault(); // don't submit form on enter
    const ingredientInput = document.getElementById('q');
    const inputValue = ingredientInput.value
    const index = INGREDIENTS.indexOf(inputValue)
    if (index > -1) {
      INGREDIENTS.splice(index, 1)
    };
    const ingredientSetDiv = document.getElementById('ingredient-set');
    const ingredientSetInput = document.getElementById('ingredient-set-input');
    const ingredientSet = new Set(ingredientSetInput.value.split(','));
    // displaying ingredient above search bar and adding to query string
    if (!ingredientSet.has(ingredient)) {
      ingredientSet.add(ingredient);
      ingredientSetInput.value = Array.from(ingredientSet).filter(x => x).join(',');
      ingredientSetDiv.innerHTML += '<span>' + ingredient + '</span> ';
      ingredientInput.value = '';
    }
   };


  const xselectCallback = (event, ingredient) => {
    event.preventDefault(); // don't submit form on enter
    const ingredientXInput = document.getElementById('x');
    const inputXValue = ingredientXInput.value
    const index = INGREDIENTS.indexOf(inputXValue)
    if (index > -1) {
      INGREDIENTS.splice(index, 1)
    };
    const ingredientXSetDiv = document.getElementById('ingredient-dislike-set');
    const ingredientXSetInput = document.getElementById('ingredient-dislike-set-input');
    const ingredientXSet = new Set(ingredientXSetInput.value.split(','));
    // displaying ingredient above search bar and adding to query string
    if (!ingredientXSet.has(ingredient)) {
      ingredientXSet.add(ingredient);
      ingredientXSetInput.value = Array.from(ingredientXSet).filter(x => x).join(',');
      ingredientXSetDiv.innerHTML += '<span>' + ingredient + '</span> ';
      ingredientXInput.value = '';
    }
   };

  const XsearchInput = document.getElementById('x');

  if (INGREDIENTS && XsearchInput) {
    new autocomplete({
      selector: XsearchInput,
      minChars: 1,
      delay: 50,
      cache: false,
      onSelect: xselectCallback,
      source: function(input, suggest) {
        // map ingredients to name and distance (from searched input)
        let choices = INGREDIENTS.map(ingredient => {
          return {
            'ingredient': ingredient,
            'distance': distance(input, ingredient),
          }
        });
        // sorting ascending by distance
        choices = choices.filter(choice => choice['distance'] < MAX_DISTANCE)
        choices.sort((c1, c2) => c1['distance'] - c2['distance']);
        const matches = choices.slice(0, NUM_RESULTS).map(choice => choice['ingredient']);
        suggest(matches);
      },
    });
  }



  const searchInput = document.getElementById('q');

  if (INGREDIENTS && searchInput) {
    new autocomplete({
      selector: searchInput,
      minChars: 1,
      delay: 50,
      cache: false,
      onSelect: selectCallback,
      source: function(input, suggest) {
        // map ingredients to name and distance (from searched input)
        let choices = INGREDIENTS.map(ingredient => {
          return {
            'ingredient': ingredient,
            'distance': distance(input, ingredient),
          }
        });
        // sorting ascending by distance
        choices = choices.filter(choice => choice['distance'] < MAX_DISTANCE)
        choices.sort((c1, c2) => c1['distance'] - c2['distance']);
        const matches = choices.slice(0, NUM_RESULTS).map(choice => choice['ingredient']);
        suggest(matches);
      },
    });
  }
};

export { autocompleteSearch};
