<?php
  ini_set("session.cookie_httponly", 1);
  session_start();
  header("Content-Type: application/json");
  require "database.php";

  $json_str = file_get_contents('php://input');
  $json_obj = json_decode($json_str, true);

  $category = $json_obj['category'];
  $food_name = $_SESSION['food'];

  $stmt = $mysqli->prepare("select score, company, name from foods where category=? order by score desc");
  if(!$stmt){
    printf("Query prep failed: %s\n", $mysqli->error);
    exit;
  }
  $stmt->bind_param('s', $category);
  $stmt->execute();
  $stmt->bind_result($score, $company, $food);

  $arr = array();
  while($stmt->fetch()){
    $dataObj = new \stdClass();
    $dataObj->score = $score;
    $dataObj->company = $company;
    $dataObj->food = $food;
    array_push($arr, $dataObj);
  }
  echo json_encode($arr);

  $stmt->close();

 ?>
