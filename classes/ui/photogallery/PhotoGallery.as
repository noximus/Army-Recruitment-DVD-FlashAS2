import mx.utils.Delegate;
import util.xml.XMLSA;
import com.senocular.ColorFader;
import mx.transitions.Tween;
import mx.transitions.easing.None;
import mx.transitions.easing.Strong;
import mx.transitions.easing.Regular;

class ui.photogallery.PhotoGallery extends MovieClip{
	
	private var settings:Settings;
	private var mc:MovieClip;
	private var prevSelected:MovieClip=null;
	private var xml:XMLSA;
	private var currImage:Number=0;
	
	public var mc_images:MovieClip;
	public var mc_thumbs:MovieClip;
	public var tf_title:TextField;
	private var colorTweens:Object;
	
	function PhotoGallery(){
		init();
	}
	private function init():Void{
		mc=this;
		settings = new Settings();
		colorTweens = new Object();
		xml = settings.ref.GetNode("active/sections/benefits/photos");
		
		var img:XMLSA;
		var imgclip:MovieClip;
		
		for(var i=0;i<xml.img.length;i++){
			var img = xml.img[i];
			
			imgclip = mc_images.attachMovie("Template_benefits.mc_photo.Image","img_"+i,i);
			imgclip.mc_img.loadMovie(img.attributes.src);
			imgclip._alpha=0;
			

			var thumb=mc_thumbs.attachMovie("thumb","thumb_"+i,i);
			thumb.xml=img;
			thumb.i=i;
			thumb._x=(thumb._width+6)*i;
			if(i!=0){
				//imgclip._alpha=0;
			}
			
		}
		
		mc_thumbs["thumb_0"].Select();
		
		//colorTweens.saturation = new Tween(target_mc,"saturation",Strong.easeOut,4,1,110,false);
		
	}
	public function LoadImage(i:Number):Void{
		var target_mc:MovieClip=mc_images["img_"+i];
		trace("load:" + target_mc);
		//colorTweens.saturation = new Tween(mc_images,"saturation",Strong.easeOut,4,1,110,false);
		if(prevSelected!=null){
			prevSelected.FadeOut();
		}
		prevSelected=target_mc;

		target_mc.FadeIn();
	}
	
	
}