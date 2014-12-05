import mx.transitions.easing.None;
import mx.transitions.easing.Regular;
import mx.transitions.Tween;
class ui.main.Stripe extends MovieClip{
	private var mc:MovieClip;
	public var mc_mask:MovieClip;
	private var settings:Settings;
	private var tween:Object;
	public function Stripe(){
		init();
	}
	private function init():Void{
		settings = new Settings();
		tween = new Object();
		mc_mask._alpha=0;
	}
	public function Out():Void{
		tween.left = new Tween(this,"_x",Regular.easeIn,this._x,this._x-500,settings.mainNav.tweenTime*1.5,false);
		tween.mask = new Tween(mc_mask,"_y",Regular.easeIn,mc_mask._y,mc_mask._y-800,settings.mainNav.tweenTime*.5,false);
	}
	public function In():Void{
		tween.left = new Tween(this,"_x",Regular.easeOut,this._x,this._x+500,settings.mainNav.tweenTime*1.5,false);
		tween.mask = new Tween(mc_mask,"_y",Regular.easeOut,mc_mask._y,mc_mask._y+800,settings.mainNav.tweenTime*1.5,false);
	}
}