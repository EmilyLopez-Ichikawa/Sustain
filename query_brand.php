<?php
  ini_set("session.cookie_httponly", 1);
  session_start();
  require "database.php";
  header("Content-Type: application/json");

  $food_name = $_SESSION['food'];

  $stmt = $mysqli->prepare("select score, company, category from foods where name=?");
  if(!$stmt){
    printf("Query prep failed: %s\n", $mysqli->error);
    exit;
  }
  $stmt->bind_param('s', $food_name);
  $stmt->execute();
  $stmt->bind_result($score, $company, $category);

  if($stmt->fetch()){
  	echo json_encode(array(
  		"success" => true,
      "score" => $score,
      "company" => $company,
      "category" => $category,
      "food" => $food_name
  	));
    $stmt->close();
  	exit;
  } else{
    echo json_encode(array(
  		"success" => false,
      "food" => $food_name,
  		"message" => "Error: The selected brand is not in the database."
  	));
    $stmt->close();
  	exit;
  }


?>
