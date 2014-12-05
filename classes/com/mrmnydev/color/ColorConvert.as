/**
 * @author	eKameleon (modified by Chris McKenzie)
 * @version	1.0.0
 */
 
class com.mrmnydev.color.ColorConvert {
	
	//  ------o Public Static Methods
	
	// RGB <==> HEX
	public static function rgb2hex(rgb:Object):Number  {
		if (rgb.r > 255) rgb.r = 255;
		if (rgb.r < 0) rgb.r = 0;
		if (rgb.g > 255) rgb.g = 255;
		if (rgb.g < 0) rgb.g = 0;
		if (rgb.b > 255) rgb.b = 255;
		if (rgb.b < 0) rgb.b = 0;
		return ((rgb.r << 16) | (rgb.g << 8) | rgb.b);
	}
   
	public static function hex2rgb(hex:Number):Object {
		var r:Number,g:Number,b:Number,gb:Number ;
		r = hex>>16 ;
		gb = hex ^ r << 16 ;
		g = gb>>8 ;
		b = gb^g<<8 ;
		return {r:r,g:g,b:b} ;
	}
	
	// RGB <==> HSB
	public static function rgb2hsb ( rgb:Object ):Object {
		if (rgb.r > 255) rgb.r = 255;
		if (rgb.r < 0) rgb.r = 0;
		if (rgb.g > 255) rgb.g = 255;
		if (rgb.g < 0) rgb.g = 0;
		if (rgb.b > 255) rgb.b = 255;
		if (rgb.b < 0) rgb.b = 0;
		var max:Number = Math.max(Math.max(rgb.r, rgb.g), rgb.b);
		var min:Number = Math.min(Math.min(rgb.r, rgb.g), rgb.b);
		var b:Number = Math.round(max*20/51);
		if (min == max) return {h:0, s:0, b:b};
		var s:Number = Math.round((1 - min/max)*100);
		var d:Number = max - min;
		var h:Number = Math.round((
		max == rgb.r ? 6 + (rgb.g - rgb.b)/d :
		max == rgb.g ? 2 + (rgb.b - rgb.r)/d :
		4 + (rgb.r - rgb.g)/d)
		*60) % 360;
		return {h:h, s:s, b:b};
	}
	
	static function hsb2rgb( hsb:Object ):Object {
		if (hsb.h > 360) hsb.h = 360;
		if (hsb.h < 0) hsb.h = 0;
		if (hsb.s > 100) hsb.s = 100;
		if (hsb.s < 0) hsb.s = 0;
		if (hsb.b > 100) hsb.b = 100;
		if (hsb.b < 0) hsb.b = 0;
		var max:Number = Math.round(hsb.b*51/20);
		var min:Number = Math.round(max*(1 - hsb.s/100));
		var d:Number = max - min;
		var h6:Number = hsb.h/60;
		if (h6 <= 1) return {r:max, g:Math.round(min + h6*d), b:min};
		if (h6 <= 2) return {r:Math.round(min - (h6 - 2)*d), g:max, b:min};
		if (h6 <= 3) return {r:min, g:max, b:Math.round(min + (h6 - 2)*d)};
		if (h6 <= 4) return {r:min, g:Math.round(min - (h6 - 4)*d), b:max};
		if (h6 <= 5) return {r:Math.round(min + (h6 - 4)*d), g:min, b:max};
		return {r:max, g:min, b:Math.round(min - (h6 - 6)*d)};
	}
	
	// HSB <==> HEX
	static function hsb2hex( hsb:Object ):Number {
		return ColorConvert.rgb2hex(ColorConvert.hsb2rgb(hsb));
	}
	
	static function hex2hsb( hex:Number ):Object {
		return ColorConvert.rgb2hsb(ColorConvert.hex2rgb(hex));
	}
	
	
	
	
	
	//Hex String to RGB
	static function hexStr2rgb(hexStr:String) :Object {
		return ColorConvert.hex2rgb(ColorConvert.hexStr2hex(hexStr));
	}
	
	//RGB to Hex String
	static function rgb2hexStr(rgb:Object):String {
		return ColorConvert.hex2hexStr(ColorConvert.rgb2hex(rgb));
	}
	
	static function hex2hexStr (hex:Number):String {
		var h:String = hex.toString(16);
		var toFill:Number = 6 - h.length;
		while (toFill--) h = "0" + h ;
		return "0x" + h.toUpperCase();
	}
	
	static function hexStr2hex (hexStr:String):Number {
		return parseInt(hexStr.substr(-6, 6), 16);
	}
	
	
	
	
}


