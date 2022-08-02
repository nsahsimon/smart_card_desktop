<?php
header('Content-Type: application/json');
include "../php_scripts/db.php";

$patient_id = (int) $_POST['patient_id'];
$relative_name = $_POST['relative_name'];
$relative_surname = $_POST['relative_surname'];
$relationship = $_POST['relationship'];
$homephone= $_POST['homephone'];
$mobilephone = $_POST['mobilephone'];

$stmt = $db->prepare("INSERT INTO emergency_contact(
patient_id,
relative_name, relative_surname, relationship, homephone,
mobilephone) 
VALUES (?, ?, ?, ?, ?, ?)");
$result = $stmt->execute([$patient_id, $relative_name, 
$relative_surname, $relationship, $homephone, $mobilephone]);

echo json_encode([
'success' => $result
]);
