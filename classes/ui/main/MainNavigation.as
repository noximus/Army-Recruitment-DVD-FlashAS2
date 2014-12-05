import mx.utils.Delegate;
import mx.events.EventDispatcher;
import mx.transitions.Tween;
import mx.transitions.easing.Regular;
import mx.transitions.easing.None;
import flash.filters.BlurFilter;
import util.xml.XMLSA;
class ui.main.MainNavigation extends MovieClip {
	
	//possible values: home, subsection, interface
	private var navstate:String = "home";
	private var bf:BlurFilter;
	private var _blur:Number=0;
	private var mc:MovieClip;
	private var settings:Settings;
	private var stripe:MovieClip;
	
	//sensitivity to mouse movement.
	private var sensitivity:Number = .15;
	private var iterations:Number=0;
	//percentage distance to move the trailer every frame
	private var elasticity:Number = .15; 
	
	private var position:Object;
	private var moving:Boolean=true;
	private var _tweenTime:Number=20;
	private var _focusTime:Number=7;
	public var mc_trailer:MovieClip;
	private var tween:Object;
	public var lines:MovieClip;
	public var homeBtn:MovieClip;
	public var nav:MovieClip;
	public var mc_navigation:MovieClip;
	public var mainImgSlide:MovieClip;
	
	function MainNavigation() {
		init();
	}
	private function init():Void {
		
		//make it stop spinning for performance issues.
		nav.stop();
		mc_navigation._visible=false;
		
		homeBtn._alpha=0;
		mc=this;
		settings = new Settings();
		settings.mainNav=this;
		stripe = this._parent.stripe;
		tween = new Object();
		position = new Object();
		position.initial={x:this._x, y:this._y};
		position.subsection={x:this._x+40, y:this._y-40};
		position.Interface={x:this._x+375, y:this._y-245};
		
		mc_trailer = this.createEmptyMovieClip("mc_trailer", this.getNextHighestDepth());
		this.onEnterFrame = Delegate.create(this, Enterframe);
		
		EventDispatcher.initialize(this);
	}
	private function Enterframe():Void {
		iterations++;
		//if(iterations%2==0){
			if (navstate == "home" || navstate == "subsection" && moving==false) {
				
				//responds to mouse movement.
				var dx = this._xmouse-mc_trailer._x;
				var dy = this._ymouse-mc_trailer._y;
		
				
				var mX=dx*elasticity;
				var mY=dy*elasticity;
				mc_trailer._x+=mX;
				mc_trailer._y+=mY;
				var adjx;
				var adjy;
				
				if (navstate == "home") {
					//home
					adjx = (mX*sensitivity)-(this.mc_trailer._x*sensitivity)
					adjy = (mY*sensitivity)-(this.mc_trailer._y*sensitivity);
					//sensitivity=.2;
					this._x=position.initial.x+adjx;
					this._y=position.initial.y+adjy;
					
				} else {
					//subsection
					//sensitivity=.05
					adjx = (mX*sensitivity)-(this.mc_trailer._x*sensitivity);
					adjy = (mY*sensitivity)-(this.mc_trailer._y*sensitivity);
					this._x=position.subsection.x+adjx;
					this._y=position.subsection.y+adjy;
				}
			}else{
				//trace("moving:" + moving + " navstate:" + navstate);
			}
		//}
	}
	public function InSubsection():Void{
		//called when we're done moving and we're in the subsection state
		mc_trailer._x=this._xmouse;
		mc_trailer._y=this._ymouse;
		moving=false;
		//sensitivity=.05;
		
		navstate="subsection";
		
		//make this clickable to go back.
		homeBtn.onPress=Delegate.create(this,BacktoHome);
		homeBtn.onRollOver=Delegate.create(this,RollOver);
		homeBtn.onRollOut=Delegate.create(this,RollOut);
		tween.sensitivity.stop();
		tween.sensitivity=new Tween(this,"sensitivity",None.easeNone,0,.05,20,false);
		this.onEnterFrame=Delegate.create(this,Enterframe);
	}

	private function RollOver():Void{
		if(navstate=="subsection"){
			tween.blur = new Tween(this,"blur",Regular.easeInOut,blur,0,focusTime,false);			
			tween.alpha = new Tween(this,"_alpha",None.easeNone,this._alpha,80,2,false);
		}

		settings.mainSubnav.Blur();
	}
	public function RollOut():Void{
		settings.sound.Play("sound.over");
		if(navstate=="subsection"){
			tween.blur = new Tween(this,"blur",Regular.easeInOut,blur,6,10,false);
			tween.alpha = new Tween(this,"_alpha",None.easeNone,this._alpha,40,focusTime/2,false);
		}
		settings.mainSubnav.Unblur();
	}
	public function BacktoHome():Void{
		moving=true;
		delete(homeBtn.onPress);
		delete(homeBtn.onRollOver);
		delete(homeBtn.onRollOut);
		
		homeBtn._alpha=0;
		
		tween.blur = new Tween(this,"blur",Regular.easeInOut,blur,0,tweenTime,false);
		tween.alpha = new Tween(this,"_alpha",None.easeNone,this._alpha,100,tweenTime,false);
		tween.scale = new Tween(this,"scale",Regular.easeInOut, scale,100,tweenTime,false);
		tween.x = new Tween(this,"_x",Regular.easeInOut, this._x, position.initial.x,tweenTime,false);
		tween.y = new Tween(this,"_y",Regular.easeInOut, this._y, position.initial.y,tweenTime,false);
		tween.y.onMotionFinished=function(){
			this.obj.BringBackSensitivity();
		}
		navstate="home";
		gotoAndPlay("in");
		settings.mainSubnav.BacktoHome();
		Characters("Show");
	}
	private function BringBackSensitivity():Void{
		this.onEnterFrame = Delegate.create(this, Enterframe);
		//trace("bring it back");
		moving=false;
		mc_trailer._x=this._xmouse;
		mc_trailer._y=this._ymouse;
		tween.sensitivity.stop();
		tween.sensitivity=new Tween(this,"sensitivity",None.easeNone,0,.2,60,false);
	}
	function subSection(sectionName:String,sectionID:String) {
		
		//called when we click on a Character.
		settings.sounds.Play("sound.select");
		
		moving=true;
		
		navstate="subsection";
		//super.slideTo("150", "-200", .8, "easeInOutQuad");
		//super.scaleTo(70, "easeInOutQuad");
		tween.blur = new Tween(this,"blur",Regular.easeInOut,blur,6,tweenTime,false);
		tween.alpha = new Tween(this,"_alpha",None.easeNone,this._alpha,40,tweenTime,false);
		tween.scale = new Tween(this,"scale",Regular.easeInOut, 100,80,tweenTime,false);
		tween.x = new Tween(this,"_x",Regular.easeInOut, this._x, position.subsection.x,tweenTime,false);
		tween.y = new Tween(this,"_y",Regular.easeInOut, this._y, position.subsection.y,tweenTime,false);
		tween.y.onMotionFinished=Delegate.create(this,InSubsection);
			//this.obj.moving=false;
			//trace("moving:" + this.obj.moving);
			//this.obj.InSubsection();
		//}
		settings.mainSubnav.In(sectionID);
		
		//super.armyStrong.alphaTo(0);
		//this.gotoAndStop('home');
		//this.gotoAndPlay("out");
	}
	function intro() {
		super.alphaTo(100);
		super.scaleTo(100);
		_parent.gotoAndStop('main');
	}
	function openNav() {
		if (this._name == "homeBtn") {
			super.slideTo("-150", "200", .8, "easeInOutQuad");
			super.scaleTo(100, "easeInOutQuad");
			super.armyStrong.alphaTo(100);
			//this.gotoAndStop('main');
			this.gotoAndPlay("main");
		}
	}
	public function ToInterface(menuXML:XMLSA):Void{
		//called when we have selected a submenuitem and we're going to become the interface in the upper right
		delete(this.onEnterFrame); 
		delete(homeBtn.onPress);
		delete(homeBtn.onRollOver);
		delete(homeBtn.onRollOut);
		navstate="interface";
		
		settings.mainSubnav.ToInterface();
		stripe.Out();
		moving=true;
		//100,-140
		tween.x = new Tween(this,"_x",Regular.easeInOut, this._x, position.Interface.x,tweenTime*1.5,false);
		tween.y = new Tween(this,"_y",Regular.easeInOut, this._y, position.Interface.y,tweenTime*1.5,false);
		tween.scale = new Tween(this,"scale",Regular.easeInOut, scale, 50,tweenTime*1.5,false);
		tween.alpha = new Tween(this,"_alpha",Regular.easeInOut,this._alpha,100,tweenTime*1.5,false);
		tween.alpha.onMotionFinished=Delegate.create(this,InInterface);
		
	}
	private function InInterface():Void{
		//we're rested in the upper right.
		tween.home = new Tween(homeBtn,"_alpha",None.easeNone,homeBtn._alpha,100,5,false);
		homeBtn.onPress=Delegate.create(this,BackToSubsection);
		homeBtn.onRollOver=Delegate.create(this,RollOver);
		homeBtn.onRollOut=Delegate.create(this,RollOut);
		tween.mainImg = new Tween(mainImgSlide,"_alpha",None.easeNone,100,0,5,false);
		settings.nav.In();
		Characters("Hide");
		//tween.lines = new Tween(lines,"_alpha",None.easeNone,100,0,3,false);
	}
	private function BackToSubsection():Void{
		stripe.In();
		settings.nav.Out();
		settings.section.Empty();
		trace("section:" + settings.section);
		settings.sounds.Play("sound.select");
		//just clicked on 'home' from when we're in the upper right corner in the interface.
		moving=true;
		tween.mainImg = new Tween(mainImgSlide,"_alpha",None.easeNone,0,100,5,false);
		tween.x = new Tween(this,"_x",Regular.easeInOut, this._x, position.subsection.x,tweenTime*1.5,false);
		tween.y = new Tween(this,"_y",Regular.easeInOut, this._y, position.subsection.y,tweenTime*1.5,false);
		tween.scale = new Tween(this,"scale",Regular.easeInOut, scale, 80,tweenTime*1.5,false);
		tween.alpha = new Tween(this,"_alpha",Regular.easeInOut,this._alpha,40,tweenTime*1.5,false);
		tween.alpha.onMotionFinished=Delegate.create(this,InSubsection);
		//tween.lines = new Tween(lines,"_alpha",None.easeNone,0,100,8,false);
		settings.mainSubnav.BackToSubsection();
	}
	public function Characters(functionName:String):Void{
		broadcast({type:"character",functionName:functionName});
	}
	public function dispatchEvent():Void{}
	public function addEventListener():Void{}
	public function removeEventListener():Void{}
	public function broadcast(broadcastObj:Object):Void{
		dispatchEvent(broadcastObj);
	}	
	public function get scale():Number{
		return this._xscale;
	}
	public function set scale(val:Number):Void{
		this._xscale=val;
		this._yscale=val;
	}
	public function get tweenTime():Number{
		return _tweenTime;
	}
	public function set tweenTime(val:Number):Void{
		_tweenTime=val;
	}
	public function get blur():Number{
		return _blur;
	}
	public function get focusTime():Number{
		return _focusTime;
	}
	public function set focusTime(val:Number):Void{
		_focusTime=val;
	}
	public function set blur(val:Number):Void{
		_blur=val;
		//bf = new BlurFilter(_blur,_blur,1);
		//mc.filters=[bf];
	}
}
