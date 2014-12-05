/**
 * @author Chris McKenzie
 */


class util.text.Style {
	
	static var CSS:TextField.StyleSheet;
	static var onLoad:Function;
	
	static function loadCSS(url:String):Void {
		if(!CSS) CSS = new TextField.StyleSheet();
		CSS.onLoad = function(ok:Boolean){
			onLoad(ok);
		};
		CSS.load(url);
	
	}
	
	static function setStyle(styleName:String, styleObj:Object):Void {
		if(!CSS) CSS = new TextField.StyleSheet();
		CSS.setStyle(styleName, styleObj);
	}
		
	static function apply(tf:TextField, text:String, style:String):Void {
		setupTextField(tf);
		tf.htmlText=getStyledString(text,style);
	}
	
	static function append(tf:TextField, text:String, style:String):Void {
		setupTextField(tf);
		tf.htmlText+=getStyledString(text,style);
	}
	
	static function setupTextField(tf:TextField):Void {
		tf.html = true;
		tf.embedFonts = true;
		tf.styleSheet = CSS;
		//trace("setting some shit up");
	}
	
	static function getStyledString(text:String, style:String):String {
		if(style){
			return '<span class="'+style+'">'+text+'</span>';
		}else {
			return text;	
		}
		//return '<'+style+'>'+text+'</'+style+'>';//bad
	}
	
	static function toString():String{
		var traceString:String = "";
		for (var i:String in Style.CSS){
			traceString += i +": "+ Style.CSS[i] +"\n";
			for (var u:String in Style.CSS[i]){
				traceString += "  "+u +": "+ Style.CSS[i][u] +"\n";
				for (var o:String in Style.CSS[i][u]){
					traceString += "    "+u +": "+ Style.CSS[i][u][o] +"\n";
				}
			}
		}
		return traceString;
	}
	
	
	
}
