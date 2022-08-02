<?php
header('Content-Type: application/json');
include "../php_scripts/db.php";

$data = json_decode(file_get_contents("php://input"));
$patient_id = $data->patient_id;
$immunization_name = $data->immunization_name;
$immunization_date = $data->immunization_date;

$stmt = $db->prepare("INSERT INTO patient_immunization(
patient_id, immunization_name, immunization_date) 
VALUES (?, ?, ?)");
$result = $stmt->execute([$patient_id, $immunization_name, 
$immunization_date]);

echo json_encode([
'success' => $result
]);
