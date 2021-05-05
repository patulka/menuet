// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";

// Internal imports, e.g:
import { autocompleteSearch } from '../components/autocomplete';
import { shuffleRecipeOnClinck1 } from '../components/shuffling_single_recipes';
import { shuffleRecipeOnClinck2 } from '../components/shuffling_single_recipes';
import { shuffleRecipeOnClinck3 } from '../components/shuffling_single_recipes';
import { shuffleRecipeOnClinck4 } from '../components/shuffling_single_recipes';
import { shuffleRecipeOnClinck5 } from '../components/shuffling_single_recipes';
import { shuffleRecipeOnClinck6 } from '../components/shuffling_single_recipes';
import { shuffleRecipeOnClinck7 } from '../components/shuffling_single_recipes';
import { showHideIngredientInfo } from '../components/shopping';

document.addEventListener('turbolinks:load', () => {
  autocompleteSearch();
  showHideIngredientInfo()
  shuffleRecipeOnClinck1();
  shuffleRecipeOnClinck2();
  shuffleRecipeOnClinck3();
  shuffleRecipeOnClinck4();
  shuffleRecipeOnClinck5();
  shuffleRecipeOnClinck6();
  shuffleRecipeOnClinck7();

  // Call your functions here, e.g:
  // initSelect2();
});
