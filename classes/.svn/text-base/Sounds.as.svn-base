//Sounds.as
import mx.transitions.Tween;
import mx.transitions.easing.None;

class Sounds{
	
	//sound.over ... sound.select
	
	private var mc:MovieClip;
	private var settings:Settings;
	public function Sounds(_mc:MovieClip){
		init(_mc);
	}
	private function init(_mc:MovieClip):Void{
		mc=_mc;
		settings = new Settings();
		settings.sounds=this;
	}
	public function Play($sound:String):Void{
		var soundclip:MovieClip=mc.createEmptyMovieClip("sound_"+mc.getNextHighestDepth(),mc.getNextHighestDepth());
		var sound = new Sound(soundclip);
		sound.attachSound($sound);
		sound.setVolume(50);
		sound.start();
	}
	
}