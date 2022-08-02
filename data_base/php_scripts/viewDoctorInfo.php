<?php
require('db.php');

$data = json_decode(file_get_contents("php://input"));
$username = $data->username;
$pin_code = $data->pin_code;
//$username = (string) $_POST['username'];
//$pin_code = (string) $_POST['pin_code'];

$sqlQuery = "SELECT doctor_name, doctor_surname, clinic, username, address, homephone, mobilephone, doctor_id
FROM doctors WHERE (username =? AND pin_code = ?)";

$statement = $db->prepare($sqlQuery);

$statement->execute([$username, $pin_code]);

$myarray = array();

while ($resultsFrom = $statement -> fetch()) {
	array_push (
		$myarray,
		array (
			'doctor_id'=>$resultsFrom['doctor_id'],
			'username'=>$resultsFrom['username'],
			'first_name'=>$resultsFrom['doctor_name'],
			'surname'=>$resultsFrom['doctor_surname'],
			'address'=>$resultsFrom['address'],
			'home_phone'=>$resultsFrom['homephone'],
			'mobile_phone'=>$resultsFrom['mobilephone'],
			'clinic'=>$resultsFrom['clinic'],
			)
		);
}

echo json_encode($myarray);
?>
