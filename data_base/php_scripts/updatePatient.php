<?php
header('Content-Type: application/json');
include "../php_scripts/db.php";

$id = (int) $_POST['id'];
$first_name = $_POST['first_name'];
$surname = $_POST['surname'];
$address = $_POST['address'];
$username = $_POST['username'];
$pin_code = $_POST['pin_code'];
$homephone = $_POST['homephone'];
$workphone = $_POST['workphone'];
$mobilephone= $_POST['mobilephone'];
$birth_date = $_POST['birth_date'];
$gender= $_POST['gender'];
$bloodtype= $_POST['bloodtype'];

$stmt = $db->prepare("UPDATE patients 
SET first_name = ?, surname = ?,
    address = ?, username = ?,
    pin_code = ?, homephone = ?,
    workphone = ?, mobilephone = ?,
    birth_date = ?, gender = ?, bloodtype = ?
WHERE patient_id = ?");

$result = $stmt->execute([$first_name, $surname, 
$address, $username, $pin_code, $homephone, $workphone,
$mobilephone, $birth_date, $gender, $bloodtype, $id]);

echo json_encode([
'success' => $result
]);