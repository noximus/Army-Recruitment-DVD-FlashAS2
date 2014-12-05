import ui.AnimateClip;
import flash.filters.DropShadowFilter;
import ui.widget.dropdown.DropDownItemClip;
import mx.events.EventDispatcher;
import mx.utils.Delegate;
import com.mrmnydev.transition.easing.Quad;
import com.mrmnydev.util.IntervalManager;
import util.draw.Rectangle;
import util.text.Style;

/**
 * @author Chris.Edwards
 */
class ui.widget.dropdown.DropDownClip extends AnimateClip {
	
	private var _shadow:DropShadowFilter;
	
	private var _titleBar:MovieClip;
	private var _dropFill:MovieClip;
	private var _dropFooter:MovieClip;
	
	private var _openPercent:Number;
	
	private var _itemMask:MovieClip;
	private var _itemHolder:MovieClip;
	
	private var _itemY:Number;
	
	private var _yPadding:Number;
	
	private var _footer:MovieClip;
	
	private var _maskRect:Rectangle;
	
	//private var _selected:DropDownItemClip;
	
	function DropDownClip() {
		super();
	}
	
	private function init():Void{
		super.init();	
		EventDispatcher.initialize(this);
		
		this._itemY = 10;
		//this._yPadding = 10;
		
		
		
		this._itemHolder = this.createEmptyMovieClip("_itemHolder",this.getNextHighestDepth());
		this._itemMask = this.createEmptyMovieClip("_itemMask",this.getNextHighestDepth());
		
		this._itemHolder._y=this._itemMask._y=this._dropFill._y;
	
		this._maskRect = new Rectangle(this._dropFill._width,0);
		this._itemHolder.setMask(this._itemMask);
		
		this._openPercent = 0;
		this._shadow = new DropShadowFilter(5,45,0x00000,50,5,5);
		this.filters = [this._shadow];
		
		Style.apply(this._titleBar.tf_label,"Click here to see all jobs.","dropDownTitle");
		
		this._titleBar.onRollOver=Delegate.create(this,this.onItemOver);
		this._titleBar.onRollOut=Delegate.create(this,this.onItemOut);
		this._titleBar.onRelease = Delegate.create(this,this.onItemSelected);
		
		this._dropFill.onRelease = function():Void{};
		this._dropFill.useHandCursor = false;
	}
	
	private function dispatchEvent(evtObj:Object):Void{};
	
	public function addEventListener(sType:String,lis:Object){};
	public function removeEventListener(sType:String,lis:Object){};
	
	public function addItem(label:String,data:Number):Void{
		
		
		
		
		var item:DropDownItemClip = DropDownItemClip(
									this._itemHolder.attachMovie(
									"mc_dropdownitem","_item"+data,
									this._itemHolder.getNextHighestDepth(),
									{_y:this._itemY}));
		
		item.label = label;
		item.data = data;
		
		
		
		item.addEventListener("onItemOver",this);
		item.addEventListener("onItemOut",this);
		item.addEventListener("onItemSelected",this);
		
		this.addEventListener("onDropDownClose",item);
		this.addEventListener("onDropDownOpen",item);
		this.addEventListener("onDropDownChange",item);
		
		this._itemY+=item._height;
		this._maskRect.height=this._itemY;
		Rectangle.draw(this._itemMask,this._maskRect,true);
		
		this.setOpenPercent(0);
	}
	
	
	public function open():Void{
	
		IntervalManager.clearInterval(this,"intClose");
		
		this.dispatchEvent({type:"onDropDownOpen"});//,data:this._selected.data});
		this.animate({openPercent:100},Quad.easeOut,12,null,null);
		
	};
	
	
	
	public function close():Void{
		
		IntervalManager.clearInterval(this,"intClose");
		this.dispatchEvent({type:"onDropDownClose"});
		this.animate({openPercent:0},Quad.easeIn,12,null,null);
	};
	
	
	
	public function onItemSelected(evtObj:Object):Void{
		//this._selected = DropDownItemClip(evtObj.target);
		
		this.dispatchEvent({type:"onDropDownChange",data:evtObj.data});
		this.close();
		
	};
	public function onItemOver(evtObj:Object):Void{
		IntervalManager.clearInterval(this,"intClose");
		this.open();
	};
	public function onItemOut(evtObj:Object):Void{
		IntervalManager.setInterval(this,"intClose",this,"close",500);
	};
	
	
	
	public function setOpenPercent(n:Number):Void{
		this._openPercent = n;
		//var rect = new Rectangle(this._maskRect.width,this._maskRect.height*.01*n);
		this._itemMask._height = this._maskRect.height*.01*n;
		this._dropFill._height = this._maskRect.height*.01*n;
		
		this._footer._y = (this._maskRect.height+this._itemHolder._y)*.01*n;
		//
	};
	
	
	public function set openPercent(n:Number):Void{this.setOpenPercent(n);};
	public function get openPercent():Number{return this._openPercent;};	
	



}