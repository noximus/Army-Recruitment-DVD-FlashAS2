import mx.transitions.Tween;
import mx.transitions.easing.Regular;
import mx.transitions.easing.None;
import mx.utils.Delegate;
class ui.reserves.Community extends MovieClip{
	private var settings:Settings;
	public var mc_panels,mc_map:MovieClip;
	private var yMove:Number=8;
	private var tween:Object;
	public function Community(){
		init();
	}
	private function init():Void{
		settings = new Settings();
		settings.community=this;
	}
	public function Map():Void{
		tween.alpha = new Tween(mc_panels,"_alpha",None.easeNone,100,0,8,false);
		tween.y = new Tween(mc_panels,"_y",Regular.easeIn,mc_panels._y,mc_panels._y+yMove,8,false);
		tween.y.onMotionFinished=Delegate.create(this,BringUpMap);
	}
	public function Back():Void{
		tween.alpha = new Tween(mc_map,"_alpha",None.easeNone,100,0,8,false);
		tween.y = new Tween(mc_map,"_y",Regular.easeIn,mc_map._y,mc_map._y+yMove,8,false);
		tween.y.onMotionFinished=Delegate.create(this,BringMeUp);
	}
	private function BringMeUp():Void{
		mc_map._visible=false;
		mc_map._y-=yMove;
		mc_panels._visible=true;
		tween.alpha = new Tween(mc_panels,"_alpha",None.easeNone,0,100,8,false);
		tween.y = new Tween(mc_panels,"_y",Regular.easeOut,mc_panels._y+yMove,mc_panels._y,8,false);
	}
	private function BringUpMap():Void{
		mc_panels._visible=false;
		mc_panels._y-=yMove;
		
		mc_map.loadMovie("zipcodetest.swf");
		tween.alpha = new Tween(mc_map,"_alpha",None.easeNone,0,100,8,false);
		tween.y = new Tween(mc_map,"_y",Regular.easeOut,mc_map._y+yMove,mc_map._y,8,false);
		
	}
}