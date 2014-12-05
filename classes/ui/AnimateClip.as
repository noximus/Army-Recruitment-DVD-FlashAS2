import flash.filters.BlurFilter;
import com.mrmnydev.transition.Tween;

/**
 * @author Chris.Edwards
 */

 //
class ui.AnimateClip extends MovieClip{
	
	private var _tween:Tween;
	private var _tX:Tween;
	private var _tY:Tween;
	private var _tScale:Tween;
	private var _tAlpha:Tween;
	
	
	private var _clip:MovieClip;
	
	private var _id:Object;
	
	private var _blurFilter:BlurFilter;
	
	
	//public var onMotionComplete:Function;
	
	function AnimateClip(){
		super();
		//trace(this);
		this.init();
	}
	//PRIVATE FUNCTIONS
	//____________________________________
	private function init():Void{
		
		this._blurFilter = new BlurFilter(0,0,1);
		this._tween = new Tween();
		this._tX = new Tween();
		this._tY = new Tween();
		this._tScale = new Tween();
		this._tAlpha = new Tween();
	}
	
	//PUBLIC FUNCTIONS
	//____________________________________
	
	private function animateTween(tween:Tween,dest:Object,func:Function,duration:Number,callback:Function,loop:Function):Void{
		tween.onLoop = loop;
		tween.onComplete = callback;
		tween.ease(this,dest,duration,func);
	}
	
	
	public function animate(dest:Object,func:Function,duration:Number,callback:Function,loop:Function):Void{
		this.animateTween(this._tween,dest,func,duration,callback,loop);
	}
	public function animateX(dest:Number,func:Function,duration:Number,callback:Function,loop:Function):Void{
		this.animateTween(this._tX,{_x:dest},func,duration,callback,loop);
	}
	public function animateY(dest:Number,func:Function,duration:Number,callback:Function,loop:Function):Void{
		this.animateTween(this._tY,{_y:dest},func,duration,callback,loop);
	}
	public function animateScale(dest:Number,func:Function,duration:Number,callback:Function,loop:Function):Void{
		this.animateTween(this._tScale,{scale:dest},func,duration,callback,loop);
	}
	public function animateAlpha(dest:Number,func:Function,duration:Number,callback:Function,loop:Function):Void{
		this.animateTween(this._tAlpha,{_alpha:dest},func,duration,callback,loop);
	}
	
	public function set blur(n:Number):Void{
		this._blurFilter.blurY = n;
		this._blurFilter.blurX = n;
		this.filters = [this._blurFilter];
	}
	public function get blur():Number{
		 return this._blurFilter.blurX;
		
	}
	
	public function set blurY(n:Number):Void{
		this._blurFilter.blurY = n;
		
		this.filters = [this._blurFilter];
	}
	public function get blurY():Number{
		 return this._blurFilter.blurY;
		
	}
	public function set blurX(n:Number):Void{
		this._blurFilter.blurX = n;
		
		this.filters = [this._blurFilter];
	}
	public function get blurX():Number{
		 return this._blurFilter.blurX;
		
	}
	
	public function set id(id:Object):Void{
		this._id = id;	
	}
	public function get id():Object{
		return this._id;	
	}
	public function set scale(n:Number):Void{
		this._xscale = this._yscale = n;	
	}
	public function get scale():Number{
		return this._xscale;	
	}
	
}