<?php
  session_start();
  require 'database.php';

  $_SESSION['food'] = null;
  $_SESSION = array();
  session_destroy();
 ?>
