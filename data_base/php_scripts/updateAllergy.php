<?php
header('Content-Type: application/json');
include "../php_scripts/db.php";

$id = (int) $_POST['id'];
$allergy_name= $_POST['allergy_name'];
$allergy_date = $_POST['allergy_date'];

$stmt = $db->prepare("UPDATE patient_allergy 
SET allergy_name = ?, allergy_date = ?
WHERE allergy_id = ?");

$result = $stmt->execute([$allergy_name, 
$allergy_date, $id]);

echo json_encode([
'success' => $result
]);