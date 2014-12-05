import mx.utils.Delegate;
import mx.transitions.Tween;
import mx.transitions.easing.None;
import util.xml.XMLSA;
import ui.locator.Locator;
import ui.locator.LocationData;
class ui.locator.Location extends MovieClip{
	
	private var _xml:XMLSA;
	private var _i:Number=0;
	private var settings:Settings;
	private var latitude,longitude:Number;
	private var _added:Boolean=false;
	private var _locationdata:LocationData;
	private var tween:Object;
	private var fnord:Number=0;

	private function init():Void{
		
		settings = new Settings();
		settings.locator.addEventListener("locations",Delegate.create(this,broadcastHandler));
		latitude=Number(xml.latitude.getValue());
		longitude=Number(xml.longitude.getValue());
		this._alpha=0;
		tween = new Object();
		/*
		
		now position this according to latitude longitude	
		
		map's width: 823 x 440
		
		*/
		var map={width:823,height:440,topLat:51, bottomLat:24, leftLong:-126, rightLong:-65};
	
		var distx = Math.abs(map.rightLong-map.leftLong);
		var percentX = Math.abs(longitude-map.leftLong)/distx;
		
		var disty = Math.abs(map.topLat-map.bottomLat);
		var percentY = Math.abs(latitude-map.bottomLat)/disty;
		
		this._x=map.width*percentX;
		this._y=(-1*map.height*percentY)+map.height;
		
		//hide the ones w/o lat/long
		if(this._x==0&&this._y==0){
			this._visible=false;
		}
		
	}
	private function broadcastHandler(eventObject:Object):Void{
		var func:Function=this[eventObject.functionName];
		func.call(this,eventObject);
	}
	private function Reset():Void{
		//this._visible=false;
	}
	private function Filter(eventObject:Object):Void{
		Reset();
		var myzip:Object=eventObject.myzip;
		if(Math.abs(Number(myzip.latitude)-latitude)<4 && Math.abs(Number(myzip.longitude)-longitude)<4){
			var dist:Number = Math.floor(distance(myzip.latitude,myzip.longitude,latitude,longitude));
			if(dist<200){
				settings.locator.addLocationItem(xml, dist, this);
				FadeIn();
			}
		}else{
			FadeOut();
			//this._visible=false;
		}
	}
	
	// DISTANCE CALCULATIONS-----------------------
	private function distance($lat1, $lon1, $lat2, $lon2):Number{
		
		var $theta = $lon1 - $lon2;
		var $dist = Math.sin(deg2rad($lat1)) * Math.sin(deg2rad($lat2)) +  Math.cos(deg2rad($lat1)) * Math.cos(deg2rad($lat2)) * Math.cos(deg2rad($theta));
		var $dist = Math.acos($dist);
		var $dist = rad2deg($dist);
		var $miles = $dist * 60 * 1.1515;
		
		return $miles;
		
	}  // End distance calculations
	private function rad2deg(_rads:Number):Number{
		return _rads/Math.PI*180;
	}
	private function deg2rad(_degrees:Number):Number{
		return _degrees/180*Math.PI;
	}
	/*
	private function Compare($ar1, $ar2){ 
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
	}*/
	public function get i():Number{
		return _i;
	}
	private function FadeOut():Void{
		if(this._alpha==100)
			tween.alpha = new Tween(this,"_alpha",None.easeNone,this._alpha,0,10,false);		
	}
	private function FadeIn():Void{
		if(this._alpha!=100)
			tween.alpha = new Tween(this,"_alpha",None.easeNone,this._alpha,100,10,false);
	}
	public function set i(val:Number):Void{
		_i=val;
		//tween.alpha = new Tween(this,"_alpha",None.easeNone,0,100,
		tween.foo = new Tween(this,"fnord",None.easeNone,0,1,i/10,false);
		tween.foo.onMotionFinished=Delegate.create(this,FadeIn);
	}
	public function get added():Boolean{
		return _added;
	}
	public function set added(val:Boolean):Void{
		_added=val;
	}
	public function get xml():XMLSA{
		return _xml;
	}
	public function set xml(val:XMLSA):Void{
		_xml=val;
		init();
	}
	public function get locationdata():LocationData{
		return _locationdata;
	}
	public function set locationdata(val:LocationData):Void{
		_locationdata=val;
	}
}