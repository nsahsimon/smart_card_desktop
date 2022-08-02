
<?php
require('db.php');

$data = json_decode(file_get_contents("php://input"));
$patient_id = $data->patient_id;

$sqlQuery = 'SELECT im.immunization_name, 
im.immunization_date, dose , patients.first_name, 
patients.surname
FROM patient_immunization im, patients
WHERE im.patient_id = ?';

$statement = $db->prepare($sqlQuery);

$statement->execute([$patient_id]);

$myarray = array();

while ($resultsFrom = $statement -> fetch()) {
	array_push (
		$myarray,
		array (
			'immunization_name'=>$resultsFrom['immunization_name'],
			'immunization_date'=>$resultsFrom['immunization_date'],
			'dose'=>$resultsFrom['dose'],
			)
		);
}

echo json_encode($myarray);
?>


