
// listens to the click and adds "Dont be picky!" to the card of the recipe

const shuffleRecipeOnClinck1 = () => {
  const listenedBtn = document.getElementById('listened-btn-1');
  const recipeCard = document.getElementById('our-card-1');

    if (listenedBtn) {
    listenedBtn.addEventListener('click', () => {
      if (recipeCard) {
        // keeping this for the option of replacing the whole card with new recipe
        // recipeCard.innerHTML = newCard;
        // replaces the button with the message
        recipeCard.insertAdjacentHTML('beforebegin', "<h3 style='float: right'>Don't be picky!!!</h3>");
        // hides the clicked button
        listenedBtn.style.display = "none";
      }
    });
  }
}


const shuffleRecipeOnClinck2 = () => {
  const listenedBtn = document.getElementById('listened-btn-2');
  const recipeCard = document.getElementById('our-card-2');

    if (listenedBtn) {
    listenedBtn.addEventListener('click', () => {
      if (recipeCard) {
        // recipeCard.innerHTML = newCard;
        recipeCard.insertAdjacentHTML('beforeend', "<h3>Don't be picky!!!</h3>");
      }
    });
  }
}

const shuffleRecipeOnClinck3 = () => {
  const listenedBtn = document.getElementById('listened-btn-3');
  const recipeCard = document.getElementById('our-card-3');

    if (listenedBtn) {
    listenedBtn.addEventListener('click', () => {
      if (recipeCard) {
        // recipeCard.innerHTML = newCard;
        recipeCard.insertAdjacentHTML('beforeend', "<h3>Don't be picky!!!</h3>");
      }
    });
  }
}

const shuffleRecipeOnClinck4 = () => {
  const listenedBtn = document.getElementById('listened-btn-4');
  const recipeCard = document.getElementById('our-card-4');

    if (listenedBtn) {
    listenedBtn.addEventListener('click', () => {
      if (recipeCard) {
        // recipeCard.innerHTML = newCard;
        recipeCard.insertAdjacentHTML('beforeend', "<h3>Don't be picky!!!</h3>");
      }
    });
  }
}

const shuffleRecipeOnClinck5 = () => {
  const listenedBtn = document.getElementById('listened-btn-5');
  const recipeCard = document.getElementById('our-card-5');

    if (listenedBtn) {
    listenedBtn.addEventListener('click', () => {
      if (recipeCard) {
        // recipeCard.innerHTML = newCard;
        recipeCard.insertAdjacentHTML('beforeend', "<h3>Don't be picky!!!</h3>");
      }
    });
  }
}

const shuffleRecipeOnClinck6 = () => {
  const listenedBtn = document.getElementById('listened-btn-6');
  const recipeCard = document.getElementById('our-card-6');

    if (listenedBtn) {
    listenedBtn.addEventListener('click', () => {
      if (recipeCard) {
        // recipeCard.innerHTML = newCard;
        recipeCard.insertAdjacentHTML('beforeend', "<h3>Don't be picky!!!</h3>");
      }
    });
  }
}

const shuffleRecipeOnClinck7 = () => {
  const listenedBtn = document.getElementById('listened-btn-7');
  const recipeCard = document.getElementById('our-card-7');

    if (listenedBtn) {
    listenedBtn.addEventListener('click', () => {
      if (recipeCard) {
        // recipeCard.innerHTML = newCard;
        recipeCard.insertAdjacentHTML('beforeend', "<h3>Don't be picky!!!</h3>");
      }
    });
  }
}

export { shuffleRecipeOnClinck1 };
export { shuffleRecipeOnClinck2 };
export { shuffleRecipeOnClinck3 };
export { shuffleRecipeOnClinck4 };
export { shuffleRecipeOnClinck5 };
export { shuffleRecipeOnClinck6 };
export { shuffleRecipeOnClinck7 };
