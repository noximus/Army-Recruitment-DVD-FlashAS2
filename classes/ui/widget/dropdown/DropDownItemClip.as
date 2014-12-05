import ui.AnimateClip;
import util.text.Style;
import com.mrmnydev.transition.easing.Linear;
import mx.utils.Delegate;
import mx.events.EventDispatcher;

/**
 * @author Chris.Edwards
 */
class ui.widget.dropdown.DropDownItemClip extends AnimateClip {
	
	var tf_label:TextField;
	private var _label:String;
	private var _data:Number;
	
	private var _hot:Boolean;
	
	private var _bg:MovieClip;

	
	

	private var _rollOverPercent : Number;
	
	
	
	function DropDownItemClip() {
		super();
	}
	
	private function init():Void{
		super.init();
		EventDispatcher.initialize(this);
		this.setRollOverPercent(0);
		
		this._hot = false;
	}
	
	private function dispatchEvent(evtObj:Object):Void{};
	public function addEventListener(sType:String,lis:Object){};
	public function removeEventListener(sType:String,lis:Object){};
	
	
	public function enable():Void{
		
		this.onRollOver = Delegate.create(this,this.doRollOver);
		this.onRollOut = Delegate.create(this,this.doRollOut);
		this.onRelease = Delegate.create(this,this.onSelected);	
		
		//this.setRollOverPercent(0);
	}
	public function disable():Void{
		this.onRollOut = null; delete this.onRollOut; 
		this.onRollOver = null;  delete this.onRollOver;	
		this.onRelease = null;  delete this.onRelease;	
	}
	
	//To DropDownClip+++++++++++++++++++++++++++++++++++++++++++++++++
	public function doRollOver():Void{
		if(this.rollOverPercent!=100) this.animate({rollOverPercent:100},Linear.easeNone,8,null,null);
		this.dispatchEvent({type:"onItemOver",data:this._data});
			
	}
	public function doRollOut():Void{
		if(this.rollOverPercent!=0);this.animate({rollOverPercent:0},Linear.easeNone,8,null,null);
		this.dispatchEvent({type:"onItemOut",data:this._data});
	}
	public function onSelected():Void{
		
		this.dispatchEvent({type:"onItemSelected",data:this._data});	
	}
	//++++++++++++++++++++++++++++++++++++++++++++++++++
	
	//from DropDownClip------------------------
	public function onDropDownOpen(evtObj:Object):Void{
		
		//if(evtObj.data!=this.data) this.doRollOut(); 
		if(!this._hot){
			this.enable();
			
		}
		
	}
	public function onDropDownClose(evtObj:Object):Void{
		this.disable();	
		
	}
	public function onDropDownChange(evtObj:Object):Void{
		//
		this._hot = (evtObj.data==this.data);
	//	this.setRollOverPercent(100-Number(this._hot)*100);
		//trace(this._hot);
		if(!this._hot) this.rollOverPercent =0;
		//	
	}
	
	//---------------------------------
	
	public function setRollOverPercent(n:Number):Void{
		
		this._rollOverPercent = n;
		
		this._bg._alpha = .5*n;
	}
	
	public function set rollOverPercent(n:Number):Void{this.setRollOverPercent(n);};
	public function get rollOverPercent():Number{return this._rollOverPercent;};
	
	public function set label(s:String):Void{
		
		Style.apply(this.tf_label,s,"dropDownItem");	
		this._label = s;
		
	}
	public function get data():Number{return this._data;};
	public function set data(n:Number):Void{
		
		this._data = n;	
		
	}

}