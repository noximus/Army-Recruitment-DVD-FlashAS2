import mx.utils.Delegate;
import util.xml.XMLSA;
import com.senocular.ColorFader;
import mx.transitions.Tween;
import mx.transitions.easing.None;
import mx.transitions.easing.Strong;
import mx.transitions.easing.Regular;
import flash.filters.BitmapFilter;
import flash.filters.ColorMatrixFilter;

class ui.qtvr.Thumb extends ui.photogallery.Thumb{
	
	private var mc:MovieClip;
	public var mc_border:MovieClip;
	public var mc_img:MovieClip;
	
	private static var activeThumbQT:Thumb=null;
	private var saturation:Number;
	private var saturationTween:Tween;
	private var green:Number=0x7D9364;
	private var yellow:Number=0xFFCC00;
	private var _xml:XMLSA;
	private var tf_title,tf_title_black:TextField;
	
	private var colorfader:ColorFader;
	
	function Thumb(){
		super();
	}
	public function Select():Void{
		colorfader.fadeTo(white);
		super.DisableMouseEvents();
		activeThumbQT.Unselect();
		activeThumbQT=this;
		saturate(saturation,1,2);
		
		this._parent._parent.LoadFLV(i);
		
	}
	public function Unselect():Void{
		EnableMouseEvents();
		colorfader.fadeTo(yellow,200);
		saturate(saturation,.7,15);
	}
	private function RollOver():Void{
		colorfader.fadeTo(white,10);
		saturate(saturation,1.1,4);
	}
	private function RollOut():Void{
		colorfader.fadeTo(yellow,300);
		saturate(saturation,.7,15);
	}
	private function init():Void{
		mc=this;
		colorfader = new ColorFader(tf_title);
		colorfader.fadeTo(yellow,1);
		EnableMouseEvents();
		
		mc_img.loadMovie(this.xml.img.getValue());
		tf_title.text=this.xml.title.getValue();
		tf_title_black.text=this.xml.title.getValue();
		saturate(1.2, .7, 30);
		
	}
	
	
}