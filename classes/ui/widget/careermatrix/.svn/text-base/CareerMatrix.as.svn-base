import ui.AnimateClip;
import util.xml.XMLSA;
import mx.utils.Delegate;
import ui.widget.careermatrix.CareerThumb;
import ui.widget.careermatrix.Career;
import com.mrmnydev.transition.easing.Cubic;
import mx.controls.ComboBox;
import ui.widget.careermatrix.ThumbTitle;
import com.mrmnydev.util.IntervalManager;
import com.mrmnydev.transition.easing.Quad;
import ui.widget.careermatrix.CareerText;
import ui.widget.dropdown.DropDownClip;
import com.senocular.ColorFader;

/**
 * @author CHris.Edwards
 */
class ui.widget.careermatrix.CareerMatrix extends AnimateClip {
	//
	
	private var _imgPath:String;
	private var cf_reset:ColorFader;
	//
	private static var _THUMB_MARGIN:Number = 8;
	private static var _COLUMN_COUNT:Number= 10;
	
	
	private var _xmlsa:XMLSA;
	
	private var _thumbTitle:ThumbTitle;
	private var _thumbHolder:AnimateClip;
	private var _reset_mc:MovieClip;
	//private var _cbCareers:ComboBox;
	private var _ddCategories:DropDownClip;
	private var _careerText:CareerText;
	
	private var yellow:Number=0xFFCC00;
	private var white:Number=0xFFFFFF;
	
	private var _positions:Array;
	private var _careers:Array;
	//private var _categories:Array;
	
	private var _visibleThumbs:Array;
	private var _invisibleThumbs:Array;
	
	function CareerMatrix() {
		super();
	
	}
	
	public function init(xmlPath,imgPath):Void{
		trace("********is this even called");
		if(xmlPath){
			
			super.init();
			
			cf_reset=new ColorFader(_reset_mc);
			cf_reset.fadeTo(white,1);
			
			this._careers = new Array();
			//this._categories = new Array();
			this._positions = new Array();
			
			this._visibleThumbs = new Array();
			this._invisibleThumbs = new Array();
			
			this._imgPath = imgPath;
			
			this._xmlsa = new XMLSA();
			this._xmlsa.onLoad = Delegate.create(this,this.processXML);
			this._xmlsa.load(xmlPath);
			//
			this._thumbHolder = AnimateClip(this.attachMovie("AnimateClip","_thumbs",this.getNextHighestDepth()));
			this._thumbHolder._y = 30;
			this._thumbHolder.cacheAsBitmap = true;
			this._thumbTitle.swapDepths(this.getNextHighestDepth());
			this._ddCategories.swapDepths(this.getNextHighestDepth());
			
			this._reset_mc._visible = false;
			
		}
	}
	
	private function processXML():Void{
		
		//this._cbCareers.addItem({label:"See All Categories",data:null});
	
		
		for(var i:Number=0;i<this._xmlsa.categories.category.length;i++){
			
			var label:String=this._xmlsa.categories.category[i].attributes.title;
			var data:Number = Number(this._xmlsa.categories.category[i].attributes.id);
			
			this._ddCategories.addItem(label,data);
			//this._cbCareers.addItem({label:label,data:data});
		}
		
		var column,row,nX,nY:Number;
		var initObj:Object;
		var img,title,copy:String;
		var career:Career;
		var thumb:CareerThumb;
		//trace("thumbHolder:"+this._thumbHolder);
		for(var i:Number=0;i<this._xmlsa.careers.item.length;i++){
			
			column = i%CareerMatrix._COLUMN_COUNT;
			row = Math.floor(i/CareerMatrix._COLUMN_COUNT);
			
			nX=column*(CareerThumb.WIDTH+CareerMatrix._THUMB_MARGIN);;
			nY=row*(CareerThumb.CLOSE_HEIGHT+CareerMatrix._THUMB_MARGIN);;
			
			initObj = {_x:nX,_y:nY};
			thumb = CareerThumb( CareerThumb(this._thumbHolder.attachMovie("CareerThumb","_thumb"+i,this._thumbHolder.getNextHighestDepth(),initObj)) );
			this._positions.push(initObj);
			
			img = this._imgPath+this._xmlsa.careers.item[i].image.getValue();
			//"test_career_thumb.jpg";//
			title = this._xmlsa.careers.item[i].title.getValue();
			copy = this._xmlsa.careers.item[i].copy.getValue();
			career = new Career(i,thumb,img,title,copy);
		
			for(var j:Number = 0;j<this._xmlsa.careers.item[i].categories.category.length;j++){
				career.addCategory(Number(this._xmlsa.careers.item[i].categories.category[j].attributes.id));
			}
			this._careers.push(career);
			
			
			
		}
	
		
		//
		this.show();
		//
	}
	
	
	private function setThumbAnchor():Void{
		
		var nVisible:Number = this._visibleThumbs.length;
		var rowHeight:Number = CareerThumb.CLOSE_HEIGHT+CareerMatrix._THUMB_MARGIN;
		var rows:Number = Math.floor((nVisible-1)/CareerMatrix._COLUMN_COUNT);
		var factor:Number = this._thumbHolder._yscale*.01;
		var padding:Number =CareerThumb.OPEN_HEIGHT-.5*(CareerThumb.OPEN_HEIGHT-CareerThumb.CLOSE_HEIGHT);
		
		this._thumbTitle.anchorX = this._thumbHolder._x;
		this._thumbTitle.anchorY = this._thumbHolder._y+(padding+this._thumbHolder._y+(rows*rowHeight))*factor;
		
		
	}
	
	public function show():Void{
		
		
		
		//this._cbCareers.addEventListener("change",Delegate.create(this,this.onCategoryChange));
		this._ddCategories.addEventListener("onDropDownChange",Delegate.create(this,this.onCategoryChange));
		
		
		for(var i:Number = 0; i<this._careers.length;i++){
			
			this._careers[i].thumb.addEventListener("onThumbOver",this);
			this._careers[i].thumb.addEventListener("onThumbOut",this);
			this._careers[i].thumb.addEventListener("onThumbSelected",this);
			this._careers[i].thumb.load();
			
			
		}
		
		this.onCategoryChange();
	}
	
	public function reset():Void{
	 
		this._reset_mc.onRelease = null;
		delete this._reset_mc.onPress;
		delete(_reset_mc.onRollOut);
		delete(_reset_mc.onRollOver);
		this._reset_mc._visible = false;
		this._thumbTitle.anchored=false;
		
		this._careerText.hide();
		
		
		if(this._thumbHolder.scale!=100){
		
			this._thumbHolder.animate({_x:0,scale:100,_y:30},Cubic.easeInOut,16,Delegate.create(this,this.onCategoryChange),null);
		}else {
			this.onCategoryChange();	
		}
		
	}
	
	public function onCategoryChange(evt:Object):Void{
		
		trace("on category change?");
		
		//var nCareer:Number = this._cbCareers.selectedItem.data;
		var nCareer:Number = evt.data;
		//reset the arrays of visible and invisible thumbs
		this._invisibleThumbs = new Array();
		this._visibleThumbs = new Array();
			
		//if the event objects data value is null then reset thumbs
		if(nCareer==null){
			
			
			for(var i:Number=0;i<this._careers.length;i++){
				this._visibleThumbs[i] = this._careers[i].thumb;	
			}	
			
		} else {
			var thumb:CareerThumb;
			for(var i:Number=0;i<this._careers.length;i++){
					
				thumb = CareerThumb(this._careers[i].thumb);
			
				if(Career(this._careers[i]).hasCategory(nCareer)){
					thumb.disable();
					this._visibleThumbs.push(thumb);				
				}else {
					this._invisibleThumbs.push(thumb);
					thumb.addEventListener("onThumbHidden",this);
					thumb.hide();	
				}
				
			}
		}
		
			
		for(var i:Number = 0;i<this._visibleThumbs.length;i++){
			
			thumb = CareerThumb(this._visibleThumbs[i]);
			
			thumb.career.posId = i;
			thumb.addEventListener("onThumbShown",this);
			thumb.disable();
			thumb.show();
		
		}
		
		this.setThumbAnchor();
		
	}
	
	public function onThumbShown(evtObj:Object):Void{
		
		var thumb:CareerThumb = evtObj.target;
		var career:Career = evtObj.career;
		var enableThumb:Function = Delegate.create(thumb,thumb.enable);
		
		thumb.removeEventListener("onThumbShown",this);
		thumb.animate(this._positions[career.posId],Cubic.easeInOut,12,enableThumb,null);
		
	}
	
	public function onThumbHidden(evtObj:Object):Void{
		var thumb:CareerThumb = evtObj.target;
		var career:Career = evtObj.career;
	
		thumb.removeEventListener("onThumbHidden",this);
	
		thumb._x = this._positions[career.id]._x;
		thumb._x = this._positions[career.id]._x;
	}
	
	public function onThumbOver(evtObj):Void{
		
		IntervalManager.clearInterval(this,"intThumb");
		
		
		var thumb:CareerThumb = evtObj.target;
		var career:Career = evtObj.career;
		this._thumbTitle.swapDepths(this._thumbHolder.getNextHighestDepth());
		this._thumbTitle.text=career.title;	
		this._thumbTitle.destX = thumb._x;
		this._thumbTitle.destY = thumb.indicatorY+this._thumbHolder._y;
		
		this._thumbTitle.show();
		
	}
	
	public function onThumbOut(evtObj:Object):Void{
		IntervalManager.clearInterval(this,"intThumb");
		IntervalManager.setInterval(this,"intThumb",this,"hideThumbTitle",300);
	}
	
	public function onThumbSelected(evtObj):Void{
		var career:Career = evtObj.career;
		var onComplete:Function = Delegate.create(this,this.showSelectedText);
		this._thumbHolder.animate({scale:60,_x:324,_y:0},Cubic.easeInOut,20,null,onComplete);
		this._reset_mc.onRollOver=Delegate.create(this,resetRollover);
		this._reset_mc.onRollOut=Delegate.create(this,resetRollout);
		this._reset_mc.onPress = Delegate.create(this,this.reset);
		this._reset_mc._visible = true;
		this._careerText.applyText(career.title,career.copy);
	}
	
	private function resetRollout():Void{
		cf_reset.fadeTo(white,800);
	}
	private function resetRollover():Void{
		cf_reset.fadeTo(yellow,1);
	}
	
	public function hideThumbTitle():Void{
		IntervalManager.clearInterval(this,"intThumb");
		this._thumbTitle.hide();
	}
	public function showSelectedText():Void{
		this.setThumbAnchor();
		this._thumbTitle.anchor();
		this._careerText.show();
		
		
	}
	
	
	
	
	
}