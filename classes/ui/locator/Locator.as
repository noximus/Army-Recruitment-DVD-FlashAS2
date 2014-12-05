import util.xml.XMLSA;
import mx.containers.ScrollPane;
import mx.utils.Delegate;
import mx.events.EventDispatcher;
import mx.transitions.easing.Regular;
import mx.transitions.easing.None;
import mx.transitions.Tween;
import ui.locator.Location;

//added by chris 
import ui.locator.ZipField;

//

class ui.locator.Locator extends EventDispatcher{
	
	private var mc:MovieClip;
	
	
	public var mc_close:MovieClip;
	
	//public var tf_zipcode,
	public var tf_results:TextField;
	private var zipxml,lxml,resultsXML:XMLSA;
	
	private var mapborders:Object;
	private var myzip:Object;
	
	//extends AnimateClip(so we can fade it in and out and stuff)
	private var _zipField:ZipField;
	//--------------------------------------------------------------
	
	
	public var mc_results:MovieClip;
	
	
	
	public var mc_sp:ScrollPane;
	

	public var mc_locations:MovieClip;
	private var _inv:Number;
	private var settings:Settings;
	private var tween:Object;
	private var whatever:Number=0;
	private var locations:Array;
	
	
	
	
	public function Locator(_mc:MovieClip){
		init(_mc);
	}
	private function init(_mc:MovieClip):Void{
		
		tween = new Object();
		
		EventDispatcher.initialize(this);
		
		settings = new Settings();
		settings.locator=this;
		
		//ZipField formats and constrains zip field
		this._zipField = _mc.zipField;
		
		//this.mc_search = this._zipField.mc_search;
		
		mc=_mc;
		
		mc_locations = mc.mc_locations;
		mc_results = mc.mc_results;
		mc_results._visible=false;
		mc_results._alpha=0;
		mc_sp=mc.mc_results.mc_sp;
		mc_sp.contentPath="empty";
		mc_close=mc.mc_close;
		
		tf_results = mc_results.tf_results;
		
		mc_sp.hScrollPolicy="off";
		//mc_sp.drawFocus = false
		
		zipxml = new XMLSA();
		zipxml.ignorewhite=true;
		zipxml.onLoad=Delegate.create(this,LoadedZipXML);
		
		resultsXML = new XMLSA();
		resultsXML.ignoreWhite=true;
		resultsXML.onLoad=Delegate.create(this,ParseResults);		
		resultsXML.load("xml/locator/results/results.rotc.xml");

		lxml = new XMLSA();
		lxml.ignoreWhite=true;

		this._zipField.addEventListener("onSubmit",Delegate.create(this,Search));
		this._zipField.addEventListener("onFieldClear",Delegate.create(this,ShowAll));
		this.addEventListener("onError",this._zipField);
		
		mc_close.onPress=Delegate.create(this,Close);
		
	}
	private function Close():Void{
		settings.community.Back();
	}
	private function ShowAll():Void{
		broadcast({type:"locations",functionName:"FadeIn",myzip:myzip});
		
		//hide the results
		/*tween.alpha = new Tween(mc_results,"_alpha",None.easeNone,100,0,20,false);
		tween.alpha.onMotionFinished=function(){
			this.obj._visible=false;
		}*/
		mc_results._visible=false;
		
	}
	private function ParseResults():Void{
		var result:XMLSA;
		var location:MovieClip;
		
		//mc_sp.contentPath="empty";
		
		
		
	
			for(var i=0;i<resultsXML.result.length;i++){
				
				result = resultsXML.result[i];
				location = mc_locations.attachMovie("Location","location_"+i,i);
				location.xml=result;
				location.i=i;
				/*
				var locationdata = mc_sp.content.attachMovie("LocationData","data_"+i,i);
				
				locationdata.xml=result;
				location.locationdata=locationdata;
				*/
				
				
			}
		
		
		mc_sp.setStyle("borderStyle","none");
		mc_sp.border_mc._visible=false;
		mc_sp.setStyle("backgroundColor","0xFF0000");
		
	}
	public function FilterLocations(myzip:Object):Void{
		broadcast({type:"locations",functionName:"Filter",myzip:myzip});
		
		//wait one second to sort display
		//blatant hackery
		tween.whatever=new Tween(this,"whatever",None.easeNone,0,1,20,false);
		tween.whatever.onMotionFinished=Delegate.create(this,SortDisplayLocations);
	}
	public function SortDisplayLocations():Void{
		
		var _settings = new Settings();
		locations.sortOn("distance",Array.NUMERIC);

		var locationdata;
		for(var i=0;i<locations.length;i++){

			locationdata = mc_sp.content.attachMovie("LocationData","location_"+i,mc_sp.content.getNextHighestDepth());
			locationdata.xml=locations[i].xml;
			locationdata.distance=locations[i].distance;
		}
		
		mc_sp.invalidate();
		clearInterval(_settings.locator.inv);
		
		if(mc_results._visible==false){
			tween.alpha = new Tween(mc_results,"_alpha",None.easeNone,-100,100,20,false);
			mc_results._visible=true;
		}
		
	}
	public function ResetLocationDataClips():Void{
		broadcast({type:"locationdata",functionName:"Hide"});
	}
	public function broadcast(broadcastObj:Object):Void{
		dispatchEvent(broadcastObj);
	}	
	private function LoadedZipXML():Void{

		myzip = findZip(this._zipField.data);

		//trace(myzip.latitude + "," + myzip.longitude);
		if(myzip){
			FilterLocations(myzip);
		}else {
			var message:String = "We're sorry, there are no results for zip code: "+this._zipField.data+".";
			this.dispatchEvent({type:"onError",message:message});	
			mc_results.tf_results.text="NO RESULTS FOUND FOR THIS ZIP CODE.";
			//"WITHIN 150 MILES OF " + this._zipField.data+".";
		}

		
	}
	private function findZip():Object{
		//given the zipcode in tf_zipcode, return the xml node that has lat/long
		var zipnode:XMLSA;
		for(var i=0;i<zipxml.zip.length;i++){
			zipnode=zipxml.zip[i];
			if(zipnode.attributes.code==this._zipField.data){
				return {latitude:zipnode.attributes.lat, longitude:zipnode.attributes.long};
				break;
			}
		}
		return null;
		
	}
	private function Ready():Void{
		
	}
	public function addLocationItem(xml:XMLSA,distance:Number,obj:Location):Void{
		locations.push({xml:xml,distance:distance});
	}

	private function Search(evtObj:Object):Void{
		
		var zip:Number=evtObj.data;
		
		
			
		tf_results.text="";
			
		mc_sp.contentPath="empty2";
		mc_sp.contentPath="empty";
			
		locations = new Array();
			
		//first, find the zipcode.
			
			
	
		var floor=zip-(zip%5000);
		var ciel=floor+5000;
		var filename="xml/locator/zipcodes/zipcodes." + floor + "-" + ciel + ".xml";
		zipxml.load(filename);
		
		
			
		mc_results.tf_results.text="UNIVERSITIES WITHIN 150 MILES OF " + zip;
		
			
	
		
	}
	
	public function get inv():Number{
		return _inv;
	}
	public function set inv(val:Number):Void{
		_inv=val;
	}
	
	private function findNode(zip:String):XMLSA{
		var node:XMLSA;
		//trace("len:" + lxml.toString());
		for(var i=0;i<lxml.zip.length;i++){
			node = lxml.zip[i];
		//	trace("node:" + node);
			if(node.attributes.code==zip){
				return node;
			}
		}
	}

}