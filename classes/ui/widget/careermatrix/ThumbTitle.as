import ui.AnimateClip;
import ui.TextClip;
import flash.filters.DropShadowFilter;
import util.text.Style;
import mx.utils.Delegate;
import com.mrmnydev.transition.easing.Quad;
import util.draw.Rectangle;
import com.mrmnydev.util.GlobalEnterFrame;
import com.mrmnydev.transition.easing.Linear;
/**
 * @author Chris.Edwards
 */
class ui.widget.careermatrix.ThumbTitle extends AnimateClip {
	
	private var _destX:Number;
	private var _destY:Number;
	
	var anchorX:Number;
	var anchorY:Number;
	
	private var _bAnchored:Boolean;
	
	private var _bg:AnimateClip;
	private var _text:TextClip;
	private var _shadow:DropShadowFilter;
	
	private var _margin:Number;
	private var _textMask:MovieClip;
	private var _rectangle:Rectangle;


	
	function ThumbTitle() {
		super();
	}
	
	private function init():Void{
		super.init();
		this._margin = this._text._x;
		this._shadow = new DropShadowFilter(10,90,0x000000,100,10,10);	
		this._bg.filters = [this._shadow];
		this._text.tf_text.autoSize="left";
		this._textMask = this.createEmptyMovieClip("_textMask",this.getNextHighestDepth());
		this._text.setMask(this._textMask);
		this._textMask._x = this._text._x;
		this._textMask._y = this._text._y;
		this._rectangle = new Rectangle();
		
		this.destY = 0;
		this.destY = 0;
		
		this.anchorY = this._y;
		this.anchorX = this._x;
		
		this._bg._alpha = 80;
		
		this._alpha = 0;
		
		this._bAnchored = false;
		
		
	}
	public function drawTextMask():Void{
		//Draw the text Mask
		this._rectangle.width = this._bg._width-2*this._margin;
		this._rectangle.height = this._text._height;
		this._textMask.clear();
		this._textMask.beginFill(0xFFFFFF,0);
		Rectangle.draw(this._textMask,this._rectangle);
	}
	public function set text(s:String):Void{
		Style.apply(this._text.tf_text,s);
		var loop:Function = Delegate.create(this,this.drawTextMask);
		this._bg.animate({_width:this._text._width+this._margin*2},Quad.easeInOut,18,loop,loop);
		
	}
	
	
	public function show():Void{
		GlobalEnterFrame.unRegister(this,this.chase);	
		GlobalEnterFrame.register(this,this.chase);
		if(this._alpha !=100){
			this.animateAlpha(100,Linear.easeNone,4,null,null);	
		}
	}
	
	public function hide():Void{
		GlobalEnterFrame.unRegister(this,this.chase);
		var loop:Function = Delegate.create(this,this.drawTextMask);
		this._bg.animate({_width:this._margin*2},Quad.easeInOut,6,loop,loop);
		this.animateAlpha(0,Linear.easeNone,6,null,null);
	}
	
	public function chase():Void{
		
		var diffX:Number=this.destX-this._x;
		var diffY:Number = this.destY-this._y;
		
		if(Math.abs(diffX)>1||Math.abs(diffY)>1){
			this._x += diffX*.5;
			this._y += diffY*.5;
		}else {
			GlobalEnterFrame.unRegister(this,this.chase);	
			this._x = this.destX;
			this._y = this.destY;
		}
		
	}
	
	public function anchor():Void{
		this.anchored = true;	
		GlobalEnterFrame.unRegister(this,this.chase);
		GlobalEnterFrame.register(this,this.chase);
	}
	
	public function set anchored(b:Boolean):Void{this._bAnchored = b;};
	public function get anchored():Boolean{return this._bAnchored;};
	
	public function set destX(n:Number):Void{
		this._destX = n;	
	}
	public function get destX():Number{
		if(this._bAnchored) return this.anchorX;
		return this._destX;
	}
	
	public function set destY(n:Number):Void{
		this._destY = n;	
	}
	public function get destY():Number{
		if(this._bAnchored) return this.anchorY;
		return this._destY;
	}
}