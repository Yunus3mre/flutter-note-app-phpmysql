<?php 
	//Define your Server host name here.
	$HostName = "localhost";
 
	//Define your MySQL Database Name here.
	$DatabaseName = "photonote";
 
	//Define your Database User Name here.
	$HostUser = "root";
 
	//Define your Database Password here.
	$HostPass = ""; 
 
	// Creating MySQL Connection.
	$con = mysqli_connect($HostName,$HostUser,$HostPass,$DatabaseName);
	
?>