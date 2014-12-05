import ui.AnimateClip;
import mx.utils.Delegate;
import util.xml.XMLSA;
import ui.TextClip;
import com.mrmnydev.transition.easing.Linear;
import util.text.Style;
import com.mrmnydev.util.IntervalManager;


/**
 * @author Chris.Edwards
 */
class ui.widget.values.ValueScroller extends AnimateClip {
	
	private var _current:Number;
	private var _total:Number;
	private var _values:Array;
	private var _mc_up:MovieClip;
	
	private static var _TEXT_X:Number = 32;
	private static var _TEXT_Y:Number = 1;
	
	function ValueScroller() {
		super();
		
		
	}
	private function init():Void{
		super.init();
		
		var content:XMLSA = new Settings().ref.GetNode("armyvalues");
		
		
		this._values = new Array();
		this._current= 0;
		this._total = content.armyvalue.length;
		
		var initObj={_alpha:0,_x:ValueScroller._TEXT_X,_y:ValueScroller._TEXT_Y};
		for(var i:Number = 0;i<this._total;i++){
			
			
			
			var text:String=content.armyvalue[i].title.getValue();
			var textClip:TextClip = TextClip(this.attachMovie("TextClip","textClip"+i,this.getNextHighestDepth(),initObj));
			textClip.tf_text.multiline=false;
			textClip.tf_text.autoSize = "left";
			
			Style.apply(textClip.tf_text,text,"title");
			
			
			this._values.push(textClip);
		}
		
		
		
		this._mc_up.onPress= Delegate.create(this,this.nextValue);
		
		
		
		this.changeValue(0);
		
		IntervalManager.setInterval(this,"intIncrement",this,"nextValue",5000);
		
	}
	
	private function nextValue():Void{
		IntervalManager.clearInterval(this,"intIncrement");
		if(this._current+1<this._total) this.changeValue(this._current+1);
		else this.changeValue(0);
	
		IntervalManager.setInterval(this,"intIncrement",this,"nextValue",5000);
	};
	
	public function changeValue(select:Number):Void{
		
		this._current = select;
		for(var i:Number=0;i<this._total;i++){
			var clip:AnimateClip = this._values[i];
			if(i != select && clip._alpha != 0){
				clip.animateAlpha(0,Linear.easeNone,4,null,null);
				//clip.onRelease = null;
				delete (clip.onPress);
			}else if(i==select){
				clip.animateAlpha(100,Linear.easeNone,12,null,null);
				clip.onRelease = function():Void{
					this._parent._parent.mc_valueExplorer.open(select);
				};
			}	
		}
		
	}

}