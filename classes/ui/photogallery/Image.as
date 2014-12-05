import mx.utils.Delegate;
import util.xml.XMLSA;
import com.senocular.ColorFader;
import mx.transitions.Tween;
import mx.transitions.easing.None;
import mx.transitions.easing.Strong;
import mx.transitions.easing.Regular;
import flash.filters.BitmapFilter;
import flash.filters.ColorMatrixFilter;

class ui.photogallery.Image extends MovieClip{
	
	private var mc:MovieClip;
	private var saturation:Number=1;
	private var colorTweens:Object;
	public var mc_img:MovieClip;
	private var saturationTween:Tween;
	
	function PhotoGallery(){
		init();
	}
	private function init():Void{
		mc=this;
		colorTweens = new Object();
		
		
	}
	public function FadeOut():Void{
		saturationTween = new Tween(this, "saturation", Regular.easeInOut, 1, 3, 20, false);
		saturationTween.onMotionChanged = function(){
			var matrix:Array = new Array();
			var target_mc=this.obj;
			matrix = matrix.concat([target_mc.saturation, 0, 0, 0, 0]); // red
			matrix = matrix.concat([0, target_mc.saturation, 0, 0, 0]); // green
			matrix = matrix.concat([0, 0, target_mc.saturation, 0, 0]); // blue
			matrix = matrix.concat([0, 0, 0, 1, 0]); // alpha
			var filter = new ColorMatrixFilter(matrix);
			target_mc.filters = new Array(filter);
		}
	}
	public function FadeIn():Void{
		this.swapDepths(this._parent.getNextHighestDepth());
		
		var tweena:Tween = new Tween(this,"_alpha",None.easeNone,-20,100,20,false);
		
		saturationTween = new Tween(this, "saturation", Regular.easeInOut, 3, 1, 30, false);
		saturationTween.onMotionChanged = function(){
			var matrix:Array = new Array();
			var target_mc=this.obj;
			matrix = matrix.concat([target_mc.saturation, 0, 0, 0, 0]); // red
			matrix = matrix.concat([0, target_mc.saturation, 0, 0, 0]); // green
			matrix = matrix.concat([0, 0, target_mc.saturation, 0, 0]); // blue
			matrix = matrix.concat([0, 0, 0, 1, 0]); // alpha
			var filter = new ColorMatrixFilter(matrix);
			target_mc.filters = new Array(filter);
		}
	}
	
	

	
}