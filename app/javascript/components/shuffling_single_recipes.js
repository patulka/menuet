const shuffleRecipeOnClinck = () => {
  const listenedBtn = document.getElementById('listened-btn-1');
  const recipeCard = document.getElementById('our-card-1');

    if (listenedBtn) {
    listenedBtn.addEventListener('click', () => {
      if (recipeCard) {
        // recipeCard.innerHTML = newCard;
        recipeCard.insertAdjacentHTML('beforeend', "<h3>Don't be picky!!!</h3>");
      }
    });
  }
}

export { shuffleRecipeOnClinck };


