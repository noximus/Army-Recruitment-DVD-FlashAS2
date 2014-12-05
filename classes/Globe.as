import mx.transitions.easing.None;
import mx.transitions.Tween;
import mx.transitions.easing.Regular;
import util.xml.XMLSA;
import mx.utils.Delegate;

class Globe extends MovieClip{
	
	public var mc_globe:MovieClip;
	private var mc:MovieClip;
	private var tf_text:TextField;
	private var mc_info:MovieClip;
	private var _theta:Number=0;
	private var position:Object;
	private var initDragPosition:Object;
	private var lastPosition:Object;
	private var _diff:Number=0;
	private var _thrown:Boolean=false;
	private var _xVelocity:Number=0;
	private var settings:Settings;
	private var tween:Tween;
	private var iterations:Number=0;
	private var xPositions:Array;
	
	private var place:MovieClip;
	
	public var mc_places:MovieClip;
	private var places:XMLSA;
	
	function Globe(){
		init();
	}
	private function init():Void{
		
		mc=this;
		mc.stop();
		mc_globe.loadMovie("swf/globe_sequence.swf");
		settings = new Settings();
		settings.globe=this;
		position = new Object();
		lastPosition = new Object();
		initDragPosition = new Object();
		xPositions = new Array();
		
		//mc.useHandCursor=false;
		/*
		mc.onPress=function(){
			this.StartDragging();
		}
		mc.onRelease=mc.onReleaseOutside=function(){
			this.StopDragging();
		}
		mc.onRelease=Delegate.create(this,StopDragging);
		mc.onReleaseOutside=Delegate.create(this,StopDragging);
		mc.onPress=Delegate.create(this,StartDragging);
		*/
		
		
		var mouseListener:Object = new Object();
		mouseListener.onMouseDown=Delegate.create(this,StartDragging);
		mouseListener.onMouseUp=Delegate.create(this,StopDragging);
		Mouse.addListener(mouseListener);

		
		places = new XMLSA();
		places.ignoreWhite=true;
		places.onLoad=function(success:Boolean){
			var settings = new Settings();
			settings.globe.LoadPlaces();
		};
		places.load("xml/global.locations.xml");
		
		//create some points
		
		/*
		for(var j:Number=-60;j<=60;j+=20){
			place=mc_places.attachMovie("Place","place_"+j,mc_places.getNextHighestDepth());
			place.Position(j,j);
		}*/
	}
	public function LoadPlaces():Void{
		var placeXML:XMLSA;
		var placeXMLInfo:XMLSA;
		var latitudeStr:String;
		var longitudeStr:String;
		var infoStr:String;
		var latitude,longitude:Number;
		var latArr:Array;
		var lonArr:Array;
		for(var i:Number=0;i<places.location.length;i++){
			
			placeXML = places.location[i];
			//placeXMLInfo = places.location[i].name;
			place = mc_places.attachMovie("Place","place_"+mc_places.getNextHighestDepth(),mc_places.getNextHighestDepth());

			latitudeStr = placeXML.attributes.latitude;
			longitudeStr = placeXML.attributes.longitude;
			infoStr = placeXML.name.attributes.place;
			
			
			trace(infoStr);
			
			//there's a space bw the numberic value and S,N,E or W.
			
			latArr = latitudeStr.split(" ");
			lonArr = longitudeStr.split(" ");
			
			if(latArr[1]=="N"){
				latitude=-1*Number(latArr[0]);
			}else{
				latitude=Number(latArr[0]);
			}
			
			if(lonArr[1]=="W"){
				longitude=-1*Number(lonArr[0]);
			}else{
				longitude=Number(lonArr[0]);
			}
			
			
			place.Position(latitude,longitude);			
			place.mc_info.tf_text.text = infoStr;
			//place.Position(Number(placeXML.attributes.latitude), Number(placeXML.attributes.longitude));
		}
	}
	private function StartDragging():Void{
		/*
		
		start dragging
		
		iterations:# of frames since StartDragging called
		initDragPosition: position where the mouse was clicked
		thrown: whether or not we're throwing this right now
		xPositions: array of the 4 most recent xPositions ... captured every other frame
		
		*/
		initDragPosition.x=this._xmouse;
		initDragPosition.theta=theta;
		thrown=false;
		tween.stop();
		this.lastPosition.x=this._xmouse;
		iterations=0;
		xPositions=null;
		xPositions = new Array();
		mc.onEnterFrame=function(){
			this.iterations++;
			this.diff = this._xmouse-this.initDragPosition.x;	
			if(this.iterations%1==0){
				
				this.lastPosition.x=this._xmouse;
				this.xPositions.push(this._xmouse);
				if(this.xPositions.length>4){
					this.xPositions.splice(0,1);
				}
			}
		};
		
	}
	private function StopDragging():Void{
		
		delete(this.onEnterFrame);

		//xVelocity ... pull to values out of the array ... the first and the second to last
		//divide by 7 ... just because
		xVelocity=(xPositions[xPositions.length-1] - xPositions[0])/7;
		

		//time to decelrate is dependent upon the velocity
		
		var timeToDecelerate=Math.abs(xVelocity*2);
		
		
		//tween the Velocity.... in the accessor this affects theta
		tween.stop();
		tween = new Tween(this,"xVelocity",Regular.easeOut,xVelocity,0,timeToDecelerate,false);
		tween.onMotionFinished=function(){
			this.obj.thrown=false;
		};
		
		//we have thrown this
		thrown=true;
		
	}
	public function get theta():Number{
		return _theta;
	}
	public function set theta(val:Number):Void{
		_theta = val;
		var percentage=_theta/360;
		percentage=percentage%1;
		if(percentage<0){
			percentage=1-Math.abs(percentage);
		}
		var gotoFrame:Number=(percentage)*this._totalframes;
		//this.gotoAndStop(Math.floor(gotoFrame));
		mc_globe.mc_globe.gotoAndStop(Math.floor(gotoFrame));
	}
	public function get diff():Number{
		return _diff;
	}
	public function set diff(val:Number):Void{
		_diff=val;
		theta=initDragPosition.theta+_diff/2;
	}
	public function get xVelocity():Number{
		return _xVelocity;
	}
	public function set xVelocity(val:Number):Void{
		_xVelocity=val;
		if(thrown==true){
			theta+=val;
		}
	}
	public function get thrown():Boolean{
		return _thrown;
	}
	public function set thrown(val:Boolean):Void{
		_thrown=val;
	}
}