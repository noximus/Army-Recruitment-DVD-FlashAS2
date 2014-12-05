import ui.AnimateClip;
import com.mrmnydev.transition.easing.Quad;
import mx.utils.Delegate;

/**
 * @author Chris.Edwards
 */
class ui.widget.nextsteps.NextStepsClip extends AnimateClip {
	
	var closeBtn:MovieClip;
	var tab:MovieClip;
	var openY:Number;
	var closeY:Number;
	
	function NextStepsClip() {
		super();
	}
	
	private function init():Void{
		super.init();
		
		if(!this.openY) this.openY=this._y-this._height;	
		if(!this.closeY) this.closeY=this._y;	
		
		this.tab.onRelease = Delegate.create(this,this.open);
		
		this.closeBtn.onRelease = Delegate.create(this,this.close);
	}
	
	public function open():Void{
		
		this.animate({_y:this.openY},Quad.easeIn,20,null,null);
	}
	public function close():Void{
		
		this.animate({_y:this.closeY},Quad.easeOut,20,null,null);
	}
	
	
	
	
}