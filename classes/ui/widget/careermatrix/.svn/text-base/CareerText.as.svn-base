import ui.TextClip;
import ui.AnimateClip;
import mx.controls.TextArea;
import flash.filters.DropShadowFilter;
import util.text.Style;
import com.mrmnydev.transition.easing.Linear;
//import mx.controls.UIScrollBar;

/**
 * @author Chris.Edwards
 */
class ui.widget.careermatrix.CareerText extends AnimateClip {
	
	public var tf_text_hidden,tf_title:TextField;
	public var tf_text:TextArea;
	public var outlink:MovieClip;
	//private var _tcCopy:TextClip;
	
	private var _shadow:DropShadowFilter;
	private var _bg:AnimateClip;
	
	
	private var _foot:Number;
	
	function CareerText() {
		super();
	}
	
	private function init():Void{
		super.init();
		this._shadow = new DropShadowFilter(3,90,0x000000,100,10,10);
		this._bg.filters=[this._shadow];
		this._visible = false;
		this._alpha = 0;
	
		//tf_text.autoSize="left";
		
		this._foot = this._y+this._height;
		
		
		//hackery
		tf_text.setStyle("color",0xFFFFFF);
		tf_text.setStyle("fontFamily","InterstateRegular");
		tf_text.setStyle("borderStyle","none");
		tf_text.embedFonts=true;
		tf_text.border_mc._visible=false;
	}
	
	private function adjustY():Void{
		
		this._bg._height = tf_text._height+50;
		this.outlink._y=this._bg._height-this.outlink._height;
		var diff:Number = this._foot - (this._height+this._y);
		this._y+=diff;
	}
	
	public function show():Void{
		this._visible = true;
		this.animateAlpha(100,Linear.easeNone,12,null,null);
	}
	public function hide():Void{
		this._alpha = 0;
		this._visible = false;
		
	}
	
	public function applyText(title:String,copy:String):Void{
		
		//hackery
		
		//Style.apply(this.tf_text,title,"title");
		//Style.append(this.tf_text,"<br><br>");
		//Style.append(this.tf_text,copy,"copy");
		//Style.apply(this.tf_text_hidden,copy,"copy");
		tf_text_hidden._visible=false;
		//tf_text.text=tf_text_hidden.text;
		tf_text.text=copy;
		trace("text:" + tf_text.text);
		tf_title.text=title;
		//Style.apply(this.tf_title,title,"title");
		
		
		//this.adjustY();
		
		
	}
}