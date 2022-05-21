<?php
	include 'connected.php';
	header("Access-Control-Allow-Origin: *");

if (!$link) {
    echo "Error: Unable to connect to MySQL." . PHP_EOL;
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
    
    exit;
}

if (!$link->set_charset("utf8")) {
    printf("Error loading character set utf8: %s\n", $link->error);
    exit();
	}

if (isset($_GET)) {
	if ($_GET['isAdd'] == 'true') {
				
		$idBuyer = $_GET['idBuyer'];
		$nameBuyer = $_GET['nameBuyer'];
		$idSeller = $_GET['idSeller'];
		$nameSeller = $_GET['nameSeller'];
		$idFood = $_GET['idFood'];
		$nameFood = $_GET['nameFood'];
		$priceFood = $_GET['priceFood'];
		$amountFood = $_GET['amountFood'];
		$sumFood = $_GET['sumFood'];
		$total = $_GET['total'];
		$status = $_GET['status'];
		
		
							
		$sql = "INSERT INTO `ordertable`(`id`, `idBuyer`, `nameBuyer`,`idSeller`, `nameSeller`, `idFood`, `nameFood`, `priceFood`, `amountFood`, `sumFood`, `total`, `status`) VALUES (Null,'$idBuyer','$nameBuyer','$idSeller','$nameSeller','$idFood','$nameFood','$priceFood','$amountFood','$sumFood','$total','$status')";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "Welcome Master UNG";
   
}
	mysqli_close($link);
?>