import com.mrmnydev.transition.easing.Linear;
import flash.filters.DropShadowFilter;
import mx.events.EventDispatcher;
import mx.utils.Delegate;
import util.text.Style;
/**
 * @author Chris.Edwards
 */
class ui.locator.ZipField extends ui.AnimateClip{
	
	private var _tf_input:TextField;
	private  var _tf_error:TextField;

	public var _mc_submit:MovieClip;
	private var _mc_clear:MovieClip;
	
	public var addEventListener:Function;
	public var removeEventListener:Function;
	private var dispatchEvent:Function;
	
	private var _settings:Settings;
	private var _data:Number;
	
	
	
	function ZipField(){
		super();
	}
	private function init():Void{
		super.init();
		EventDispatcher.initialize(this);
		
		
		this._mc_clear._visible=false;
		this._tf_input.type="input";
		this._tf_input.restrict = "0-9";
		this._tf_input.maxChars = 5;
		this._tf_input.text="Enter Zip Code";
		this._settings = new Settings();
		
		this._tf_input.onSetFocus=function():Void{
			this.text="";
			delete this.onSetFocus;
		};
		
		//this.filters=[new DropShadowFilter(5,45,0,50)];
		
		this.enable();
		
		
	}	
	

	
	private function clearAll():Void{
		
		_mc_clear._visible=false;
		_mc_clear._alpha=70;
		_tf_input.text="";
		this.dispatchEvent({type:"onFieldClear"});
	
	}
	
	//onKeyDown is a method of the Key class
	function onKeyDown():Void{
		// is it the enter key?
		if(Key.getCode()==Key.ENTER) this.submit();
	}
	
	private function submit():Void{
		var zip:Number = Number(_tf_input.text);
		if(zip>9999){
			_tf_error.htmlText = "";
			this._mc_clear._visible=true;
			this._data = zip;
			this.dispatchEvent({type:"onSubmit",data:zip});
		} else {
			this.onError({message:"Please enter a valid US Zip Code of at least 5 digits."});	
		}
	}
	
	
	public function onError(evtObj:Object):Void{
		if(evtObj.message){
			//trace(evtObj.message);
			_tf_error.htmlText = evtObj.message;
			//this.clearAll();
			//Style.apply(this._tf_error,evtObj.message,"copy");	
		}	
	}
	
	public function enable():Void{
		
		_mc_clear._visible = true;
		
		this._mc_submit.onPress = Delegate.create(this,submit);
		this._mc_clear.onPress=Delegate.create(this,this.clearAll);
		
		this._mc_clear._alpha=70;
		
		this._mc_clear.onRollOver=function(){
			this._alpha=100;
		};
		this._mc_clear.onRollOut=function(){
			this._alpha=70;
		};
		
		
		//onKeyDown is a method of the Key class
		Key.addListener(this);
		
	}

	public function disable():Void{
		trace("is this ever called? ZipField.disable");
		delete this._mc_clear.onRollOut;
		delete this._mc_clear.onRollOver;
		delete this._mc_clear.onPress;
	
		delete this._mc_submit.onPress;
		
		Key.removeListener(this);
	}
	
	public function get data():Number{return this._data;};
}