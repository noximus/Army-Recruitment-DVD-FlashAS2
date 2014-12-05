/**
 * @author chrisedwards
 */
class com.mrmnydev.util.IntervalManager {

	
	// objects listening for interval notifications
	static private var __listeners:Object = {};
	// unique ID to be assigned to non-movieclip objects for identification
	static private var __intervalID:Number = 0;

	function IntervalManager() {}

	// calls global setInterval function and stores interval reference
	// 	connection: object calling the setInterval
	// 	intName: the name of the interval to be stored
	//	path: the path to the function that will be called every interval
	//	func: the name of the function that will be called every interval
	// 	time: the interval time between function calls
	static public function setInterval(connection:Object, intName:String, path:Object, func:String, time:Number):Void {
		// ensures previous call from same object is cleared
		
		IntervalManager.clearInterval(connection,intName);
	//	trace("called from IntervalManager.setInterval");
		// stores interval based on the movie clip
		
		if (connection instanceof MovieClip) {
			// stores a reference to the movie clip in the __listeners object and assigns a new object to that reference
			if (__listeners[connection] == undefined){ __listeners[connection] = {};}
			// calls setInterval and stores the interval reference in the __listeners object under the movie clip and interval name
			__listeners[connection][intName] = _global.setInterval(path, func, time, arguments[5], arguments[6], arguments[7], arguments[8], arguments[9], arguments[10]);
		// if a non-movieclip calls, then storing must be done differently
		} else {
			// if an ID has not yet been assigned, this is done
			if (connection.intervalID == undefined){
				connection.intervalID = "int" + (__intervalID++);	
			}		
			// stores a reference to this object in the __listeners object and assigns a new object to that reference
			__listeners[connection.intervalID] = {};
			// calls setInterval and stores the interval reference in the __listeners object under the ID and interval name
			__listeners[connection.intervalID][intName] = _global.setInterval(path, func, time, arguments[5], arguments[6], arguments[7], arguments[8], arguments[9], arguments[10]);
		}
	}

	// clears an interval call
	// 	connection: object that called the setInterval
	// 	intName: the name of the interval stored
	static public function clearInterval(connection:Object, intName:String):Void {
		// interval is cleared based on how it was stored
	//	trace("clearInterval:"+connection + intName);
	//	trace(connection[intName]);
	//	trace("IntervalManager.clearInterval:"+connection+",intName:"+intName+")");
		if (connection instanceof MovieClip) {
			_global.clearInterval(__listeners[connection][intName]);
		} else {
			//trace("!"+__listeners[connection.intervalID][intName]+"!");
			
			_global.clearInterval(__listeners[connection.intervalID][intName]);
		}
	}
	
	
}