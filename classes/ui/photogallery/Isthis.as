//active/sections/life/scroll/items
import mx.utils.Delegate;
import util.xml.XMLSA;
import com.senocular.ColorFader;
import mx.transitions.Tween;
import mx.transitions.easing.None;
import mx.transitions.easing.Strong;
import mx.transitions.easing.Regular;


class ui.photogallery.Isthis extends ui.photogallery.PhotoGallery{
	
	public var mc_images:MovieClip;
	public var mc_thumbs:MovieClip;
	private var perRow:Number=5;
	//spacing between thumbnails
	private var margin:Number=26;
		
	function Isthis(){
		init();
	}
	private function init():Void{
		mc=this;
		settings = new Settings();
		colorTweens = new Object();
		xml = settings.ref.GetNode("active/sections/life/scroll/items");
		
		var img:XMLSA;
		var imgclip:MovieClip;
		

		

		for(var i=0;i<xml.item.length;i++){
			var img = xml.item[i];
			
			imgclip = mc_images.attachMovie("Template_benefits.mc_photo.Image","img_"+i,i);
			imgclip.mc_img.loadMovie(img.img.getValue());
			imgclip._alpha=0;
			

			var thumb=mc_thumbs.attachMovie("Template_life.thumb","thumb_"+i,i);
			thumb.xml=img;
			thumb.i=i;
			//thumb._x=(thumb._width+6)*i;
			thumb._x=(i%perRow)*(thumb._width+margin);
			thumb._y=Math.floor(i/perRow)*(thumb._height+margin);
			if(i!=0){
				//imgclip._alpha=0;
			}
			
		}
		
		mc_thumbs["thumb_0"].Select();
		
		//colorTweens.saturation = new Tween(target_mc,"saturation",Strong.easeOut,4,1,110,false);
		
	}
	
}