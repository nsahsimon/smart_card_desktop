<?php
require('db.php');

$data = json_decode(file_get_contents("php://input"));
$username = $data->username;
$pin_code = $data->pin_code;

// $username = (string) $_POST['username'];
// $pin_code = (string) $_POST['pin_code'];

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
			'address'=>$resultsFrom['address'],
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
