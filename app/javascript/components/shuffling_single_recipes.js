
const shuffleRecipeOnClick = () => {
  // itirates over 7 days and 3 recipe options in them to identify all the shuffling buttons
  for (let day = 0; day < 7; day++) {
    const listenedBtn0 = document.getElementById('listened-btn-' + day + '-0');
    const listenedBtn1 = document.getElementById('listened-btn-' + day + '-1');
    const listenedBtn2 = document.getElementById('listened-btn-' + day + '-2');
    const recipeCard0 = document.getElementById('our-card-' + day + '-0');
    const recipeCard1 = document.getElementById('our-card-' + day + '-1');
    const recipeCard2 = document.getElementById('our-card-' + day + '-2');

    // no point continuing if the buttons/divs don't exist in DOM
    if (!listenedBtn0 || !listenedBtn1 || !listenedBtn2 ||
        !recipeCard0  || !recipeCard1  || !recipeCard2) {
      // "continue" jumps to the next for-loop iteration.
      continue;
    }

    // changing recipe options for certain day by swithcing the visibility of the recipe card
    listenedBtn0.addEventListener('click', () => {
      recipeCard0.style.display = "none";
      recipeCard1.style.display = "";
    });
    listenedBtn1.addEventListener('click', () => {
      recipeCard1.style.display = "none";
      recipeCard2.style.display = "";
    });
    listenedBtn2.addEventListener('click', () => {
      // easter egg: only in case of day 7 you are not allowed to shuffle forever -- after 3rd shuffle you get message "dont be picky" and the button disappears
      if (day == 6) {
        recipeCard2.insertAdjacentHTML('beforebegin', "<h5 style='float: right'>Don't be picky!!!</h5>");
        listenedBtn2.style.display = "none";
      } else {
        recipeCard2.style.display = "none";
        recipeCard0.style.display = "";
      }
    });
  }

  // this is end of listening to clicking on shuffling buttons
  // -------------------------------------------------------------------------------------------
  // below is handeled the button saving the displayed recipe options


  const saveBtn = document.getElementById('submit-meal-plan-btn');

  // no point continuing if the button doesn't exist in DOM.
  if (!saveBtn) {
    return;
  }

  // we need to inspect, which recipe options are visible when save btn is clicked (to save the correct recipes)
  saveBtn.addEventListener('submit', () => {
    var visible_ids = [];

    // iterates over all 21 cards (exactly 7 of them are visible)
    // we store the recipe ids of the visible cards to visible_ids
    for (let day = 0; day < 7; day++) {
      for (let recipe = 0; recipe < 3; recipe++) {
        const card = document.getElementById("our-card-" + day + "-" + recipe);
        if (card.style.display == "") {
          // Ha! This card is visible! Its recipe ids is stored in the div's
          // custom attribute "data-recipe-id".
          const id = card.getAttribute("data-recipe-id");
          visible_ids.push(id);
        }
      }
    }

    // the string to be passed to the saving button needs to look like this
    // menus[]=1
    // menus[]=2
    // menus[]=3
    const visible_ids_strings = visible_ids.map(id => "menus[]=" + id);
    // This sets the form's "action" URL to contain recipe ids of the visible recipes only.
    // (The original URL contains all 21 recipes.)
    saveBtn.action = "/week_menus?" + visible_ids_strings.join("&");
  });
}

export { shuffleRecipeOnClick };
