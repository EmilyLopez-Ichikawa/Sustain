<?php
session_start();
require "database.php";
header("Content-Type: application/json");

$json_str = file_get_contents('php://input');
$json_obj = json_decode($json_str, true);

$food_name = $json_obj["responses"][0]["logoAnnotations"][0]["description"];

//~*~*~*~*~*~*~*~COMMENT OUT-------------JUST FOR TESTING~*~*~*~*~*~*~*~*~*~*~//
$food_name = "Cheerios";
$_SESSION['food'] = $food_name;

$stmt = $mysqli->prepare("select score, company from foods where name=?");
if(!$stmt){
  printf("Query prep failed: %s\n", $mysqli->error);
  exit;
}
$stmt->bind_param('s', $food_name);
$stmt->execute();
$stmt->bind_result($score, $company);

if($stmt->fetch()){
  echo json_encode(array(
  	"success" => true,
    "score" => $score,
    "food_name" => $food_name,
    "company" => $company,
    "message" => "Success",
  ));
  $stmt->close();
  exit;
}else{
  echo json_encode(array(
    "success" => false,
    "score"=> 101,
    "food_name" => $food_name,
    "company" => "failed",
    "message" => "Food not found in database",
  ));
  $stmt->close();
  exit;
}

?>
