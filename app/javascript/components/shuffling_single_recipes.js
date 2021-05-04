// under construction by Sarka

// THIS WORKED
// const shuffleRecipeOnClinck = () => {
//   const listenedBtn = document.getElementById('listened-btn-1');
//   const recipeCard = document.getElementById('our-card-1');

//   if (listenedBtn) {
//     listenedBtn.addEventListener('click', () => {
//       console.log("THE BUTTON 1 WAS CLICKED!");
//     });
//   }
// }


const shuffleRecipeOnClinck = () => {
  const listenedBtn = document.getElementById('listened-btn-2');
  const recipeCard = document.getElementById('our-card-2');

  //THESE WORK
  // let newCard = "Hello"
  let newCard = "<h3> Hello</h3>"



  // let newCard = "<%= @menus.first.title %>"
  // let newCard = "<% @shuffled_recipe.title %>"




  // <%= javascript_tag do %>
  // let newCard = <%="@shuffled_recipe.title"%>;
  // <% end %>


  // "<img class='our-card-image' src='<%= recipe.img_url %>' alt='Card image cap'><div id='number'><h1><%= @counter %> </h1></div><div class='our-card-body'>              <button class='btn btn-red mt-3 mb-3' id='listened-btn-<%= @counter %>'>Exchange the recipe no <%= @counter %> - NOT WORKING</button><h3 class='card-title'><strong><%= recipe.title %></strong></h3><p class='card-text'><strong>Author</strong><br><%= recipe.author %></p><p class='card-text'><strong>Ingedrients</strong><br><%= recipe.ingredients_list.join(' - ') %></p><%= link_to 'Go to recipe', recipe_path(recipe), class: 'btn btn-transparent'%>";






  // "<img class='our-card-image' src='<%= recipe.img_url %>' alt='Card image cap'><div id='number'><h1><%= @counter %> </h1></div><div class='our-card-body'>              <button class='btn btn-red mt-3 mb-3' id='listened-btn-<%= @counter %>'>Exchange the recipe no <%= @counter %> - NOT WORKING</button><h3 class='card-title'><strong><%= recipe.title %></strong></h3><p class='card-text'><strong>Author</strong><br><%= recipe.author %></p><p class='card-text'><strong>Ingedrients</strong><br><%= recipe.ingredients_list.join(' - ') %></p><%= link_to 'Go to recipe', recipe_path(recipe), class: 'btn btn-transparent'%>";

    if (listenedBtn) {
    listenedBtn.addEventListener('click', () => {
      // console.log("THE BUTTON 1 WAS CLICKED!");
      if (recipeCard) {
        recipeCard.innerHTML = newCard;
      }
    });
  }
}

export { shuffleRecipeOnClinck };
