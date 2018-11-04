<!DOCTYPE html>

<html lang="en">
  <head>
    <title>Green Food</title>
    <link rel="stylesheet" href="display.css">
    <script src = "https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  </head>

  <?php
    session_start();
    if(isset($_GET['food'])){
      $_SESSION['food'] = str_replace("_", " ", $_GET['food']);      
    }
   ?>

  <body>
    <button type="button" id="button">Click</button>
    <div id="currentCompany"></div>
    <div id="suggestionsList"></div>
    <script src="display.js"></script>
  </body>

</html>
