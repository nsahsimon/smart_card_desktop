<?php
require('db.php');

$data = json_decode(file_get_contents("php://input"));
$patient_id = $data->patient_id;

$sqlQuery = 'SELECT contact.relative_name, 
contact.relative_surname,
contact.relationship, contact.homephone, 
contact.mobilephone
FROM emergency_contact contact, patients
WHERE contact.patient_id = ?';

$statement = $db->prepare($sqlQuery);

$statement->execute([$patient_id]);

$myarray = array();

while ($resultsFrom = $statement -> fetch()) {
	array_push (
		$myarray,
		array (
			'relative_name'=>$resultsFrom['relative_name'],
			'relative_surname'=>$resultsFrom['relative_surname'],
			'relationship'=>$resultsFrom['relationship'],
			'homephone'=>$resultsFrom['homephone'],
			'mobilephone'=>$resultsFrom['mobilephone'],
			)
		);
}

echo json_encode($myarray);
?>

