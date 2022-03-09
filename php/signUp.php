<?php
	include "dbConnection.php";
	
	
	// Storing the received JSON into $json variable. Takes raw data from the request
	$json = file_get_contents('php://input');
	
	// Decode the received JSON and Store into $obj variable.Converts it into a PHP object
	//Yani JSON formatında ki verileri PHP formatına çevirir.
	$obj = json_decode($json,true);
	
	// Getting name from $obj object.
	$name = $obj['name'];
 
	// Getting Email from $obj object.
	$email = $obj['email'];
 
	// Getting Password from $obj object.
	$password = $obj['password'];
	
	
	// Checking whether Email is Already Exist or Not in MySQL Table.
	$CheckSQL = "SELECT * FROM users WHERE email='$email'";
	
	$check = mysqli_fetch_array(mysqli_query($con,$CheckSQL));
	//mysqli_query($con,$CheckSQL) sorgu çalıştırmak için kullanılır.$mysqli değişkeni de mysqli_connect fonksiyonundan aldıgımız bilgileri
	//içeren bir değişken.
	//The mysqli_fetch_array() function is used to fetch rows from the database and store them as an array. The array can be fetched as an 
	//associative array, as a numeric array or both.Burada yukarıda ki sorgudan değer dönerse $check içerisinde saklanacak.
	//fetch:gidip getirmek

	if(isset($check)){
		//The isset() function is an inbuilt function in PHP which checks whether a variable is set and is not NULL.This function also checks 
		//if a declared variable, array or array key has null value, if it does, isset() returns false, it returns true in all other possible cases.
		
		//$emailExist = 'Email Already Exist, Please Try Again With New Email Address..!';
		//Bu şekilde direkt mesaj da gönderebiliriz.Ancak ben kontrolü kolay olması için true ya da false değeri gönderdim 
		//ve bu değerlere göre kullanıcıya mesajımı gösterdim.
		
		$emailExist = false;
		
		
		// Converting the message into JSON format.The json_encode() function is an inbuilt function in PHP which is used to convert PHP array 
		//or object into JSON representation.
		$existEmailJSON = json_encode($emailExist);
		
		// Echo the message on Screen.
		echo $existEmailJSON ;
	}else{
		// Creating SQL query and insert the record into MySQL database table.
		$Sql_Query = "insert into users (name,email,password) values 
		('$name','$email','$password')";
		
		 if(mysqli_query($con,$Sql_Query)){
	 
			// If the record inserted successfully then show the message.
			//$MSG = 'User Registered Successfully' ;
			$MSG = true; 
		 
			// Converting the message into JSON format.
			$json = json_encode($MSG);
		 
			// Echo the message.
			echo $json ;
	 
		}
		else{
	 
			echo 'Try Again';
	 
		}
	}

	mysqli_close($con);

?>