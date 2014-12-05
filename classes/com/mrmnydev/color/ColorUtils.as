
/**************************
* Author: eKameleon
* Site: http://www.ekameleon.net
* Version: 1.0.0
**************************/

class com.mrmnydev.color.ColorUtils {
	
	//  ------o Public Static Methods
	
	
	public static function invert(c:Color):Void {
		var t:Object = c.getTransform();
		c.setTransform ( {
			ra : -t.ra , ga : -t.ga , ba : -t.ba ,
			rb : 255 - t.rb , gb : 255 - t.gb , bb : 255 - t.bb 
		} ) ;
	}
 
	public static function reset(c:Color):Void { 
		c.setTransform ({ra:100, ga:100, ba:100, rb:0, gb:0, bb:0}) ;
	}	
	
}