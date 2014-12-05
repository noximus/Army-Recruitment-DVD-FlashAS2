import util.xml.XMLSA;
import mx.utils.Delegate;
class ui.Locator{
	
	private var mc:MovieClip;
	public var mc_search:MovieClip;
	public var tf_zipcode,tf_results:TextField;
	private var lxml:XMLSA;
	
	public function Locator(_mc:MovieClip){
		init(_mc);
	}
	private function init(_mc:MovieClip):Void{
		mc=_mc;
		mc_search = mc.mc_search;
		tf_zipcode = mc.tf_zipcode;
		tf_results = mc.tf_results;
		
		
		lxml = new XMLSA();
		lxml.ignoreWhite=true;
		lxml.onLoad=function(success:Boolean){
			//trace(this.toString());
			trace("success:" + success);
		}
		lxml.load("xml/zipcodes.xml");

		mc_search.onPress=Delegate.create(this,Search);
		
	}
	private function Ready():Void{
		trace("ready");
	}
	private function Search():Void{
		trace("zip:" + tf_zipcode.text);
		var mynode:XMLSA = findNode(tf_zipcode.text);
		trace("mynode:" + mynode);
	}
	private function findNode(zip:String):XMLSA{
		var node:XMLSA;
		trace("len:" + lxml.toString());
		for(var i=0;i<lxml.zip.length;i++){
			node = lxml.zip[i];
			trace("node:" + node);
			if(node.attributes.code==zip){
				return node;
			}
		}
	}

}