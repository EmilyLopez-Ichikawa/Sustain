<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Green Food</title>
  </head>
  <body>
    <?php
    session_start();
    if(isset($_SESSION['pic'])){
      echo "WORKING";
    }

    // if(isset($_SESSION['pic'])){
    //   echo "WORKING";
    // }else{
    //   echo "Not yet set";
    // }
    ?>
  </body>

</html>
