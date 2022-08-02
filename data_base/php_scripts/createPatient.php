<?php
header('Content-Type: application/json');
include "../php_scripts/db.php";


$first_name = $_POST['first_name'];
$surname = $_POST['surname'];
$address = $_POST['address'];
$username = $_POST['username'];
$pin_code = $_POST['pin_code'];
$homephone = $_POST['homephone'];
$workphone = $_POST['workphone'];
$mobilephone= $_POST['mobilephone'];
$birth_date = $_POST['birth_date'];
$gender = $_POST['gender'];
$bloodtype = $_POST['bloodtype'];

$stmt = $db->prepare("INSERT INTO patients (first_name, surname, address, username, pin_code, homephone, workphone, mobilephone, birth_date, gender, bloodtype) 
VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
$result = $stmt->execute([$first_name, $surname, $address, $username, $pin_code, $homephone, $workphone, $mobilephone, $birth_date, $gender, $bloodtype]);

echo json_encode([
'success' => $result
]);