import mx.utils.Delegate;
import util.xml.XMLSA;
import com.senocular.ColorFader;
import mx.transitions.Tween;
import mx.transitions.easing.None;
import mx.transitions.easing.Strong;
import mx.transitions.easing.Regular;
import flash.filters.BitmapFilter;
import flash.filters.ColorMatrixFilter;

class ui.photogallery.Thumb_life extends ui.photogallery.Thumb{

	private var mc:MovieClip;
	public var mc_border:MovieClip;
	public var mc_img:MovieClip;
	
	private static var activeThumb:Thumb_life=null;
	private var saturation:Number;
	private var saturationTween:Tween;
	private var green:Number=0x7D9364;
	private var yellow:Number=0xFFCC00;
	private var white:Number=0xFFFFFF;
	private var _xml:XMLSA;
	private var _i:Number;
	
	private var colorfader:ColorFader;
	
	function Thumb_life(){
		super();
	}
	private function init():Void{
		mc=this;
		
		colorfader = new ColorFader(mc_border);
		colorfader.fadeTo(green,1);
		
		EnableMouseEvents();
		
		mc_img.loadMovie(this.xml.thumb.getValue());
		saturate(1.1, .7, 30);
		
	}
	
	
}