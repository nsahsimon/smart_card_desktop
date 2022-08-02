<?php
require('db.php');

$data = json_decode(file_get_contents("php://input"));
$patient_id = $data->patient_id;

$sqlQuery = 'SELECT allergy.allergy_name, 
allergy.allergy_date, patients.first_name, 
patients.surname
FROM patient_allergy allergy, patients
WHERE allergy.patient_id = ?';

$statement = $db->prepare($sqlQuery);

$statement->execute([$patient_id]);

$myarray = array();

while ($resultsFrom = $statement -> fetch()) {
	array_push (
		$myarray,
		array (
			'allergy_name'=>$resultsFrom['allergy_name'],
			'allergy_date'=>$resultsFrom['allergy_date'],
			)
		);
}

echo json_encode($myarray);
?>


