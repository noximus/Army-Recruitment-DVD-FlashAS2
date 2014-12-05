
/**************************
* Author: eKameleon
* Site: http://www.ekameleon.net
* Version: 1.0.0
**************************/

import com.mrmnydev.color.* ;
 
class com.mrmnydev.color.TintColor extends BasicColor {
 
	// -----o Constructor
 
	public function TintColor (mc:MovieClip) { super(mc); };
 
	// -----o Public Methods
 
	public function getTint():Object {
		var t:Object = this.getTransform();
		var percent:Number = 100 - t.ra ;
		var ratio:Number = 100 / percent;
		return { 
			percent: percent ,
			r : t.rb * ratio ,
			g : t.gb * ratio ,
			b : t.bb * ratio 
		};
	}
 
	public function setTint(rgb:Object, percent:Number):Void {
		var ratio:Number = percent / 100;
		var t:Object = { rb:rgb.r*ratio, gb:rgb.g*ratio, bb:rgb.b*ratio };
		t.ra = t.ga = t.ba = 100-percent ;
		setTransform (t);
	}
 
	public function getTint2():Object {
		var t:Object = getTransform();
		var percent:Number = 100 - t.ra ;
		var ratio:Number = 100 / percent ;
		return { 
			percent:percent ,
			rgb:ColorConvert.rgb2hex({r:t.rb*ratio, g:t.gb*ratio, b:t.bb*ratio}) 
		};
	}
	
	public function setTint2(hex:Number, percent:Number):Void {
		var c:Object = ColorConvert.hex2rgb (hex) ;
		var ratio:Number = percent / 100 ;
		var t:Object = {rb:c.r*ratio, gb:c.g*ratio, bb:c.b*ratio};
		t.ra = t.ga = t.ba = 100-percent;
		setTransform (t);
	}
 
 
	public function setTintOffset(rgb:Object):Void {
		var t:Object = getTransform();
		with (t) { rb = rgb.r ; gb = rgb.g ; bb = rgb.b; };
		setTransform (t);
	}
 
	public function getTintOffset():Object {
		var t:Object = getTransform() ;
		return {r:t.rb, g:t.gb, b:t.bb} ;
	}
 
}



