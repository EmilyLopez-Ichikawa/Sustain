document.addEventListener("DOMContentLoaded", getCategory, false);
document.getElementById("button").addEventListener("click", getCategory, false);


function getCategory(){
  fetch("query_brand.php", {
        method: 'POST',
        headers: { 'content-type': 'application/json',
                    'Accept': 'application/json'}
    })
    .then(resp => resp.jsom())
    .then(data => { 
        // if(data.success){
        //     document.getElementById("loggedout").style.display = "none";
        //     document.getElementById("loggedin").style.display = "block";
        //     document.getElementById("loggedInAs").textContent = "Logged in as " + data.user;
        //     let days = document.getElementsByClassName("day");
        //     for(let i = 0; i < days.length; i++){
        //       days[i].addEventListener("click", createEventModal, false);
        //     }
        // }else{
        //   document.getElementById("loggedout").style.display = "block";
        //   document.getElementById("loggedin").style.display = "none";
        //   let days = document.getElementsByClassName("day");
        //   for(let i = 0; i < days.length; i++){
        //     days[i].removeEventListener("click", createEventModal);
        //   }
        // }
    })
    .catch(error => console.error('Error:',error))
}
