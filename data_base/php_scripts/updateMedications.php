<?php
header('Content-Type: application/json');
include "../php_scripts/db.php";

$id = (int) $_POST['id'];
$medication_name= $_POST['medication_name'];
$dosage = $_POST['dosage'];

$stmt = $db->prepare("UPDATE medications
SET medication_name = ?, dosage = ?
WHERE medication_id = ?");

$result = $stmt->execute([$medication_name, 
$dosage, $id]);

echo json_encode([
'success' => $result
]);