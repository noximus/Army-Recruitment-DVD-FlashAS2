import com.senocular.ColorFader;
import mx.utils.Delegate;
class ui.Clickhere extends MovieClip{
	private var mc:MovieClip;
	public var tf_click:TextField;
	private var cf:ColorFader;
	private var settings:Settings;
	public function Clickhere(){
		init();
	}
	private function init():Void{
		mc=this;
		settings = new Settings();
		cf=new ColorFader(tf_click);
		cf.fadeTo(0xffcc00,1);
		this.onRollOver=Delegate.create(this,RollOver);
		this.onRollOut=Delegate.create(this,RollOut);
		this.onPress=Delegate.create(this,Press);
		
	}
	private function RollOver():Void{
		cf.fadeTo(0xffffff,5);
		this.gotoAndStop("over");
	}
	private function RollOut():Void{
		cf.fadeTo(0xffcc00,100);
		this.gotoAndStop("up");
	}
	private function Press():Void{
		this.gotoAndStop("up");
		cf.fadeTo(0xffcc00,100);
		settings.community.Map();
	}
	
}