import mx.utils.Delegate;
import mx.transitions.Tween;
import mx.transitions.easing.Regular;
class ui.main.Character extends MovieClip {
	private var settings:Settings;
	private var xInit:Number;
	public var tf_name:TextField;
	private var tween:Object;
	function Character(){
		init();		
	}
	private function init():Void{
		tween = new Object();
		xInit=tf_name._x;
		settings = new Settings();
		settings.mainNav.addEventListener("character",Delegate.create(this,broadcastHandler));
		this.onPress=Delegate.create(this,Press);
		this.onRollOver = Delegate.create(this,RollOver);
		this.onRollOut = Delegate.create(this,RollOut);
		
		tf_name._alpha=0;
		if(this._name=="armyBtn"){
			//active army
			tf_name.text=settings.ref.GetString("string:main/rollovers/active");
		}else if(this._name=="rotcBtn"){
			//rotc
			tf_name.text=settings.ref.GetString("string:main/rollovers/rotc");
		}else{
			//reserve
			tf_name.text=settings.ref.GetString("string:main/rollovers/reserve");
		}
		
	}
	private function broadcastHandler(eventObject:Object):Void{
		var func = this[eventObject.functionName];
		func.call(this,eventObject.params);
	}
	private function Hide():Void{
		this._visible=false;
	}
	private function Show():Void{
		this._visible=true;
	}
	private function Press():Void{
		

		
		var sectionID:String;
		if (this._name == "armyBtn") {
			sectionID="active";
			_parent._parent.subSection = "army";
		} else if (this._name == "rotcBtn") {
			_parent._parent.subSection = "rotc";
			sectionID="rotc";
		} else if (this._name == "reservesBtn") {
			sectionID="reserve";
			_parent._parent.subSection = "reserves";
		}
		//_parent._parent.gotoAndPlay("outNav");
		_parent.gotoAndPlay("out");
		
		
		
		
		
		var settings = new Settings();
		settings.sectionID=sectionID;
		settings.mainNav.subSection(this._name,sectionID);
		trace("call render:" + settings.nav);
		settings.nav.Render();
		
		delete(this.onPress);
		delete(this.onRollOver);
		delete(this.onRollOut);
		
	}
	
	/*
	function onPress() {
		//this._parent.subSection();
		
		if (this._name == "armyBtn") {
			_parent.subSection = "army";
		} else if (this._name == "rotcBtn") {
			_parent.subSection = "rotc";
		} else if (this._name == "reservesBtn") {
			_parent.subSection = "reserves";
		}
		_parent.gotoAndPlay("outNav");
	}
	*/
	function RollOver() {
		settings.sounds.Play("sound.over");
				

		
		tween.alpha = new Tween(tf_name,"_alpha",Regular.easeOut,tf_name._alpha,100,5,false);
		tween.x = new Tween(tf_name,"_x",Regular.easeOut,tf_name._x+5,xInit,5,false);
		
		this.gotoAndStop(2);
		/*
		if (this._name == "armyBtn") {
			//this._parent.mainNavMC.mainImgSlide.alphaTo(0);
			this._parent.mainNavMC.imgSlide.slideTo(-86, "0", 2);
			this._parent.mainNavMC.mainImgSlide.alphaTo(0);
		} else if (this._name == "rotcBtn") {
			//this._parent.mainNavMC.mainImgSlide.alphaTo(0);
			this._parent.mainNavMC.imgSlide.slideTo(-251, "0", 2);
			this._parent.mainNavMC.mainImgSlide.alphaTo(0);
		} else if (this._name == "reservesBtn") {
			this._parent.mainNavMC.imgSlide.slideTo(-412, "0", 2);
			this._parent.mainNavMC.mainImgSlide.alphaTo(0);
		}
		*/
	}
	function RollOut() {
		
		tween.alpha = new Tween(tf_name,"_alpha",Regular.easeIn,tf_name._alpha,0,5,false);
		tween.x = new Tween(tf_name,"_x",Regular.easeIn,tf_name._x,xInit+5,5,false);
		
		this.play();
		//this._parent.mainNavMC.mainImgSlide.alphaTo(100);
	}
	function EnterFrame(){
		
	}
	/*
	function onEnterFrame() {
		if (this.hitTest(_root._xmouse, _root._ymouse, true)) {
			this.gotoAndStop(this._totalframes);
			//this.nextFrame();
		} else {
			this.prevFrame();
			if (this._name == "armyBtn") {
				this._parent.navImgArmy.prevFrame();
			} else if (this._name == "rotcBtn") {
				this._parent.navImgRotc.prevFrame();
			} else if (this._name == "reservesBtn") {
				this._parent.navImgReserves.prevFrame();
			}
		}
	}
	*/
}
