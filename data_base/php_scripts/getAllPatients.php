<?php
require('db.php');

$username = "evariste";
$pin_code = 1234;

$sqlQuery = "SELECT first_name, surname, pin_code,
address, username, homephone, workphone, mobilephone,
birth_date, gender, bloodtype, patient_id
FROM patients WHERE (username =? AND pin_code = ?)";

$statement = $db->prepare($sqlQuery);

$statement->execute([$username, $pin_code]);

$myarray = array();

while ($resultsFrom = $statement -> fetch()) {
	array_push (
		$myarray,
		array (
			'patient_id'=>$resultsFrom['patient_id'],
			'username'=>$resultsFrom['username'],
			'first_name'=>$resultsFrom['first_name'],
			'surname'=>$resultsFrom['surname'],
			'address'=>$resultsFrom['username'],
			'home_phone'=>$resultsFrom['homephone'],
			'work_phone'=>$resultsFrom['workphone'],
			'mobile_phone'=>$resultsFrom['mobilephone'],
			'birth_date'=>$resultsFrom['birth_date'],
			'gender'=>$resultsFrom['gender'],
			'blood_type'=>$resultsFrom['bloodtype'],
			
			)
		);
}

echo json_encode($myarray);
?>