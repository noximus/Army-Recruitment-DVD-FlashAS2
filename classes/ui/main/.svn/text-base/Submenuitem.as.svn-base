import flash.filters.BitmapFilter;
import flash.filters.ColorMatrixFilter;
import mx.utils.Delegate;
import util.xml.XMLSA;
import com.senocular.ColorFader;
import mx.transitions.Tween;
import mx.transitions.easing.None;
import mx.transitions.easing.Regular;
class ui.main.Submenuitem extends MovieClip{
	private var settings:Settings;
	private var cf,cf_text:ColorFader;
	private var mc:MovieClip;
	private var _row,_col:Number;
	private var yellow:Number=0xFFCC00;
	private var white:Number=0xffffff;
	public var mc_border:MovieClip;
	private var _xml:XMLSA;
	private var saturation:Number=1;
	private var tf_sectionName:TextField;
	private var tf_sectionName2:TextField;
	public var mc_img:MovieClip;
	private var _depth:Number;
	private var oldDepth:Number;
	private var saturationTween:Tween;
	private var tween:Tween;
	public var mc_hitarea:MovieClip;
	private var expanded:Boolean=false;
	public var mc_starleft,mc_starright:MovieClip;
	private var position:Object;
	private var tweens:Object;
	
	public function Submenuitem(){
		
	}

	private function init():Void{
		mc=this;
		tweens = new Object();
		cf=new ColorFader(mc_border);
		position = {x:this._x, y:this._y};
		cf_text=new ColorFader(tf_sectionName);
		cf_text.fadeTo(white,1);
		cf.fadeTo(white,1);
		settings = new Settings();
		settings.mainSubnav.addEventListener("item",Delegate.create(this,broadcastHandler));
		mc_img.gotoAndStop(xml.id.getValue());
		tf_sectionName.text=xml.title.getValue();
		tf_sectionName2=xml.title.getValue();
		
		Start();
										   
	}
	private function Outline():Void{
		cf.fadeTo(white,1);
		cf_text.fadeTo(white,1);
		tween = new Tween(this,"stuffalpha",None.easeNone,100,0,3,false);
		delete(mc_hitarea.onPress);
		delete(mc_hitarea.onRollOver);
		delete(mc_hitarea.onRollOut);
	}
	private function Expand(params:Object):Void{
		if(params.col==col){
			var colObj:Object;
			if(col==0){
				//leftcol
				colObj=settings.mainSubnav.leftcol;
			}else{
				//rightcol
				colObj=settings.mainSubnav.rightcol;
			}
			var xmove=10;
			var ymove=45;
			
			//trace("colObj:" + colObj.nitems);
			
			if(colObj.nitems==3){
				
				//3 items in the row. top and bottom items go out
				//trace("3 items");
				if(row==0){
					tweens.y.stop();
					tweens.x.stop();
					tweens.y=new Tween(this,"_y",Regular.easeInOut,this._y,position.y-ymove,5,false);
					tweens.x=new Tween(this,"_x",Regular.easeInOut,this._x,position.x-xmove,5,false);
				}
				else if(row==2){
					tweens.y.stop();
					tweens.x.stop();
					tweens.y=new Tween(this,"_y",Regular.easeInOut,this._y,position.y+ymove,5,false);
					tweens.x=new Tween(this,"_x",Regular.easeInOut,this._x,position.x+xmove,5,false);
				}
			}
			else if(colObj.nitems==2){
				
				//two object in the row. both go out half the yMove, half the xMove
				//trace("two items");
				if(row==0){
					tweens.y.stop();
					tweens.x.stop();
					tweens.y=new Tween(this,"_y",Regular.easeInOut,this._y,position.y-ymove/2,5,false);
					tweens.x=new Tween(this,"_x",Regular.easeInOut,this._x,position.x-xmove/2,5,false);
				}
				else if(row==1){
					tweens.y.stop();
					tweens.x.stop();
					tweens.y=new Tween(this,"_y",Regular.easeInOut,this._y,position.y+ymove/2,5,false);
					tweens.x=new Tween(this,"_x",Regular.easeInOut,this._x,position.x+xmove/2,5,false);
				}
				
			}
			
		}
	}
	private function Collapse(params:Object):Void{
		if(params.col==col){
			tweens.y.stop();
			tweens.x.stop();
			tweens.y=new Tween(this,"_y",Regular.easeInOut,this._y,position.y,8,false);
			tweens.x=new Tween(this,"_x",Regular.easeInOut,this._x,position.x,8,false);
		}
	}
	private function Show():Void{
		this._visible=true;
	}
	private function Hide():Void{
		this._visible=false;
	}
	private function Rollover():Void{
		cf.fadeTo(yellow,1);
		settings.sounds.Play("sound.over");
		cf_text.fadeTo(yellow,200);
		settings.mainNav.RollOut();
		//saturate(1,1.2,40);
		//oldDepth=super._depth;
		this.gotoAndPlay("in");
		//this.swapDepths(this._parent.getNextHighestDepth());
	}
	private function Rollout():Void{
		//saturate(saturation,1,300);
		//this.swapDepths(depth);		
		cf.fadeTo(white,300);
		cf_text.fadeTo(white,300);
	}
	private function Back():Void{
		tween = new Tween(this,"stuffalpha",None.easeNone,-100,100,settings.mainNav.tweenTime*.85,false);
		mc_hitarea.onRollOver=Delegate.create(this,Rollover);
		mc_hitarea.onRollOut=Delegate.create(this,Rollout);
		mc_hitarea.onPress=Delegate.create(this,Press);
		Show();
	}
	private function Press():Void{
		settings.sounds.Play("sound.select");
		settings.nav.selectedNavitem=this.xml.id.getValue();
		settings.mainNav.ToInterface(xml);
		
		
	}
	private function Kill():Void{
		settings.mainSubnav.removeEventListener("item",broadcastHandler);
		this.removeMovieClip();
	}
	private function broadcastHandler(eventObject:Object):Void{
		var func = this[eventObject.functionName];
		func.call(this,eventObject.params);
	}
	private function Start():Void{
		this.gotoAndPlay(2);
		cf.fadeTo(white,1);
		cf_text.fadeTo(white,1);
		mc_hitarea.onRollOver=Delegate.create(this,Rollover);
		mc_hitarea.onRollOut=Delegate.create(this,Rollout);
		mc_hitarea.onPress=Delegate.create(this,Press);
	}
	private function saturate(from:Number, to:Number, time:Number){
		saturationTween = new Tween(mc_img, "saturation", None.easeNone, from, to, time, false);
		saturationTween.onMotionChanged = function(){
			var matrix:Array = new Array();
			var target_mc=this.obj;
			matrix = matrix.concat([target_mc.saturation, 0, 0, 0, 0]); // red
			matrix = matrix.concat([0, target_mc.saturation, 0, 0, 0]); // green
			matrix = matrix.concat([0, 0, target_mc.saturation, 0, 0]); // blue
			matrix = matrix.concat([0, 0, 0, 1, 0]); // alpha
			var filter = new ColorMatrixFilter(matrix);
			target_mc.filters = new Array(filter);
		}
	}
	private function Out():Void{
		this.gotoAndPlay("out");
		delete(mc_hitarea.onPress);
		delete(mc_hitarea.onRollOver);
		delete(mc_hitarea.onRollOut);
	}
	public function get xml():XMLSA{
		return _xml;
	}
	public function set xml(val:XMLSA):Void{
		_xml=val;
		init();
	}
	public function get depth():Number{
		return _depth;
	}
	public function set depth(val:Number):Void{
		_depth=val;
	}
	public function get stuffalpha():Number{
		return 1;
	}
	public function set stuffalpha(val:Number):Void{
		mc_img._alpha=val;
		mc_starleft._alpha=val;
		mc_starright._alpha=val;
		tf_sectionName2._alpha=val;
		tf_sectionName._alpha=val;
	}
	public function get row():Number{
		return _row;
	}
	public function set row(val:Number):Void{
		_row=val;
	}
	public function get col():Number{
		return _col;
	}
	public function set col(val:Number):Void{
		_col=val;
	}
	
	
}