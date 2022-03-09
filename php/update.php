<?php
	include "dbConnection.php";
	$json = file_get_contents('php://input');
	$obj = json_decode($json,true);
	$id = $obj['id'];
	$note_name = $obj['note_name'];
	$note_descr = $obj['note_descr'];
	
	
	
	
	$query="UPDATE notes SET note_name = '$note_name', 
	note_descr='$note_descr' WHERE id = '$id'";
	
	
	
	
	echo mysqli_error($con);
	
	
	if(mysqli_query($con,$query)){
		echo json_encode(true);
	}else{
		echo json_encode(mysqli_error($con));
	}
	
	mysqli_close($con);
	
?>