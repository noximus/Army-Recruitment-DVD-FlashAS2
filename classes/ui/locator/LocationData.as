import util.xml.XMLSA;
import mx.utils.Delegate;
import type.XString;
class ui.locator.LocationData extends MovieClip{
	
	private var mc:MovieClip;
	private var _xml:XMLSA;
	public var tf_name,tf_distance,tf_street1,tf_street2,tf_citystatephone:TextField;
	private static var prev:LocationData=null;
	private var settings:Settings;
	private var _distance:Number;
	private var street1,street2,name:XString;
	
	private function init():Void{
		mc=this;
		
		name=new XString(xml.name.getValue());
		street1=new XString(xml.street1.getValue());
		street2=new XString(xml.street2.getValue());
		
		//clean this up
		street1 = street1.replace("\"","");
		name= name.replace("UNIV " + "UNIVERSITY ");
		
		tf_name.text=name;
		tf_street1.text=street1;
		tf_street2.text=street2;
		
		if(tf_street2.text=="undefined"){
			tf_street2._visible=false;
			tf_citystatephone._y=tf_street2._y;
		}
		
		tf_citystatephone.text=xml.city.getValue() + ", " + xml.state.getValue() + "    " + xml.phone.getValue();
		
		settings = new Settings();
		settings.locator.addEventListener("locationdata",Delegate.create(this,broadcastHandler));
		
		this._y=prev._y+prev._height;
		prev=this;
		
	}
	
	public function get xml():XMLSA{
		return _xml;
	}
	public function set xml(val:XMLSA):Void{
		_xml=val;
		init();
	}
	public function Hide():Void{
		this._visible=false;
		this._y=0;
		//trace("i'm hiding");
		prev=null;
	}
	public function Kill():Void{
		//trace("kill me");
		settings.locator.removeEventListener("locationdata",broadcastHandler);
		this.removeMovieClip();
		prev=null;
	}
	private function broadcastHandler(eventObject:Object):Void{
		var func:Function=this[eventObject.functionName];
		func.call(this,eventObject);
	}
	public function get distance():Number{
		return _distance;
	}
	public function set distance(val:Number):Void{
		_distance=val;
		tf_distance.text=val + " miles";
	}
	
}