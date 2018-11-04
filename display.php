<!DOCTYPE html>

<html lang="en">
  <head>
    <title>Sustain</title>
    <script src = "https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://use.typekit.net/fni3sga.css">
    <link href="https://fonts.googleapis.com/css?family=Dosis:300" rel="stylesheet">
    <link rel="stylesheet" href="display.css">
  </head>

  <?php
    session_start();
    if(isset($_GET['food'])){
      $_SESSION['food'] = str_replace("_", " ", $_GET['food']);
    }
   ?>

  <body>
    <div class="backgroundimage"><img src="moreinfobackground.png"></div>
    <!-- <button type="button" id="button">Click</button> -->
    <div id="currentCompany"></div>
    <div id="middletext">Compare this product's sustainability rating!</div>
    <div id="suggestionsList"></div>
    <script src="display.js"></script>

  </body>

</html>
