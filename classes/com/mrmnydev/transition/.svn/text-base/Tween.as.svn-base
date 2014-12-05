/**
 * @author chris mckenzie
 * 
 * this class no longer handles color tweens, please use 'com.mrmnydev.transitions.ColorTween' for all your color tweening needs
 * 
 */
 
import com.mrmnydev.util.GlobalEnterFrame;

//this class deals with more complicated transitions
class com.mrmnydev.transition.Tween {
	
	private var count:Number;
	
	var round:Boolean = false;
	
	var onLoop:Function;
	
	public function Tween() {
		//init transition properties
	}
	
	
	public function ease(target:Object, moveObj:Object, duration:Number, func:Function, a:Object, p:Number):Void {
		//remove previous tween from GlobalEnterFrame que
		this.cancel();
		
		var begValues:Array = [];
		var changeValues:Array = [];
		var props:Array = [];
		for (var s:String in moveObj){
			var begVal:Number= (target[s]) ? target[s] : 0;
			begValues.push(begVal);
			changeValues.push(moveObj[s]-begVal);
			props.push(s);
		}
		var d:Number = duration;
		count = 0;
		GlobalEnterFrame.register(this, doEase, [begValues, changeValues, d, target, props, func, a, p]);
	}
	
	// To cancel Tween before it's finished (or when it is)
	public function cancel( Void ):Void {
		GlobalEnterFrame.unRegister(this, doEase);
	}
	
	private function doEase(begValues:Array, changeValues:Array, d:Number, target:Object, props:Array, func:Function, a:Object, p:Number):Void {
		if (count>=d) {
			//remove from GlobalEnterFrame queue
			this.cancel();
			
			for (var i:Number = 0; i < props.length; i++){
				if (this.round) target[props[i]] = Math.round(func.apply(null, [d, begValues[i], changeValues[i], d, a, p]));
				else target[props[i]] = func.apply(null, [d, begValues[i], changeValues[i], d, a, p]);
			}
			
			delete this.onLoop;
			this.onCompleteSet = false;
			if (this.onComplete) this.onComplete(target);
			if (!this.onCompleteSet) if (this.onComplete) delete this.onComplete;
			
			//this._onComplete = null;
			
		} else {
			var posObj:Object = new Object();
			for (var i:Number = 0; i < props.length; i++){
				if (this.round) target[props[i]] = posObj[props[i]] = Math.round(func.apply(null, [count, begValues[i], changeValues[i], d, a, p]));
				else target[props[i]] = posObj[props[i]] = func.apply(null, [count, begValues[i], changeValues[i], d, a, p]);
			}
			if (this.onLoop) this.onLoop(posObj);
			count++;
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
		return "[Tween]";
	}
	
}
