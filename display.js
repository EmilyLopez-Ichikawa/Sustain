$(document).ready(function(){
	$.ajaxSetup({ cache: false });

  getCategory();
  const numSuggestions = 3;

  function getCategory(){
    fetch("query_brand.php", {
          method: 'POST',
          headers: { 'content-type': 'application/json',
                      'Accept': 'application/json'}
      })
      .then(resp => resp.json())
      .then(data => {
        if(data.success){
          $("#currentCompany").append("<div id='nowBrandName'>" + data.food + "</div>");
          $("#currentCompany").append("<div id='nowCompName'>" + data.company + "</div>");
          $("#currentCompany").append("<div id='nowScore'>" + data.score + "</div>");
          document.getElementById('nowScore').style.color = setColor(data.score);

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
        const newDiv = document.createElement("div");
        newDiv.setAttribute("class", "listItem");

        const brandName = document.createElement("div");
        brandName.appendChild(document.createTextNode(data[i].food));
        brandName.setAttribute("class", "brandName");
        newDiv.appendChild(brandName);

        const compName = document.createElement("div");
        compName.appendChild(document.createTextNode(data[i].company));
        compName.setAttribute("class", "compName");
        newDiv.appendChild(compName);

        const score = document.createElement("div");
        score.appendChild(document.createTextNode(data[i].score));
        score.setAttribute("class", "score");
        newDiv.appendChild(score);
        score.style.color = setColor(data[i].score);


        // newDiv.append("<div id=compName'>"+ data[i].company + "</div>");
        // newDiv.append("<div id='brandName'>"+ data[i].food + "</div>");
        // newDiv.append("<div id='score'>"+ data[i].score + "</div>");
        document.getElementById("suggestionsList").appendChild(newDiv);

      }

    })
    .catch(error => console.error('Error:',error))
  }

});


function setColor(score){
  let color = "#ffffff";
  if(score == 95){
    color="#97db68";
  }
  if(score == 90){
    color="#99b85b";
  }
  if(score == 85){
    color="#9f9c51";
  }
  if(score == 80){
    color="#a87b46";
  }
  if(score == 75){
    color="#b0633e";
  }
  if(score == 70){
    color="#b84e38";
  }
  if(score == 60){
    color="#bd4736";
  }

  return color;
}
