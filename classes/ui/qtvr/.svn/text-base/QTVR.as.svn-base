import mx.utils.Delegate;
import util.xml.XMLSA;
import mx.transitions.Tween;
import mx.transitions.easing.Regular;
import mx.transitions.easing.None;
import com.senocular.ColorFader;
class ui.qtvr.QTVR extends MovieClip{
	
	public var mc_drag:MovieClip;
	public var mc_track:MovieClip;
	private var mc:MovieClip;
	public var mc_thumbs:MovieClip;
	private var cf_drag:ColorFader;
	private var mc_swf:MovieClip;
	
	private var green:Number=0x7D9364;
	private var yellow:Number=0xFFCC00;
	private var white:Number=0xFFFFFF;
	
	private var _dragging:Boolean=false;
	private var xml:XMLSA;
	private var settings:Settings;
	
	function QTVR(){
		init();
	}
	private function init():Void{
		mc=this;
		cf_drag = new ColorFader(mc_drag);
		settings = new Settings();
		xml = settings.ref.GetNode("ait_qtvr/items");
		var thumb:MovieClip;
		for(var i:Number=0;i<xml.item.length;i++){
			thumb = mc_thumbs.attachMovie("ui.qtvr.Thumb","thumb_"+i,i);
			thumb.xml=xml.item[i];
			thumb._y=thumb._height*i;
			thumb.i=i;
		}

		mc_thumbs["thumb_0"].Select();

	}
	private function StartDrag():Void{
		mc.onEnterFrame=Delegate.create(this,Enterframe);
		mc_drag.startDrag(false, mc_track._x, mc_drag._y, mc_track._x+mc_track._width, mc_drag._y);
	}
	private function StopDrag():Void{
		mc_drag.stopDrag();
		delete(mc.onEnterFrame);
	}
	public function Enterframe():Void{

		var percent = ((mc_drag._x-mc_track._x)/mc_track._width);
		mc_swf.gotoAndStop(Math.floor(percent*mc_swf._totalframes))
		
	}
	private function ResetDrag():Void{
		//puts the mc_drag in the center of mc_track
		var tween = new Tween(mc_drag,"_x",Regular.easeInOut,mc_drag._x,mc_track._x+mc_track._width/2,20,false);
		tween.onMotionFinished=Delegate.create(this,EnableDragging);
		mc_swf.gotoAndStop(Math.floor(.5*mc_swf._totalframes));
	}
	private function EnableDragging():Void{
		mc_drag.onPress=Delegate.create(this,StartDrag)		
		mc_drag.onRelease=mc_drag.onReleaseOutside=Delegate.create(this,StopDrag);
		mc_drag.onRollOver=Delegate.create(this,RollOver);
		mc_drag.onRollOut=Delegate.create(this,RollOut);
	}
	private function RollOut():Void{
		cf_drag.fadeTo(white,200);
	}
	private function RollOver():Void{
		cf_drag.fadeTo(yellow,10);
	}
	public function FadeUp():Void{
		//it's ready. fade up the swf and put it in the middle of the timeline.
		var tween_alpha = new Tween(mc_swf,"_alpha",None.easeNone,0,100,10,false);
		mc_swf.gotoAndStop(Math.floor(.5*mc_swf._totalframes));
	}
	public function LoadFLV(id:Number):Void{

		delete(mc_drag.onPress);
		delete(mc_drag.onRelease);
		delete(mc_drag.onReleaseOutside);
		delete(mc_drag.onRollOver);
		delete(mc_drag.onRollOut);
		
		ResetDrag();
		
		var mcl:MovieClipLoader = new MovieClipLoader();
		var mcl_l:Object = new Object();
		mcl_l.onLoadComplete=function(target_mc:MovieClip):Void{
			target_mc._parent.FadeUp();
		}
		mcl.addListener(mcl_l);
		mcl.loadClip(xml.item[id].swf.getValue(),mc_swf);

	}
	
}