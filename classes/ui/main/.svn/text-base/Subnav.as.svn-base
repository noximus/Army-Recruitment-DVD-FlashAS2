import mx.utils.Delegate;
import mx.transitions.Tween;
import mx.transitions.easing.Regular;
import mx.transitions.easing.None;
import mx.events.EventDispatcher;
import flash.filters.BlurFilter;
import util.xml.XMLSA;
class ui.main.Subnav extends MovieClip {

	private var mc:MovieClip;
	private var bf:BlurFilter;
	private var _blur:Number=0;
	private var xml:XMLSA;
	private var _focusTime:Number=10;
	private var iterations:Number=0;
	private var settings:Settings;
	
	//sensitivity to mouse movement.
	private var sensitivity:Number = .15;
	
	//percentage distance to move the trailer every frame
	private var elasticity:Number = .15; 
	
	private var position:Object;
	private var moving:Boolean=true;
	
	public var mc_trailer:MovieClip;
	private var tween:Object;
	
	private var _leftcol,_rightcol:Object;
	
	function Subnav() {
		init();
	}

	private function init():Void {
		
		leftcol={expanded:false,nitems:0};
		rightcol={expanded:false,nitems:0};
		
		
		mc=this;
		EventDispatcher.initialize(this);
		settings = new Settings();
		settings.mainSubnav=this;
		this._alpha=0;
		tween = new Object();
		position = new Object();
		position.initial={x:this._x, y:this._y};
		position.Interface={x:this._x+355, y:this._y-275};
		
		mc_trailer = this.createEmptyMovieClip("mc_trailer", this.getNextHighestDepth());
		this.onEnterFrame = Delegate.create(this, Enterframe);
	}
	//broadcaster stuff ... required.
	public function dispatchEvent():Void{}
	public function addEventListener():Void{}
	public function removeEventListener():Void{}
	public function broadcast(eventObject:Object):Void{
		dispatchEvent(eventObject);
	}
	public function Items(functionName:String,params:Object):Void{
		broadcast({type:"item",functionName:functionName,params:params});
	}
	public function In(sectionID:String):Void{
		
		
		//kill the old items
		Items("Kill");
		/*
		get the menuitems xml, create the items
		*/
		xml = settings.ref.GetMenuXML("menuitems/"+sectionID);
		var items = xml.items;
		var item:XMLSA;
		var menuitem:MovieClip;
		mc["itemsclip"].removeMovieClip();
		var itemsclip:MovieClip = this.createEmptyMovieClip("itemsclip",mc.getNextHighestDepth());
		var xSpace:Number=10;
		var ySpace:Number=38;
		
		leftcol.nitems=0;
		rightcol.nitems=0;
		
		
		for(var i=0;i<items.item.length;i++){
			var item = items.item[i];
			//ui.main.Submenuitem
			menuitem = itemsclip.attachMovie("ui.main.Submenuitem","item_"+i,100-i);
			menuitem.depth=100-i;
			if(i%2==0){
				//col on the left
				leftcol.nitems++;
				menuitem.col=0;
				menuitem._x=(menuitem._width+30)*-1+(i*xSpace);
			}else{
				rightcol.nitems++;
				//col on the right
				menuitem.col=1;
				menuitem._x=(30)+(i*xSpace);
			}
			menuitem.row=Math.floor(i/2);
			menuitem._y=(Math.floor(i/2)*ySpace);
			menuitem.xml=item;
		}
		
		//introducing this item
		tween.alpha = new Tween(this,"_alpha",Regular.easeInOut,0,100,settings.mainNav.tweenTime,false);
		tween.scale = new Tween(this,"scale",Regular.easeInOut,(100/80)*100,100,settings.mainNav.tweenTime,false);
		tween.x = new Tween(this,"_x",Regular.easeInOut,position.initial.x-100,position.initial.x,settings.mainNav.tweenTime,false);
		tween.y = new Tween(this,"_y",Regular.easeInOut,position.initial.y+100,position.initial.y,settings.mainNav.tweenTime,false);
		moving=true;
		tween.x.onMotionFinished=function(){
			this.obj.BringSensitivityUp();
		};
		Items("Start");
	}
	private function Enterframe():Void {
		iterations++;
		//if(iterations%2==0){		
		
			if(moving==false){
				
				
				//responds to mouse movement.
				var dx = this._xmouse-mc_trailer._x;
				var dy = this._ymouse-mc_trailer._y;
		
				
				var mX=dx*elasticity;
				var mY=dy*elasticity;
				mc_trailer._x+=mX;
				mc_trailer._y+=mY;
				
			
				//home
				this._x=position.initial.x-(mX*sensitivity)-(this.mc_trailer._x*sensitivity);
				this._y=position.initial.y-(mY*sensitivity)-(this.mc_trailer._y*sensitivity);
				
				
				//now we have to do the expanding/collapsing stuff.
				//trace(this._xmouse + "," + this._ymouse + " w:" + this._width + " h:" + this._height);
				
				//test for left panel
				
				// && this._ymouse>this._height/2*-1 && this._ymouse<this._height/2
				if(this._xmouse>this._width/2*-1 && this._xmouse<-30 && this._ymouse>0 && this._ymouse<this._height){
					if(leftcol.expanded==false){
						leftcol.expanded=true;
						Items("Expand",{col:0});
					}
				}else{
					if(leftcol.expanded==true){
						Items("Collapse",{col:0});
						leftcol.expanded=false;
					}
				}
				
				
				//test for the right panel
				if(this._xmouse<this._width/2 && this._xmouse>30 && this._ymouse>0 && this._ymouse<this._height){
					if(rightcol.expanded==false){
						Items("Expand",{col:1});
						rightcol.expanded=true;
					}
				}else{
					if(rightcol.expanded==true){
						Items("Collapse",{col:1});
						rightcol.expanded=false;
					}
				}
				
			}
		//}
	}
	public function ToInterface():Void{
		
		if(leftcol.expanded==true){
			leftcol.expanded=false;
			Items("Collapse",{col:0});
		}
		if(rightcol.expanded==true){
			rightcol.expanded=false;
			Items("Collapse",{col:1});
		}
		
		//we've selected an item
		
		//make outlines out of the current items
		//then kill them.
		Items("Outline");
		moving=true;
		tween.alpha = new Tween(this,"_alpha",None.easeNone,100,0,settings.mainNav.tweenTime,false);
		tween.x = new Tween(this,"_x",Regular.easeInOut,this._x,position.Interface.x,settings.mainNav.tweenTime*1.5,false);
		tween.y = new Tween(this,"_y",Regular.easeInOut,this._y,position.Interface.y,settings.mainNav.tweenTime*1.5,false);
		tween.scale = new Tween(this,"scale",Regular.easeInOut,scale,60,settings.mainNav.tweenTime*1.5,false);
		delete(this.onEnterFrame);
	}
	public function BackToSubsection():Void{
		//just clicked on 'home' from when we're in the upper right corner in the interface.
		moving=true;
		tween.x = new Tween(this,"_x",Regular.easeInOut, this._x, position.initial.x, settings.mainNav.tweenTime*1.5,false);
		tween.y = new Tween(this,"_y",Regular.easeInOut, this._y, position.initial.y, settings.mainNav.tweenTime*1.5,false);
		tween.scale = new Tween(this,"scale",Regular.easeInOut, scale, 100,settings.mainNav.tweenTime*1.5,false);
		tween.alpha = new Tween(this,"_alpha",Regular.easeInOut,this._alpha,100,settings.mainNav.tweenTime*1.5,false);
		tween.scale.onMotionFinished=Delegate.create(this,BringSensitivityUp);
			//this.obj.BringSensitivityUp();
			//this.obj.settings.mainNav.BringSensitivityUp();
		//}
		
		Items("Back");
	}
	public function Blur():Void{
		tween.blur = new Tween(this,"blur",Regular.easeInOut,blur,6,10,false);
	}
	public function Unblur():Void{
		tween.blur = new Tween(this,"blur",Regular.easeInOut,blur,0,10,false);
	}
	public function BringSensitivityUp():Void{
		tween.sensitivity=new Tween(this,"sensitivity",None.easeNone,0,.15,60,false);
		moving=false;
		this.onEnterFrame = Delegate.create(this, Enterframe);
	}
	
	public function BacktoHome():Void{
		
		Items("Out");
		moving=true;
		
		//introducing this item
		tween.alpha = new Tween(this,"_alpha",Regular.easeInOut,100,-100,settings.mainNav.tweenTime,false);
		tween.scale = new Tween(this,"scale",Regular.easeInOut,100,(100/80)*100,settings.mainNav.tweenTime,false);
		tween.x = new Tween(this,"_x",Regular.easeInOut,this._x,position.initial.x-100,settings.mainNav.tweenTime,false);
		tween.y = new Tween(this,"_y",Regular.easeInOut,this._y,position.initial.y+100,settings.mainNav.tweenTime,false);
		
	}

	public function get scale():Number{
		return this._xscale;
	}
	public function set scale(val:Number):Void{
		this._xscale=val;
		this._yscale=val;
	}
	public function get blur():Number{
		return _blur;
	}
	public function set blur(val:Number):Void{
		_blur=val;
		//bf = new BlurFilter(_blur,_blur,1);
		//mc.filters=[bf]
	}
	public function get focusTime():Number{
		return _focusTime;
	}
	public function set focusTime(val:Number):Void{
		_focusTime=val;
	}
	public function get leftcol():Object{
		return _leftcol;
	}
	public function set leftcol(val:Object):Void{
		_leftcol=val;
	}
	public function get rightcol():Object{
		return _rightcol;
	}
	public function set rightcol(val:Object):Void{
		_rightcol=val;
	}
}
