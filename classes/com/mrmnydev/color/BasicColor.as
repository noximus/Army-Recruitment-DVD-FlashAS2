
/**************************
* Author: eKameleon
* Site: http://www.ekameleon.net
* Version: 1.0.0
**************************/

import com.mrmnydev.color.* ;
 
class com.mrmnydev.color.BasicColor extends Color {
 
	// -----o Private MovieClip
 
	private var _mc:MovieClip;
	
	// -----o Constructor
 
	public function BasicColor (mc:MovieClip) { 
		super (mc) ;
		_mc = mc ;
	}
 
	// -----o Public Methods
 
	public function reset(Void):Void { ColorUtils.reset(this); }
 
	public function invert(Void):Void { ColorUtils.invert(this); }
 
	public function getTarget(Void):MovieClip { return _mc; }
 
	
}