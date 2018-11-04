<?php
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
  $stmt->fetch();

  if($stmt){
  	echo json_encode(array(
  		"success" => true,
      "score" => $score,
      "company" => $company,
      "category" => $category,
      "food" => $food_name
  	));
  	exit;
  } else{
    echo json_encode(array(
  		"success" => false,
  		"message" => "Error: The selected brand is not in the database."
  	));
  	exit;
  }

  $stmt->close();

?>
