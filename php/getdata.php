<?php

	include "dbConnection.php";
	
	$json=file_get_contents("php://input");
	$obj=json_decode($json,true);
	
	$id= $obj["user_id"];
	
	//Where user_id='$id'
	
	$query="SELECT * FROM notes Where user_id='$id'";
	
	
	$result=mysqli_query($con,$query);
		
		
		$var=array();
		
	while($read=mysqli_fetch_array($result,MYSQLI_ASSOC)){
	
		/*$var=$read['name'];
		$varJson=json_encode($var);
		echo $varJson;*/
		
		$var[]=$read;
		
		
	}
	
		//$varJson=json_encode($var);
		echo json_encode($var);	
	
	
	
	
	
	







?>