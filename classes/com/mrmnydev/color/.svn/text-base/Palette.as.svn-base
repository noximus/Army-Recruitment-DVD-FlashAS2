/**
 * @author	chris mckenzie
 */
 
class com.mrmnydev.color.Palette {
	
	static var colors:Object = new Object();
	
	//adds a color to the palette
	static function registerColor(colorName:String, hex:Number):Void {
		colors[colorName] = hex;
	}
	//removes a color from the palette
	static function unRegisterColor(colorName:String):Void {
		delete colors[colorName];
	}
	
	
	// sets the color based on name
	static function setColor(target:MovieClip, colorName:String):Void {
		var objRef:Color = new Color(target);
		objRef.setRGB(colors[colorName]);
	}
	
	// sets the color for any given hex number
	static function setArbitraryColor(target:MovieClip, hex:Number):Void {
		var objRef:Color = new Color(target);
		objRef.setRGB(hex);
	}
	
	// returns the blend of two colors
	static function mixColors(color1:Number, color2:Number):Number {
		return (color1 + color2)/2;
	}
	
	
}