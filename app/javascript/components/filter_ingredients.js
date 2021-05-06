const showDislikePreferences = () => {
  // Select the "something to avoid" h5 & arrow
  const question = document.getElementById('dislike-question');
  const answer = document.getElementById('dislike-answer');
  const triangle = document.querySelector('.triangle');
  const triangleDown = document.querySelector('.triangle-down');
  // TODO: Bind the `click` event to the h5
  question.addEventListener('click', (event) => {
    // On click, hide and show the answer div
    if (answer.style.visibility === 'hidden') {
      answer.style.visibility = 'visible';
    } else {
      answer.style.visibility = 'hidden';
    }

    // On click, turn the arrow
    if (triangle.style.display != 'none') {
      triangle.style.display = 'none';
      triangleDown.style.display = 'block';
    } else {
      triangle.style.display = 'block';
      triangleDown.style.display = 'none';
    }
  });
};


export { showDislikePreferences };

