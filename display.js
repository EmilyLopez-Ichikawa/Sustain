document.addEventListener("DOMContentLoaded", getCategory, false);
document.getElementById("button").addEventListener("click", getCategory, false);
const numSuggestions = 3;

function getCategory(){
  fetch("query_brand.php", {
        method: 'POST',
        headers: { 'content-type': 'application/json',
                    'Accept': 'application/json'}
    })
    .then(resp => resp.json())
    .then(data => {console.log(data);
      if(data.success){
        console.log("Successfully got category!");
        $("#currentCompany").append("<div id='nowCompName'>" + data.company + "</div>");
        $("#currentCompany").append("<div id='nowBrandName'>" + data.food + "</div>");
        $("#currentCompany").append("<div id='nowScore'>" + data.score + "</div>");

        getRecommendations(data.category);
      }else{
        console.log("Error: " + data.message);
      }
    })
    .catch(error => console.error('Error:',error))
}

function getRecommendations(category){
const data = {'category': category};

fetch("query_by_category.php", {
      method: 'POST',
      body: JSON.stringify(data),
      headers: { 'content-type': 'application/json',
                  'Accept': 'application/json'}
  })
  .then(resp => resp.json())
  .then(data => {
    for(let i = 0; i < numSuggestions; i++){
      let suggestion = $("#suggestionsList").append("<div class='listItem' id='suggestion"+i+"'></div>");
      suggestion.append("<div id=compName'>"+ data[i].company + "</div>");
      suggestion.append("<div id='brandName'>"+ data[i].food + "</div>");
      suggestion.append("<div id='score'>"+ data[i].score + "</div>");
      console.log(data[i]);
    }

  })
  .catch(error => console.error('Error:',error))
}
