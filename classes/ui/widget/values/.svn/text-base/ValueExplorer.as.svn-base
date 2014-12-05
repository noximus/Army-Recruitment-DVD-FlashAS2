import util.xml.XMLSA;
import ui.widget.values.Value;
import util.text.Style;
import com.mrmnydev.transition.easing.Circ;
import mx.utils.Delegate;
import com.mrmnydev.transition.easing.Quad;
import com.senocular.ColorFader;
/**
 * @author Chris.Edwards
 */
class ui.widget.values.ValueExplorer extends ui.AnimateClip {
	
	private var cf:ColorFader;
	
	private var _availableHeight:Number = 508;
	private var _values:Array;
	
	private var _closePos:Object;
	private var _openPos:Object;
	
	private var _mc_close:MovieClip;
	private var _bg:MovieClip;
	
	private var yellow:Number=0xFFCC00;
	private var white:Number=0xFFFFFF;
	
	var tf_title:TextField;
	
	//CONSTRUCTOR
	function ValueExplorer() {
		super();
	}
	//DESTRUCTOR

	//__________________________________
	
	
	private function init():Void{
		super.init();
		
	//this._openPos = {_x:342,_y:-2};
		//this._closePos={_x:342,_y:Stage.height};
		
		this._openPos = {_x:342,_y:-2};
		this._closePos={_x:Stage.width,_y:-2};
		
		this._x = this._closePos._x;
		this._y = this._closePos._y;
		//hack to disable any mouse events on clip below
		this._bg.useHandCursor = false;
		this._bg.onPress = function():Void{};
		cf = new ColorFader(_mc_close);
		//
		//
		var content:XMLSA = new Settings().ref.GetNode("armyvalues");
		this._values = new Array();
		
		
		
		for (var i:Number = 0;i<content.armyvalue.length;i++){
			//create value
			var title:String = content.armyvalue[i].title.getValue();
			var description:String = content.armyvalue[i].copy.getValue();
			this._values.push(this.createValue(i,title,description));
		}
		
		this._visible = false;
		
		this.spaceValues();
		
		
	}
	
	private function createValue(id:Number,title:String,description:String):Value{
		var pos:Object = {_x:this.tf_title._x,_y:tf_title._y+tf_title._height};
		var value:Value = Value(this.attachMovie("mc_value","value"+id,this.getNextHighestDepth(),pos));
		Style.apply(value.tf_text,title+"<br>","valueTitle");
		
		Style.append(value.tf_text,description,"valueCopy");
		return value;
	}
	
	private function spaceValues():Void{
		var totalHeight:Number = 0;
		
		for(var i:Number = 0;i<this._values.length;i++){
			var value:Value = Value(this._values[i]);
			totalHeight+=value._height;
		}
		
		var margin:Number = (this._availableHeight-totalHeight)/this._values.length-3;
		
		var yPos:Number = this.tf_title._y+this.tf_title._height+margin;
		
		for(i = 0;i<this._values.length;i++){
			var value:Value = Value(this._values[i]);
			value._y = yPos;
			yPos+=value._height+margin;
		}	
	}
	
	
	public function open(selected:Number):Void{
		//selected is passed from the ValueScroller
		//there's nothing going on with it for now
	
		this._visible = true;
		//this._openPos.blurY = 0;
		this.animate(this._openPos,Quad.easeOut,9,null,null);
		//this.animateX(this._openPos._x,Circ.easeIn,14,null,null);
		//this.animateY(this._openPos._y,Circ.easeOut,22,null,null);
		trace(this._openPos._x);
		this._mc_close.onPress = Delegate.create(this,this.close);
		this._mc_close.onRollOver = Delegate.create(this,RollOver);
		this._mc_close.onRollOut = Delegate.create(this,RollOut);
	}
	private function RollOver():Void{
		cf.fadeTo(white,20)
	}
	private function RollOut():Void{
		cf.fadeTo(yellow,140);
	}
	
	public function close():Void{
		cf.fadeTo(yellow,200);
		//this._closePos.blurY = 0;
		this.animate(this._closePos,Quad.easeIn,6,null,null);
		//this.animateX(this._closePos._x,Circ.easeIn,22,null,null);
		//this.animateY(this._closePos._y,Circ.easeOut,22,null,null);
		this._mc_close.onRelease = null;
		delete this._mc_close.onPress;
		delete(this._mc_close.onRollOver);
		delete(this._mc_close.onRollOut);
	}
	
	
	

	
	
}