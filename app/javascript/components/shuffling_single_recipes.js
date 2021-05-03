// under construction by Sarka

// needs to be imported to application.js
//have a look on rails frontend lecture
// test it in .js console

const listened_btn_1 = document.getElementById("listened-btn-1");
listened_btn_1.addEventListener("click", (event) => {
  console.log(event);
  console.log(event.currentTarget);
});
