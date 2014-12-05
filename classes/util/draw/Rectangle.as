/**
 * @author CHris.Edwards
 */
class util.draw.Rectangle {
	
	
	
	public static function draw(mc:MovieClip,rectangle:Rectangle,clear:Boolean,fill:Number,alpha:Number):Void{
		if(clear){
			if(alpha==undefined) alpha =100;
			if(fill){
				mc.beginFill(fill,alpha);
				
			}else {
				mc.beginFill(0,alpha);
			}
		}
		
		mc.moveTo(rectangle.x,rectangle.y);
		mc.lineTo(rectangle.width+rectangle.x,rectangle.y);
		mc.lineTo(rectangle.width+rectangle.x,rectangle.y+rectangle.height);
		mc.lineTo(rectangle.x,rectangle.y+rectangle.height);
		mc.lineTo(rectangle.x,rectangle.y);
		
		if(clear) mc.endFill();
	}
	
	
	private var _x:Number;
	private var _y:Number;
	private var _width:Number;
	private var _height:Number;
	
	
	public function Rectangle(width:Number,height:Number,x:Number,y:Number){
		this.init(width,height,x,y);
	}
	private function init(width:Number,height:Number,x:Number,y:Number):Void{
		
		if(width)this._width = width; else this._width = 0;
		
		if(height)this._height = height; else this._height = 0;
		
		if(x)this._x = x; else this._x = 0;
		
		if(y)this._y = y; else this._y = 0;
	}
	
	public function get x():Number{return this._x;};
	public function set x(n:Number):Void{this._x = n;};
	public function get y():Number{return this._y;};
	public function set y(n:Number):Void{this._y = n;};
	
	public function get width():Number{return this._width;};
	public function set width(n:Number):Void{this._width = n;};
	public function get height():Number{return this._height;};
	public function set height(n:Number):Void{this._height = n;};
}