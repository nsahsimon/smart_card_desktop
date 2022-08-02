<?php

$db_name = "smart_card";
$db_server = "localhost";
$db_user = "root";
$db_pass = "";

try {
$db = new PDO("mysql:host={$db_server};dbname={$db_name};charset=utf8", $db_user, $db_pass);
$db->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
// echo "successfuly connected";
} catch(PDOException $exe){
   echo $exe -> getMessage();
   die("could not connect");
}
?>