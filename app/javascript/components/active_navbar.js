const activeNavbar = () => {

  const currentLocation = location.pathname.substr(1) // returns ending of the url

  if (currentLocation) {
    const element = document.querySelector(`.`+`${currentLocation}`);
    if (element) {
      element.classList.add("current-page");
    }
  } else {
    // homepage does not have any ending url
    const element = document.querySelector(`.`+`home`);
    if (element) {
      console.log(element.classList);
      element.classList.add("current-page");
    }
  }
}

export { activeNavbar };
