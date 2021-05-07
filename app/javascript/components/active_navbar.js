// const activeNavbar = () => {

//   const currentLocation = location.pathname.substr(1) // returns ending of the url


//     const element = document.querySelector(`.`+`${currentLocation}`);
//     console.log(element);
//     console.log(element.classList);

//     console.log(currentLocation);

//     if (element) {

//       console.log(element.classList);
//       element.classList.add("current-page");
//     } else {
//       const elementHome = document.querySelector(`.`+`home`);
//       if (elementHome) {
//         console.log(elementHome.classList);
//         elementHome.classList.add("current-page");
//       }
//     }


// }



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
