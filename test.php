<?php
// session_start();
require 'database.php';

// $_SESSION['picture'] = null;
// $_SESSION = array();
// session_destroy();

header("Content-Type: application/json"); // Since we are sending a JSON response here (not an HTML document), set the MIME Type to application/json

$json_str = file_get_contents('php://input');
$json_obj = json_decode($json_str, true);
$food_name = trim($json_obj["responses"][0]["logoAnnotations"][0]["description"]);

$stmt = $mysqli->prepare("select score from foods where name=?");
if(!$stmt){
  printf("Query prep failed: %s\n", $mysqli->error);
  exit;
}
$stmt->bind_param('s', $food_name);
$stmt->execute();
$stmt->bind_result($score);
$stmt->fetch();
$stmt->close();

if($score){
  echo json_encode(array(
  	"success" => true,
    "score" => $score,
    "message" => "Success"
  ));
  exit;
}else{
  echo json_encode(array(
    "success" => false,
    "message" => "Food not found in database",
    "score"=> 404
  ));
  exit;
}

?>
