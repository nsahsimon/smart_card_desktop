
<?php
require('db.php');

$data = json_decode(file_get_contents("php://input"));
$patient_id = $data->patient_id;

$sqlQuery = 'SELECT m.medication_name, 
m.dosage, patients.first_name, 
patients.surname
FROM medications m, patients
WHERE m.patient_id = ?';

$statement = $db->prepare($sqlQuery);

$statement->execute([$patient_id]);

$myarray = array();

while ($resultsFrom = $statement -> fetch()) {
	array_push (
		$myarray,
		array (
			'medication_name'=>$resultsFrom['medication_name'],
			'dosage'=>$resultsFrom['dosage'],
			)
		);
}

echo json_encode($myarray);
?>


