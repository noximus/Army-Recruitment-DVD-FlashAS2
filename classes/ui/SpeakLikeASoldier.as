import util.xml.XMLSA;
class ui.SpeakLikeASoldier extends MovieClip{
	
	private var settings:Settings;
	private var mc:MovieClip;
	private var xml:XMLSA;
	
	public var tf_text:TextField;
	
	function SpeakLikeASoldier(){
		init();
	}
	private function init():Void{
		mc=this;
		settings = new Settings();
		xml=settings.ref.GetNode("speak");
		tf_text.autoSize=true;
		var tft:String="";
		for(var i=0;i<xml.terms.term.length;i++){
			var term=xml.terms.term[i];
			tft+=term.term.getValue()+"- " + term.definition.getValue()+"\n";
		}
		tf_text.text=tft;
	}
	
}