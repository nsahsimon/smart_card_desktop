<?php
header('Content-Type: application/json');
include "../php_scripts/db.php";

$id = (int) $_POST['id'];
$stmt = $db->prepare("DELETE FROM emergency_contact 
WHERE id = ?");
$result = $stmt->execute([$id]);

echo json_encode([
'id' => $id,
'success' => $result
]);