<?php
header('Content-Type: application/json');
include "../php_scripts/db.php";

$id = (int) $_POST['id'];
$doctor_name= $_POST['doctor_name'];
$doctor_surname = $_POST['doctor_surname'];
$pin_code = $_POST['pin_code'];
$clinic = $_POST['clinic'];
$username = $_POST['username'];
$address = $_POST['address'];
$homephone = $_POST['homephone'];
$mobilephone= $_POST['mobilephone'];

$stmt = $db->prepare("UPDATE doctors 
SET doctor_name = ?, doctor_surname = ?,
    pin_code = ?, clinic = ?,
    username = ?, address = ?,
    homephone = ?, mobilephone = ?
WHERE doctor_id = ?");

$result = $stmt->execute([$doctor_name, $doctor_surname, 
$pin_code, $clinic, $username, $address, $homephone,
$mobilephone, $id]);

echo json_encode([
'success' => $result
]);