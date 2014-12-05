import mx.transitions.Tween;
import mx.transitions.easing.None;
import mx.transitions.easing.Regular;
class ui.Camostripe extends MovieClip{
	public var mc_camostripe:MovieClip;
	public var mc_mask:MovieClip;
	private var mc:MovieClip;
	private var settings:Settings;
	private var tween:Object;
	public function Camostripe(){
		init();
	}
	private function init():Void{
		mc=this;
		settings = new Settings();
		settings.mainCamostripe=this;
		mc_camostripe.cacheAsBitmap=true;
		mc_mask.cacheAsBitmap=true;
		mc_camostripe.setMask(mc_mask);
	}
	public function In():Void{
		tween.y = new Tween(mc_mask,"_y",Regular.easeOut,mc_mask._y,mc_mask._y+770,35,false);
		tween.alpha = new Tween(mc_camostripe,"_alpha",Regular.easeOut,0,60,35,false);
	}
	public function Out():Void{
		tween.y = new Tween(mc_mask,"_y",Regular.easeOut,mc_mask._y,mc_mask._y-770,35,false);
		tween.alpha = new Tween(mc_camostripe,"_alpha",Regular.easeOut,mc_camostripe._alpha,60,35,false);
	}
	
}