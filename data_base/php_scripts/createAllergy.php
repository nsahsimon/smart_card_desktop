<?php
header('Content-Type: application/json');
include "../php_scripts/db.php";


$data = json_decode(file_get_contents("php://input"));
$patient_id = $data->patient_id;
$allergy_name = $data->allergy_name;
$allergy_date = $data->allergy_date;

$stmt = $db->prepare("INSERT INTO patient_allergy(
patient_id, allergy_name, allergy_date) 
VALUES (?, ?, ?)");
$result = $stmt->execute([$patient_id, $allergy_name, 
$allergy_date]);

echo json_encode([
'success' => $result
]);
