<?php
header('Content-Type: application/json');
include "../php_scripts/db.php";

$id = (int) $_POST['id'];
$immunization_name= $_POST['immunization_name'];
$immunization_date = $_POST['immunization_date'];

$stmt = $db->prepare("UPDATE patient_immunization 
SET immunization_name' = ?, immunization_date = ?
WHERE immunization_id = ?");

$result = $stmt->execute([$immunization_name, 
$immunization_date, $id]);

echo json_encode([
'success' => $result
]);