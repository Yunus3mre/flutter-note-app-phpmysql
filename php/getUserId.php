<?php
	include "dbConnection.php";
	
	$json=file_get_contents("php://input");
	
	$obj=json_decode($json,true);
	
	$email= $obj["email"];
	$password=$obj["password"];
	
	$query="SELECT id FROM users WHERE email='$email' 
	AND password='$password'";
	$read=mysqli_query($con,$query);
	
	$result=mysqli_fetch_array($read,MYSQLI_ASSOC);
		
	if(isset($result)){
		echo json_encode($result["id"]);
		
	}	
	
	
	
	
	
	mysqli_close($con);








?>