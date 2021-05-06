const showDislikePreferences = () => {
  // TODO: Select the "somthing to avoid" h5
  const question = document.getElementById('dislike-question');
  const answer = document.getElementById('dislike-answer');
  // TODO: Bind the `click` event to the h5
  question.addEventListener('click', (event) => {
    // TODO: On click, hide and show the answer div
      if (answer.style.visibility === 'hidden') {
        answer.style.visibility = 'visible';
      } else {
        answer.style.visibility = 'hidden';
      }
  });
};

export { showDislikePreferences };
