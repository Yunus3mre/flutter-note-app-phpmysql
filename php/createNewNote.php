<?php
	include "dbConnection.php";
	$json = file_get_contents('php://input');
	$obj = json_decode($json,true);
	$id = $obj['user_id'];
	$note_name = $obj['note_name'];
	$note_descr = $obj['note_descr'];
	$url = $obj['url'];
	
	
	
	$query="INSERT INTO NOTES (user_id,note_name,note_descr,url)
	VALUES('$id','$note_name','$note_descr','$url')";
	
	
	
	
	echo mysqli_error($con);
	
	
	if(mysqli_query($con,$query)){
		echo json_encode(true);
	}else{
		echo json_encode(false);
	}
	
	mysqli_close($con);
	
?>