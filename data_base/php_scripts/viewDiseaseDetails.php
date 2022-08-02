
<?php
require('db.php');

$data = json_decode(file_get_contents("php://input"));
$patient_id = 1; //$data->patient_id;

$sqlQuery = 'SELECT d.disease_name, 
d.diagnosis_date, patients.first_name, 
patients.surname
FROM patient_disease d, patients
WHERE d.patient_id = ?';

$statement = $db->prepare($sqlQuery);

$statement->execute([$patient_id]);

$myarray = array();

while ($resultsFrom = $statement -> fetch()) {
	array_push (
		$myarray,
		array (
			'disease_name'=>$resultsFrom['disease_name'],
			'diagnosis_date'=>$resultsFrom['diagnosis_date'],
			)
		);
}

echo json_encode($myarray);
?>


