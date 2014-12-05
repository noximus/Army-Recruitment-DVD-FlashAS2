import mx.utils.Delegate;
import mx.controls.Loader;
class ui.VideoMC extends MovieClip{
	
	public var mc_pause:MovieClip;
	public var mc_progress:MovieClip;
	//public var mc_sp:Loader;
	public var mc_drag:MovieClip;
	public var mc_total:MovieClip;
	
	var mc_sp;
	
	private var mc:MovieClip;
	private var _paused:Boolean=false;
	private var _dragging:Boolean=false;
	
	function VideoMC(){
		init();
	}
	private function init():Void{
		mc=this;
		mc_drag._alpha=0;
		mc_progress._xscale=0;
		mc_pause.onPress=Delegate.create(this,Pause);
		mc_pause._alpha=70;
		mc_pause.onRollOver=function(){
			this._alpha=100;
		}
		mc_pause.onRollOut=function(){
			this._alpha=70;
		}
		
		
		
		mc.onEnterFrame=Delegate.create(this,Enterframe);
		mc_drag.onPress=Delegate.create(this,StartDrag);
		mc_drag.onRelease=mc_drag.onReleaseOutside=Delegate.create(this,StopDrag);
	}
	public function StartDrag():Void{
		_dragging=true;
		mc_drag.mc_drag.startDrag(false,0, 0, mc_total._width, 0);
		mc_sp.content.stop();
	}
	public function StopDrag():Void{
		_dragging=false;
		stopDrag();
		mc_sp.content.play();
	}
	public function Enterframe():Void{
		mc_sp.scaleContent=true;
		if(_dragging==true){
			var percent:Number=mc_drag.mc_drag._x/mc_total._width;
			mc_sp.content.gotoAndStop(Math.floor(percent*mc_sp.content._totalframes));
		}else{
			mc_drag.mc_drag._x=mc_progress._width;
		}
		mc_progress._xscale=100*(mc_sp.content._currentframe/mc_sp.content._totalframes);
	}
	public function Pause():Void{
		if(_paused==false){
			_paused=true;
			mc_sp.content.stop();
			//mc_pause.gotoAndStop("play");
		}else{
			//mc_pause.gotoAndStop("pause");
			_paused=false;
			mc_sp.content.play();
		}
	}
	
}