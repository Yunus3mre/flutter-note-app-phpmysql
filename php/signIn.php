<?php
	include "dbConnection.php";
	
	$json=file_get_contents("php://input");
	
	$obj=json_decode($json,true);
	
	$email= $obj["email"];
	
	$password=$obj["password"];
	
	$checkSQL="SELECT * FROM users WHERE email='$email' 
	AND password='$password'";
	
	$check=mysqli_fetch_array(mysqli_query($con,$checkSQL));
	
	if(isset($check)){
		$authSucceded=true;
		$authSuccededJSON=json_encode($authSucceded);
		
		
		echo $authSuccededJSON;
		
		
	}else{
		$authNotSucceded=false;
		$authNotSuccededJSON=json_encode($authNotSucceded);

		
		echo $authNotSuccededJSON;
	
	}
	
	mysqli_close($con);








?>