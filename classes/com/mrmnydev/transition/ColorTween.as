/**
 * @author chris mckenzie
*/
 
import com.mrmnydev.util.GlobalEnterFrame;
import com.mrmnydev.color.*;
 
 
class com.mrmnydev.transition.ColorTween {
	
	private var color:Color;
	private var count:Number;
	
	var onLoop:Function;
	
	function ColorTween(color:Color) {
		this.color = color;
	}
	
	function ease(newHex:Number, duration:Number):Void {
		cancel();
		if (!duration) duration = 10;
		
		var rgbNew:Object = ColorConvert.hex2rgb(newHex);
		var rgb:Object = ColorConvert.hex2rgb(this.color.getRGB());
		
		var factor1:Number = (rgbNew.r-rgb.r)/duration;
		var factor2:Number = (rgbNew.g-rgb.g)/duration;
		var factor3:Number = (rgbNew.b-rgb.b)/duration;
		this.count = 0;
		GlobalEnterFrame.register(this, doEase, [rgb, rgbNew, duration, factor1, factor2, factor3]);
	}
	
	function cancel( Void ):Void {
		GlobalEnterFrame.unRegister(this, doEase);
	}
	
	private function doEase(rgb:Object, rgbNew:Object, frames:Number, factor1:Number, factor2:Number, factor3:Number):Void {
		//add to counter
		this.count++;
		
		// set r, g, and b value increments
		rgb.r += factor1;
		rgb.g += factor2;
		rgb.b += factor3;
		
		// set new color
		if (this.count>frames) {
			rgb.r = rgbNew.r;
			rgb.g = rgbNew.g;
			rgb.b = rgbNew.b;
			this.color.setRGB(ColorConvert.rgb2hex(rgb));
			this.cancel();
			
			delete this.onLoop;
			this.onCompleteSet = false;
			if (this.onComplete) this.onComplete(this.color);
			if (!this.onCompleteSet) {
				if (this.onComplete) delete this.onComplete;
			}
			
		} else {
			this.color.setRGB(ColorConvert.rgb2hex(rgb));
		}
	}
	
	
	
	
	private var _onComplete:Function;
	private var onCompleteSet:Boolean;
	
	function set onComplete ( f:Function ) {
		this.onCompleteSet = true;
		this._onComplete = f;
	}
	
	function get onComplete () {
		return this._onComplete;
	}
	
	
	
	
	
	function toString ():String {
		return "[ColorTween]";
	}
	
}