
<?php
header('Content-Type: application/json');
include "../php_scripts/db.php";


$data = json_decode(file_get_contents("php://input"));
$patient_id = $data->patient_id;
$medication_name = $data->medication_name;
$dosage = $data->dosage;

$stmt = $db->prepare("INSERT INTO medications(
patient_id, medication_name, dosage) 
VALUES (?, ?, ?)");
$result = $stmt->execute([$patient_id, $medication_name, 
$dosage]);

echo json_encode([
'success' => $result
]);