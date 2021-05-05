


function removeFromList() {
  const list = document.getElementById("list");
  if (list) {
    // list.removeChild(list.childNodes);

   // find all the ingredients thanks to their class
    const ingredients = document.querySelectorAll(".ingredient");


   // iterate over all the ingredients and for each one find the button thanks to its class

   // add event lister to the button

    ingredients.forEach((ingredient) => {

      const btnClose = ingredient.querySelector(".close");
      btnClose.addEventListener('click', () => {
        console.log(ingredient);
        fetch(`/shopping_lists/${469}`,{
          method: "DELETE",
          body: JSON.stringify({id: 208})
        })
          .then(response => response.json())
          .then((data) => {
            console.log("ingredient deleted")
          })


      });
    });
  };
}

  export {removeFromList};

// // Create a "close" button and append it to each list item
// var myNodelist = document.getElementsByTagName("LI");
// var i;
// for (i = 0; i < myNodelist.length; i++) {
//   var span = document.createElement("SPAN");
//   var txt = document.createTextNode("\u00D7");
//   span.className = "close";
//   span.appendChild(txt);
//   myNodelist[i].appendChild(span);
// }

// // Click on a close button to hide the current list item
// var close = document.getElementsByClassName("close");
// var i;
// for (i = 0; i < close.length; i++) {
//   close[i].onclick = function() {
//     var div = this.parentElement;
//     div.style.display = "none";
//   }
// }

// // Add a "checked" symbol when clicking on a list item
// var list = document.querySelector('ul');
// list.addEventListener('click', function(ev) {
//   if (ev.target.tagName === 'LI') {
//     ev.target.classList.toggle('checked');
//   }
// }, false);



// // const shoppingList = document.getElementsByTagName('ul')[0];
// // const shoppingListItems = [shoppingList.getElementsByTagName('li')];

// // for (shoppingListItem of shoppingListItems) {

// //   let deleteButton = document.createElement('button');
// //   deleteButton.type = 'button';
// //   deleteButton.classList.add('deleteButton');
// //   deleteButton.textContent = 'Delete';
// //   deleteButton.addEventListener('click', (e) => e.target.parentNode.remove(), false);
//   shoppingListItem.appendChild(deleteButton);
// }
