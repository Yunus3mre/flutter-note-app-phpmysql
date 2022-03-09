<?php
	include "dbConnection.php";
	$json=file_get_contents('php://input');
	
	$var=json_decode($json,true);
	
	$id=$var['id'];
	
	$query="DELETE FROM notes WHERE id='$id'";
	
	if(mysqli_query($con,$query)){
		echo json_encode(true);
	
	}else{
		echo json_encode(false);
	}
	
	
	mysqli_close($con);
	




?>