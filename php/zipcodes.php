<?


class Locator{

	
	function Locator(){
		$this->init();
	}
	private function init(){
		mysql_connect("localhost","root","troubl3");
		mysql_select_db("locations");
		
		//$this->generate_zipcodexml();
		
		
		
		/*
		
		ok ... now we have to make our 'results' xml documents
		one for each 'quadrant' in the usa
		we'll have overlapping quadrants, and the locator will
		pick the right one
		
		these will be info about the location as well as lat/long
		
		*/

		//$this->FillLocations();
		//$this->generate_resultxml();
		$this->fill_results();
		$this->generate_results();
		
		mysql_close();
	}
	private function generate_results(){
	
	
	
	
		$file=fopen("../xml/locator/results/results.rotc.xml","w");
		
		$result = mysql_query("select * from locations");
		fwrite($file,"<results>\n");
		while($row=mysql_fetch_array($result)){
			$cols=array("name","street1","street2","city","state","longitude","latitude","zip","phone");
			$str="<result>\n";
			for($i=0;$i<sizeOf($cols);$i++){

				$str.="\t<".$cols[$i].">".$row[$cols[$i]]."</".$cols[$i].">\n";
				
				
			}
			$str.="</result>\n";
			fwrite($file,$str);
		}
		fwrite($file,"</results>\n");
		fclose($file);
		
	}
	private function fill_results(){
	
		mysql_query("delete from locations");
	
		$filename="../assets/locator/locator.txt";
		$file = fopen($filename,"r");
		$contents = '';
		
		while (!feof($file)) {
			$contents .= fread($file, 8192);
		}
		$lines = split("\n",$contents);
		
		
		for($i=0;$i<sizeOf($lines);$i++){
		
			$items = split("\t",$lines[$i]);
			//APPALACHIAN STATE UNIVERSITY,E,5,DD DOUGHERTY BUILDING,226 JOYCE LAWRENCE LANE,BOONE,NC,28608-2094,JETT,DOUGLAS,LTC,(828) 262-2015
			
			
				$name=$items[0];
				$street1 = $items[3];
				$street2=$items[4];
				$city=$items[5];
				$state=$items[6];
				$fullzip=split("-",$items[7]);
				$zip=$fullzip[0];
				$ln=$items[8];
				$fn=$items[9];
				$title=$items[10];
				$phone = $items[11];			
				$contact=$items;
			
		
			if(strlen($zip)>5){
				$zip=substr($zip,0,5);
			}
		
			
			$pos=$this->getLatLong($zip);
			$latitude=$pos->latitude;
			$longitude=$pos->longitude;
			
			if(strlen($latitude)==0){
				echo "fail: $fullzip[0]\n";
			}
			
			//echo $zip . "\n";
			$sql="insert into locations(name,latitude,longitude,zip,street1,street2,phone,city,state)";
			$sql.="values('$name','$latitude','$longitude','$zip','$street1','$street2','$phone','$city','$state')";
			mysql_query($sql);
			
		}
		
		
		fclose($file);
	
	
	
	
	}
	private function generate_resultxml(){
		/*
		
		this will generate 'results' xml files
			... an xml document of results within a certain
			quadrant with lat/long borders.
			
			the usa goes from (overestimated) -130 to -60 longitude, and 20 to 50 latitude
		
		
		*/
		
		
		$quadsize = 10;
		$betweenquads=5;
		
		for($long=-130;$long<=-60;$long+=$betweenquads){
			
			
			for($lat=20;$lat<=50;$lat+=$betweenquads){
			
				$minlat=$lat;
				$maxlat=$lat+$quadsize;
				
				$minlong=$long;
				$maxlong=$long+$quadsize;
				
				//echo "$minlat-$maxlat, $minlong-$maxlong\n";
				
				$filename="../xml/locator/results/results.$minlat"."X"."$maxlat.$minlong"."X"."$maxlong.xml";
				$sql="select * from locations
					where latitude<$maxlat and latitude>$minlat
					and longitude>$minlong and longitude<$maxlat";
				$file=fopen($filename,"w");
				$result = mysql_query($sql) or die("error in sql:" . $sql . mysql_error());
				fwrite($file,"<results>\n");
				while($row=mysql_fetch_array($result)){
					$result_lat = $row["latitude"];
					$result_long = $row["longitude"];
					$result_name=$row["name"];
					$str="<result latitude=\"$result_lat\" longitude=\"$result_long\" name=\"$result_name\" />\n";
					fwrite($file,$str);
				}
				fwrite($file,"</results>");
				fclose($file);
			
			
			}
			//echo $long . "\n";
			
		}
		
		
		
	
	}
	private function generate_zipcodexml(){
		/*
		
		generate 20 zipcode files...
		
		*/
		$inc=5000;
		for($i=0;$i<100000;$i+=$inc){
		
			$min=$i;
			$max=$i+$inc;
			$sql="select * from zipcode where zipcode>='$min' and zipcode<=$max";
			$result = mysql_query($sql);

		
			$filename="../xml/locator/zipcodes/zipcodes.$min-$max.xml";
			$file = fopen($filename,"w");
			fwrite($file,"<zipcodes>\n");
			while($row=mysql_fetch_array($result)){
				$code=$row["zipcode"];
				$lat=$row["latitude"];
				$long=$row["longitude"];
				fwrite($file,"<zip code=\"$code\" lat=\"$lat\" long=\"$long\" />\n");
				
			}
			fwrite($file,"</zipcodes>");
			fclose($file);
		
		}
		
	}
	
	
	private function getLatLong($zipcode){
		if(strlen($zipcode)==5){
			$sql="select * from zipcode where zipcode='$zipcode'";
			$result = mysql_query($sql) or die("error in sql:" . $sql . mysql_error());
			if(mysql_num_rows($result)>0){
				while($row=mysql_fetch_array($result)){
					return new Position($row["latitude"],$row["longitude"]);
				}		
			}else{
				echo "no matching zipcode: $zipcode\n";
				return false;
			}
		}

	}
	private function FillLocations(){
		//fills crap into the database for results
		
		//name, latitude, longitude, zipcode.
		for($i=0;$i<300;$i++){
			$name="location $i";
			$zip = rand(10000,91000);
			$position = $this->getLatLong($zip);
			if($position){
				
				$sql="insert into locations(name,zipcode,latitude,longitude) values('$name','$zip','".$position->latitude."','".$position->longitude."')";
				mysql_query($sql);
			}
			
			
		}
		
		
	}

}
class Position{
	public $latitude;
	public $longitude;
	public function Position($lat,$long){
		$this->latitude=$lat;
		$this->longitude=$long;
	}
}


$locator = new Locator();

?>