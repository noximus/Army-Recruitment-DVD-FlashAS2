import util.xml.XMLSA;
import mx.utils.Delegate;
import mx.controls.Loader;
import mx.transitions.Tween;
import mx.transitions.easing.None;
import com.senocular.ColorFader;

class ui.Ready extends MovieClip{
	
	private var settings:Settings;
	private var mc:MovieClip;
	private var xml:XMLSA;
	private var nItem:Number=-1;
	
	private var inactiveTextColor=0x777777;
	private var activeTextColor=0xCCCCCC;
	private var overTextColor=0xFFCC00;
	
	public var tf_title:TextField;
	public var tf_copy:TextField;
	public var mc_prev:MovieClip;
	public var mc_next:MovieClip;
	public var mc_img:Loader;
	public var tf_text:TextField;
	
	function Ready(){
		init();
	}
	private function init():Void{
		mc=this;
		mc_next.active=false;
		mc_prev.active=false;
		settings = new Settings();
		xml=settings.ref.GetNode("active/sections/basic/getinshape");
		
		//called in frame 1 in the timeline because ScrollPane component hasn't loaded yet
		//Select(0);
		
		mc_prev.colorfader=new ColorFader(mc_prev.mc_button);
		mc_next.colorfader=new ColorFader(mc_next.mc_button);

		Next();
	}
	private function Prev():Void{
		nItem--;
		Select();
	}
	private function Next():Void{
		nItem++;
		Select();

	}
	private function Release(_mc:MovieClip):Void{
		trace("Release:" + _mc);
	}
	private function Select():Void{
		
		mc_prev.onRollOver = mc_next.onRollOver = function(){
			this.colorfader.fadeTo(this._parent.overTextColor,2);
		}
		mc_prev.onRollOut = mc_next.onRollOut = function(){
			this.colorfader.fadeTo(this._parent.activeTextColor,30);
		}
		mc_prev.onPress=function(){
			this._parent.Prev();
		}
		mc_next.onPress=function(){
			this._parent.Next();
		}
		if(nItem==0){
			mc_prev.active=false;
			mc_prev.colorfader.fadeTo(inactiveTextColor,200);
			delete(mc_prev.onPress);
			delete(mc_prev.onRollOver);
			delete(mc_prev.onRollOut);
			delete(mc_prev.onRelease);
		}else{
			if(mc_prev.active==false){
				mc_prev.active=true;
				mc_prev.colorfader.fadeTo(activeTextColor,100);
			}
		}
		
		if(nItem==xml.items.item.length-1){
			mc_next.active=false;
			mc_next.colorfader.fadeTo(inactiveTextColor,200);
			delete(mc_next.onRelease);
			delete(mc_next.onPress);
			delete(mc_next.onRollOver);
			delete(mc_next.onRollOut);
		}else{
			if(mc_next.active==false){
				mc_next.active=true;
				trace("make next active");
				mc_next.colorfader.fadeTo(activeTextColor,100);
			}
		}
		
		var item:XMLSA = xml.items.item[nItem];
		
		mc_img.contentPath=item.img.getValue();
		
		tf_title.text=item.title.getValue();
		tf_copy.text=item.copy.getValue();
		
	}
}