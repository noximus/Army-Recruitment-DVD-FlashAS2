
/*
 * @author Chris McKenzie 
 */
//EnterFrame class for Tween class usage

class com.mrmnydev.util.GlobalEnterFrame {
	
	private static var registry:Array = [];
	
	
	static function start():Void {
		if (!_root.enterFrameContainer){
			_root.createEmptyMovieClip("enterFrameContainer", 9786);
			_root.enterFrameContainer.onEnterFrame = GlobalEnterFrame.loop;
		}
	}
	static function stop():Void {
		delete _root.enterFrameContainer.onEnterFrame;
		_root.enterFrameContainer.removeMovieClip();
	}
	
	
	static function register(obj:Object, func:Function, args:Array):Void {
		if (registry.length == 0){
			GlobalEnterFrame.start();
		}
		registry.push([obj, func, args]);
	}
	static function unRegister(obj:Object, func:Function):Void {
		for (var i:Number = 0; i<registry.length; i++) {
			if (obj == registry[i][0]) {
				if (func == registry[i][1]) {
					registry.splice(i, 1);
					if (registry.length == 0){
						GlobalEnterFrame.stop();
					}
					break;
				}
			}
		}
	}
	static function clearRegistry ():Void {
		GlobalEnterFrame.flush();
	}
	static function flush():Void{
		GlobalEnterFrame.stop();
		GlobalEnterFrame.registry = [];
	}
	
	
	private static function loop():Void {
		//trace(registry.length);
		
		for (var i:Number = 0; i<registry.length; i++) {
			registry[i][1].apply(registry[i][0], registry[i][2]);
		}
	}
	
}
