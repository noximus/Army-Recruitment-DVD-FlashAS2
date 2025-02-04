<<<<<<< .mine﻿import mx.utils.Delegate;import mx.transitions.Tween;import mx.transitions.easing.Regular;class ui.Place extends MovieClip{		private var mc:MovieClip;	private var tween:Object;	private var settings:Settings;	private var radius:Number=250;	private var position:Object;	private var r:Number;	private var distanceFromCamera:Number=0;	private var mc_info:MovieClip;	private function init(_latitude:Number,_longitude:Number):Void{		mc=this;		settings = new Settings();						tween = new Object();				//----take out when turning off text fields		//mc_info._alpha=100;		//-----take out end				position = new Object();		position.latitude=_latitude;		position.longitude=_longitude;		if(position.longitude<0){			position.longitude+=360;		}		mc_info._visible=false;								// _y is a function of latitude		this._y=radius*Math.sin(degToRad(_latitude));				//radius is the distance from _x=0 and is a function of latitude		r=radius*Math.cos(degToRad(_latitude));				//mc.onRollOver=Delegate.create(this,_rollover);		//mc.onRollOut=Delegate.create(this,_rollout);		//trace("over:" + mc.onRollOver);				mc.onEnterFrame=Delegate.create(this,EnterFrame);		mc.onRollOver=Delegate.create(this,rollover);		mc.onRollOut=Delegate.create(this,rollout);		mc.onReleaseOutside=Delegate.create(this,releaseout);			}	private function EnterFrame():Void{				/*				aligns points based on the theta of the globe				*/						var theta = this.settings.globe.theta;		if(theta<0){			theta+=360;		}				this._x=this.r*Math.sin(this.degToRad(this.settings.globe.theta+this.position.longitude));		var diff = Math.abs(theta+this.position.longitude)%360;		/*				only show the point if it is theta-90 to theta +90		... so if it's >270 and <90				*/		if(diff<90 || diff>270){			this._visible=true;			if(diff>270){				diff=360-diff;			}			this._alpha=-10*diff+900;			this.scale=(100*(this.r/this.radius))*Math.cos(this.degToRad(diff*.82));		}		else{			this._visible=false;		}	}	private function rollover():Void{		//do stuff here		mc_info._visible=true;		tween.alpha = new Tween(mc_info,"_alpha",Regular.easeOut,mc_info._alpha,100,5,false);	}	private function rollout():Void{		//do stuff here		tween.alpha = new Tween(mc_info,"_alpha",Regular.easeOut,mc_info._alpha,0,10,false);		tween.alpha.onMotionFinished=function(){			this.obj._visible=false;		}	}	private function releaseout():Void{		//do stuff here		tween.alpha = new Tween(mc_info,"_alpha",Regular.easeOut,mc_info._alpha,0,10,false);		tween.alpha.onMotionFinished=function(){			this.obj._visible=false;		}	}	public function get scale():Number{		return this._xscale;	}	public function set scale(val:Number):Void{		this._xscale=val;		this._yscale=val;		mc_info._xscale=100/val*100;		mc_info._yscale=100/val*100;	}	private function degToRad(degrees:Number):Number{		//convert degrees to radians		return degrees/180*Math.PI;	}	public function Position(_latitude:Number,_longitude:Number):Void{		//called after the Point is attached via attachMovie		init(_latitude,_longitude);	}	=======﻿import mx.utils.Delegate;
import mx.transitions.Tween;
import mx.transitions.easing.Regular;


class ui.Place extends MovieClip{
	
	private var mc:MovieClip;
	private var tween:Object;
	private var settings:Settings;
	private var radius:Number=250;
	private var position:Object;
	private var r:Number;
	private var distanceFromCamera:Number=0;
	private var mc_info:MovieClip;
	
	
	private var _yPos:Number;// = -2*cos(theta)

	private function init(_latitude:Number,_longitude:Number):Void{
		mc=this;
		settings = new Settings();
		
		
		tween = new Object();
		
		//----take out when turning off text fields
		//mc_info._alpha=100;
		//-----take out end
		
		position = new Object();
		position.latitude=_latitude;
		position.longitude=_longitude;
		if(position.longitude<0){
			position.longitude+=360;
		}
		mc_info._visible=false;
		
		
		//this._yPos = this._y;
		
		// _y is a function of latitude
		this._yPos=this._y=radius*Math.sin(degToRad(_latitude));
		
		//radius is the distance from _x=0 and is a function of latitude
		r=radius*Math.cos(degToRad(_latitude));
		
		//mc.onRollOver=Delegate.create(this,_rollover);
		//mc.onRollOut=Delegate.create(this,_rollout);
		//trace("over:" + mc.onRollOver);

		
		mc.onEnterFrame=Delegate.create(this,EnterFrame);
		mc.onRollOver=Delegate.create(this,rollover);
		mc.onRollOut=Delegate.create(this,rollout);
		
	}
	private function EnterFrame():Void{
		
		/*
		
		aligns points based on the theta of the globe
		
		*/
		
		
		var theta = this.settings.globe.theta;
		if(theta<0){
			theta+=360;
		}
		//this._y=this._yPos+2*Math.cos(theta);
		this._x=this.r*Math.sin(this.degToRad(this.settings.globe.theta+this.position.longitude));

		var diff = Math.abs(theta+this.position.longitude)%360;
		/*
		
		only show the point if it is theta-90 to theta +90
		... so if it's >270 and <90
		
		*/
		if(diff<90 || diff>270){
			this._visible=true;
			if(diff>270){
				diff=360-diff;
			}
			this._alpha=-10*diff+900;
			this.scale=(100*(this.r/this.radius))*Math.cos(this.degToRad(diff*.82));
		}
		else{
			this._visible=false;
		}
	}
	private function rollover():Void{
		//do stuff here
		mc_info._visible=true;
		tween.alpha = new Tween(mc_info,"_alpha",Regular.easeOut,mc_info._alpha,100,5,false);
	}
	private function rollout():Void{

		//do stuff here
		tween.alpha = new Tween(mc_info,"_alpha",Regular.easeOut,mc_info._alpha,0,10,false);
		tween.alpha.onMotionFinished=function(){
			this.obj._visible=false;
		};
	}	
	public function get scale():Number{
		return this._xscale;
	}
	public function set scale(val:Number):Void{
		this._xscale=val;
		this._yscale=val;
		mc_info._xscale=(100/val)*100;
		mc_info._yscale=(100/val)*100;
	}
	private function degToRad(degrees:Number):Number{
		//convert degrees to radians
		return degrees/180*Math.PI;
	}
	public function Position(_latitude:Number,_longitude:Number):Void{
		//called after the Point is attached via attachMovie
		init(_latitude,_longitude);
	}


	
>>>>>>> .r251}