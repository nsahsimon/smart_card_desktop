<?php
header('Content-Type: application/json');
include "../php_scripts/db.php";

$id = (int) $_POST['id'];
$disease_name= $_POST['disease_name'];
$diagnosis_date = $_POST['diagnosis_date'];

$stmt = $db->prepare("UPDATE patient_disease 
SET disease_name = ?, diagnosis_date = ?
WHERE disease_id = ?");

$result = $stmt->execute([$disease_name, 
$diagnosis_date, $id]);

echo json_encode([
'success' => $result
]);