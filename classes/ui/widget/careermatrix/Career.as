import ui.widget.careermatrix.CareerThumb;
/**
 * @author CHris.Edwards
 */
class ui.widget.careermatrix.Career {
	
	private var _thumb:CareerThumb;
	private var _imgUrl:String;
	private var _title:String;
	private var _copy:String;
	
	private var _id:Number;
	private var _posId:Number;
	
	
	private var _categories:Array;
	
	function Career(id:Number,thumb:CareerThumb,imgUrl:String,title:String,copy:String){
		
		this.init(id,thumb,imgUrl,title,copy);

	};
	
	private function init(id:Number,thumb:CareerThumb,imgUrl:String,title:String,copy:String):Void{
		
		this._categories = new Array();
		this._title = title;
		this._id = id;
		this._posId = id;
		this._thumb = thumb;
		this._thumb.career = this;
		this._imgUrl = imgUrl;		
		this._copy = copy;
	}
	
	public function addCategory(catId:Number):Boolean{
		
		if(this.hasCategory(catId)) return false;
		this._categories.push(catId);
		return true;	
	
	}
	
	public function hasCategory(catId:Number):Boolean{
		
		for(var i:Number = 0;i<this._categories.length;i++){
			if (this._categories[i] == catId) return true;
		}
		return false;
		
	}
	
	
	public function get posId():Number{return this._posId;};
	public function set posId(n:Number){this._posId = n;};
	
	
	//READ ONLY
	public function get title():String{return this._title;};
	public function get copy():String{return this._copy;};
	public function get id():Number{return this._id;};
	public function get thumb():CareerThumb{return this._thumb;};
	public function get url():String{return this._imgUrl;};
}