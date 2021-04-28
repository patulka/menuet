import autocomplete from 'js-autocomplete';
// imports edit-distance functions
const ed = require('edit-distance');

const NUM_RESULTS = 20;
const INSERT_COST = 1;
const REMOVE_COST = 1;
const SUBSTITUTE_COST = 10;
const UNMATCH_MUTLIPLIER = 100;
const MAX_DISTANCE = UNMATCH_MUTLIPLIER * 10;

// Computes distance between two strings as a number.
const distance = (sA, sB) => {
  // remove non-alphabetic chars
  const strA = sA.toLowerCase().replace(/[^a-z]+/g, '');
  const strB = sB.toLowerCase().replace(/[^a-z]+/g, '');
  const shorter = strA.length < strB.length ? strA : strB;
  const longer = strA.length >= strB.length ? strA : strB;
  let weight = longer.indexOf(shorter) === -1 ? UNMATCH_MUTLIPLIER : 1;
  // If one is substring of another, make it appear before everything else.
  const magic = ed.levenshtein(strA, strB, () => INSERT_COST, () => REMOVE_COST, (a, b) => a !== b ? SUBSTITUTE_COST : 0);
  // Compute distance as number of operations to transform A into B multiplied by weight.
  return weight * (1 + magic.distance);
}

const autocompleteSearch = function() {
  const ingredients = JSON.parse(document.getElementById('search-data').dataset.ingredients)
  const searchInput = document.getElementById('q');

  if (ingredients && searchInput) {
    new autocomplete({
      selector: searchInput,
      minChars: 1,
      delay: 50,
      cache: false,
      source: function(input, suggest) {
        // map ingredients to name and distance (from searched input)
        let choices = ingredients.map(ingredient => {
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
