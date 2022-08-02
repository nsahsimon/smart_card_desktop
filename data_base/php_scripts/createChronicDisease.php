<?php
header('Content-Type: application/json');
include "../php_scripts/db.php";


$data = json_decode(file_get_contents("php://input"));
$patient_id = $data->patient_id;
$disease_name = $data->disease_name;
$diagnosis_date = $data->diagnosis_date;

$stmt = $db->prepare("INSERT INTO patient_disease(
patient_id, disease_name, diagnosis_date) 
VALUES (?, ?, ?)");
$result = $stmt->execute([$patient_id, $disease_name, 
$diagnosis_date]);

echo json_encode([
'success' => $result
]);