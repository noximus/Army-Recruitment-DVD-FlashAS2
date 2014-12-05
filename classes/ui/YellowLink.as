import util.xml.XMLSA;
import com.senocular.ColorFader;
import mx.utils.Delegate;
class ui.YellowLink extends MovieClip{
	private var cf:ColorFader;
	private var _xml:XMLSA;
	private var yellow:Number=0xffcc00;
	private var white:Number=0xffffff;
	private var settings:Settings;
	private var tf_link:TextField;
	public var mc_arrow:MovieClip;
	private function init():Void{
		settings = new Settings();
		this.onRollOver=Delegate.create(this,_rollover);
		this.onRollOut=Delegate.create(this,_rollout);
		this.onPress=Delegate.create(this,_press);
		cf=new ColorFader(this);
		cf.fadeTo(yellow);
		trace("get text:" + xml.attributes.text);
		tf_link.text=settings.ref.GetString(xml.attributes.text);
		tf_link.autoSize=true;
		if(mc_arrow){
			mc_arrow._x=tf_link._x+tf_link._width+4;
		}
	}
	private function _rollover():Void{
		cf.fadeTo(white,10);
		settings.sounds.Play("sound.over");
	}
	private function _rollout():Void{
		cf.fadeTo(yellow,400);
	}
	private function _press():Void{
		settings.sounds.Play("sound.select");
		getURL(this.xml.attributes.href,"_blank");
	}
	public function get xml():XMLSA{
		return _xml;
	}
	public function set xml(val:XMLSA):Void{
		_xml=val;
		init();
	}
	
}