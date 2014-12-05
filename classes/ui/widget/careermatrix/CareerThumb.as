import ui.AnimateClip;
import mx.events.EventDispatcher;
import mx.utils.Delegate;
import ui.widget.careermatrix.Career;
import util.draw.Rectangle;
import com.mrmnydev.transition.easing.Quad;
import com.mrmnydev.transition.ColorTween;
import com.mrmnydev.transition.Tween;
import com.mrmnydev.transition.easing.Linear;
import flash.filters.BlurFilter;
/**
 * @author CHris.Edwards
 */
class ui.widget.careermatrix.CareerThumb extends AnimateClip {
	
	public static var OPEN_HEIGHT:Number = 75;
	public static var WIDTH:Number = 74;
	public static var CLOSE_HEIGHT:Number = 32;
	
	public static var SHADOW:Number = 2;
	

	private var _img:MovieClip;
	private var _stroke:MovieClip;
	private var _imgMask:MovieClip;
	private var _bg:MovieClip;
	
	private var _career:Career;
	private var _rectangle:Rectangle;
	
	private var _ctStroke:ColorTween;
	
	
	private var _overPercent:Number;
	
	private var _bfShadow:BlurFilter;
	
	
	//for dispatching events	
	private var dispatchEvent:Function;
	public var addEventListener:Function;
	public var removeEventListener:Function;
	//
	function CareerThumb() {
		super();
	}
	
	private function init():Void{
		super.init();	
		EventDispatcher.initialize(this);
		
		this._bg = this.createEmptyMovieClip("_bg",this.getNextHighestDepth());
		this._img = this.createEmptyMovieClip("_img",this.getNextHighestDepth());
		this._imgMask = this.createEmptyMovieClip("_imgMask",this.getNextHighestDepth());
		this._stroke = this.createEmptyMovieClip("_stroke",this.getNextHighestDepth());
		
		this._overPercent = 0;
		
		this._rectangle = new Rectangle(CareerThumb.WIDTH,CareerThumb.CLOSE_HEIGHT);
		
		this._img.setMask(this._imgMask);
		
		
		var color:Color = new Color(this._stroke);
		color.setRGB(0x6C7E57);
		this._ctStroke = new ColorTween(color);
		
		this.cacheAsBitmap = true;
		
		this._bfShadow = new BlurFilter(0,0,3);
		
		this.render();
		
	}
	public function onSelected():Void{
		// can be overwritten, but if not it dispatches an event;
		this.dispatchEvent({type:"onThumbSelected",career:this._career});	
	}
	
	public function onHidden():Void{
		// can be overwritten, but if not it dispatches an event;
		this.dispatchEvent({type:"onThumbHidden",career:this._career});	
	}
	public function onShown():Void{
		// can be overwritten, but if not it dispatches an event;
		this.dispatchEvent({type:"onThumbShown",career:this._career});	
	}
	public function load():Void{
		
		this._img._alpha = 0;
		var mcl:MovieClipLoader = new MovieClipLoader();
		var lis:Object = new Object();
		var ref:Object = this;
		
		//Delegate.create(this,this.onLoadInit);
		mcl.addListener(this);
		mcl.loadClip(this._career.url,this._img);
		
	}
	
	public function onLoadInit():Void{
		this._img.setMask(this._imgMask);
		
		//if it's not hidden tween image
		//else make the image visible
		if(this._alpha!=0){
			
			var t:Tween = new Tween();
		
			t.ease(this._img,{_alpha:100},12,Linear.easeNone);
			
		}else {
			
			this._img._alpha = 100;	
			
		}
	}
	

	
	
	public function enable():Void{
		
		this.useHandCursor = true;
		
		this.onRelease = Delegate.create(this,this.onSelected);	
		this.onRollOver = Delegate.create(this,this.doRollOver);
		this.onRollOut = Delegate.create(this,this.doRollOut);
	
	}
	
	public function disable():Void{
		
		this.useHandCursor = false;
		
		this.onRelease = null;
		delete this.onRelease;	
		
		this.onRollOver = null;
		delete this.onRollOver;	
		
		this.onRollOut = null;
		delete this.onRollOut;	
		
	}
	
	public function show():Void{
		this.animateAlpha(100,Linear.easeNone,8,Delegate.create(this,this.onShown),null);
	}
	
	public function hide():Void{
		this.disable();
		this.animateAlpha(0,Linear.easeNone,6,Delegate.create(this,this.onHidden),null);
	}
	
	public function doRollOver():Void{
		this.dispatchEvent({type:"onThumbOver",career:this._career});
		//
		this.swapDepths(_parent.getNextHighestDepth());
		var render:Function = Delegate.create(this,this.render);
		this.animate({overPercent:100},Quad.easeIn,8,render,render);
		this._ctStroke.ease(0xFBD016,4);
	}

	public function doRollOut():Void{
		this.dispatchEvent({type:"onThumbOut",career:this._career});
		//
		this._ctStroke.ease(0x6C7E57,8);
		var render:Function = Delegate.create(this,this.render);
		this.animate({overPercent:0},Quad.easeOut,8,render,render);
	}
	
	
	// sets properties based on rollOverPercent
	public function render():Void{
		
		var openDiff:Number = CareerThumb.OPEN_HEIGHT-CareerThumb.CLOSE_HEIGHT;
		
		
		this._rectangle.y= -.005*this._overPercent*openDiff;
		//this._rectangle.x = this._overPercent*.01*SHADOW;
		this._rectangle.height = CLOSE_HEIGHT+this._overPercent*.01*openDiff;//+Math.abs(this._rectangle.y);
		
		//
		//TODO look up linestyle properties for scaling;
		this._stroke.clear();
		this._stroke.lineStyle(1,0xFFFFFF,100);
		Rectangle.draw(this._stroke,this._rectangle,true,0,0);
		
		//
		
		this._bg.clear();
		this._bg.beginFill(0x000000,100);
		Rectangle.draw(this._bg,this._rectangle,true);
		this._bg.endFill();
		
		this._bfShadow.blurX = SHADOW*this._overPercent*.1;
		this._bfShadow.blurY = SHADOW*this._overPercent*.1;
		this._bg.filters=[this._bfShadow];
		
		this._imgMask.clear();
		this._imgMask.beginFill(0xFFFFFF,100);
		Rectangle.draw(this._imgMask,this._rectangle,true);
		this._imgMask.endFill();
		//
		this._img._y = this._rectangle.y;
	}
	
	public function get indicatorY():Number{
		return this._y + CLOSE_HEIGHT+.5*(OPEN_HEIGHT-CLOSE_HEIGHT);
	}
	
	public function set overPercent(n:Number):Void{this._overPercent = n;};
	public function get overPercent():Number {return this._overPercent;};
	
	public function set career(c:Career):Void{this._career = c;};
	public function get career():Career{return this._career;};
	
	
}