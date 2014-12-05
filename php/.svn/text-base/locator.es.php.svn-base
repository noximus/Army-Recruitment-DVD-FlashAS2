<?

// DISTANCE CALCULATIONS-----------------------
function distance($lat1, $lon1, $lat2, $lon2) {
	
	$theta = $lon1 - $lon2;
	$dist = sin(deg2rad($lat1)) * sin(deg2rad($lat2)) +  cos(deg2rad($lat1)) * cos(deg2rad($lat2)) * cos(deg2rad($theta));
	$dist = acos($dist);
	$dist = rad2deg($dist);
	$miles = $dist * 60 * 1.1515;
	
	return $miles;
	
}  // End distance calculations

function Compare($ar1, $ar2){ 
	if ($ar1['distance']<$ar2['distance']){
		return -1; 
	}
	else if ($ar1['distance']>$ar2['distance']){
		return 1;
	}
	if ($ar1['distance']<$ar2['distance']){
		return -1;
	}
	else if ($ar1['distance']>$ar2['distance']){
		return 1;
	}
	else{
		return 0;
	}
} 





require("cms/db.php");
require("cms/dbopen.php");


function storelocator(){

$zip = $_GET['zip'];
$showsurrounding=$_GET['radius'];

$search_results = array();


//==========================================================================================
//==========================================================================================
// Zip Code Search with surroundings
//==========================================================================================
//==========================================================================================

//==========================================================================================
// First Search Process --------------------------------------------------------------------
//==========================================================================================


$sql = "select latitude, longitude from zipcode where zipcode=$zip";
$result = mysql_query($sql);
while($row = mysql_fetch_array($result)){
	$rlatitude = $row["latitude"];
	$rlongitude = $row["longitude"];
}

$sql="select zipcode.latitude, zipcode.longitude, zipcode.zipcode, 
stores.id, stores.center_name, stores.title, stores.phone, stores.address, 
stores.www_alias, stores.city, stores.zip, states.abbr 
from zipcode,stores,states where stores.zip=zipcode.zipcode and 
stores.state_id=states.id order by stores.city asc";

$locator_results="";
$result = mysql_query($sql);
while($row = mysql_fetch_array($result)){
	$reslongitude = $row["longitude"];
	$reslatitude = $row["latitude"];
	$distance = distance($rlatitude, $rlongitude, $reslatitude, $reslongitude);
	$city = $row["city"];
	$id=$row["id"];
	$center_name = $row["center_name"];
	$store_zip = $row["zip"];
	$state = $row["abbr"];
	$phone = $row["phone"];
	$address = $row["address"];
	$www_alias=$row["www_alias"];
	$title = $row["title"];
	
	if($distance<$showsurrounding){
		
		$r = array("distance"=>$distance, "title"=>$title, "id"=>$id, "city"=>$city,"phone"=>$phone,"center_name"=>$center_name,"state"=>$state,"address"=>$address,"zip"=>$store_zip,"www_alias"=>$www_alias);
		array_push($search_results,$r);
	}
	
}


uasort($search_results, 'Compare');


foreach($search_results as $row){
	//print_r($row);
	
	$distance = $row["distance"];
	$city = $row["city"];
	$id=$row["id"];
	$center_name = $row["center_name"];
	$store_zip = $row["zip"];
	$state = $row["state"];
	$phone = $row["phone"];
	$address = $row["address"];
	$www_alias=$row["www_alias"];
	$title = $row["title"];
	$distance ="$distance";
	$distance = substr($distance,0,strpos($distance,".")+2);
	
	?>
	
	<h5><a href="/stores/<?=$www_alias?>"><?=$city?></a></h5>
	<p>
	<?=$title?><br />
	<?=$address?><br />
	<?=$center_name?>
	<?=$city?>, <?=$state?>, <?=$zip?><br />
	<?=$phone?><br /><br />
		<b>Distance: <?=$distance?> Miles</b>
	</p>
	
	
	<?
}

}

storelocator();

require("cms/dbclose.php");

?>