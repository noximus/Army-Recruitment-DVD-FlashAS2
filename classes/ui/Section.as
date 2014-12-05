import mx.transitions.easing.Regular;
import mx.transitions.easing.None;
import mx.transitions.Tween;
import util.xml.XMLSA;
import mx.utils.Delegate;
import Settings;
import type.XString;
import util.text.Style;

//section
class ui.Section extends MovieClip{
	
	private var _xmlsa;
	private var settings:Settings;
	private var mc:MovieClip;
	private var visited:Boolean=false;
	private static var sectionselected:MovieClip;
	private var _mc_content:MovieClip;
	private var i:Number;
	private var tween:Object;
	private var yInit:Number;
	private var _contentDisplayed:Boolean=false;
	
	function Section(){
		
		yInit=this._y;
		mc=this;
		settings = new Settings();
		settings.ref.addEventListener('section', Delegate.create(this, broadcastHandler));
		settings.section=this;
		//trace("section:" + this);
		
		//hackery
		_global.styles.TextArea.backgroundColor = undefined;
		_global.styles.TextArea.setStyle("borderStyle","none");
	}
	//private function broadcastHandler(){}
	private function init():Void{
		
		//dont think we're using this anymore ...
		//settings.sections[xmlsa.attributes.clip] = mc;
		//kill the alpha ... bring it up after we're done ... after FillComponents() is done.
		
		contentDisplayed=true;
		
		this._alpha=0;
		//load the content movieclip
		mc_content = mc.attachMovie(xmlsa.attributes.clip,"mc_content",0);
		
		//trace("mccontent:" + mc_content + " clip:" + xmlsa.attributes.clip);
		
		if(xmlsa.xml){
			mc_content.xml = xmlsa.xml;
		}
	}
	public function broadcastHandler(){
		
	}
	/*
	public function Refresh():Void{
		
	}*/
	
	private function FillTextfields():Void{
		//called at the end of FillComponents();
		//trace("FILL TEXT FIELDS");
		for(var i=0;i<xmlsa.fields.textfield.length;i++){
			
			trace(i);
			
			var textfield = xmlsa.fields.textfield[i];
			
			var textValue:XString = new XString(settings.ref.GetString(textfield.attributes.text));
			textValue = textValue.replace("\n","");
			textValue = textValue.replace("\t","");
			//textValue = XString('<font face="Arial" size="10">') + textValue + XString('</font>');
			//trace(textValue);
			//asfunction:_root.sup.Goto,
			/*
			
			when we find <a href="id:[sectionname]">click here</a> within
			an html textfield, replace that ... so that it goes to the right
			section in the site.
			
			in html, this would go to a different aspx page.
			
			*/
			textValue = textValue.replace("href=\"id:","href=\"asfunction:_root.sup.Goto,");
			
			/*
			
			find the textfield
			in the xml, a textfield can be denoted as:
				"mc_clip.tf_clip"
			so split it by the dots "." and 
			then find the field
			
			*/
			var pathStr:String = String(textfield.attributes.name);
			var paths = pathStr.split(".");
			var path = mc_content;
			for(var j=0;j<paths.length;j++){
				path = path[paths[j]];
			}
			
			
			if(path.type!="dynamic"){
				//this is a textarea; use the text property;
				//trace("path:"+path);
				path.text='<font size="11.5">' + textValue + "</font>";
				path.selectable = false;
			}
			else{
				//this is a dynamic textfield; use the htmlText property

				path.htmlText=textValue;
				
				//Style.apply(path,textValue); // chris, this line is killing some text ... interstateboldcompressed fonts don't work.
				//path.htmlText=textValue;

				//Style.apply(path,textValue);
			}
			
			//get rid of the borders and focus rectangle
			path.setStyle("borderStyle","none");
			path.setStyle("selectable",false);
			path.drawFocus = false;
			
			
		}
	}
	public function In():Void{
		this._visible=true;
		tween.alpha = new Tween(this,"_alpha",None.easeNone,0,100,8,false);
		tween.y = new Tween(this,"_y",Regular.easeOut,yInit+8,yInit,8,false);
		contentDisplayed=true;
		
	}
	public function Out():Void{

		tween.alpha.stop();
		tween.alpha = new Tween(this, "_alpha",None.easeNone,100,0,8,false);
		tween.y.stop();
		tween.y = new Tween(this,"_y",Regular.easeOut,yInit,yInit+8,8,false);
		//trace("out!!!!");
		if(contentDisplayed==true){
			tween.alpha.onMotionFinished=function(){
				var settings = new Settings();
				this.obj.Empty();
				settings.ref.DoneFadingOut();
			};
		}
		

		
	}
	public function Empty():Void{
		//trace("empty!");
		contentDisplayed=false;
		//load an empty clip into mc_content;
		mc_content = mc.attachMovie("empty","mc_content",0);
		this._visible=false;
	}
	public function FillComponents():Void{
		//trace("FillComponenets");
		/*
			for some reason or another dropdowns cannot
			befilled fromthe init() function because the
			combobox clips havent loaded yet. ... so this
			called from the first frame of the
			mc_content clip
		*/
		
		//deal with clips
		for(var i=0;i<xmlsa.clips.clip.length;i++){
			var clip = xmlsa.clips.clip[i];
			
			//pointer to the clipname
			var tmp:String= String(clip.attributes.name);
			
			//we can have a <clip node point to many instances by
			//separating them with commas
			//ie: name="mc_dropdown1;mc_dropdown2";
			var clips:Array = tmp.split(";");
			for(var k=0;k<clips.length;k++){
				
				var pathStr:String = String(clips[k]);
				var paths = pathStr.split(".");
				var path = mc_content;
				for(var j=0;j<paths.length;j++){
					path = path[paths[j]];
				}
				
				var dd:MovieClip = path;
				
				//attach xml to the clip if the <clip node has an <xml child node
				if(clip.xml){
					dd.xml = clip.xml;
				}

				
				/*
					component-specific properties, data applied below
				*/
				if(clip.attributes.type=="Loader"){
					dd.scaleContent = false;
					dd.contentPath=clip.attributes.contentPath;
					
				}
				else if(clip.attributes.type=="YellowLink"){
					
					dd.xml=clip;
					
				}
				else if(clip.attributes.type=="Button"){
					
					dd.eventObject = new Object();
					dd.eventObject.functionName = clip.attributes.functionName;
					dd.eventObject.target = clip.attributes.target;
					
					//dd.obj = new Object();
					//dd.obj.foo=clip.attributes.functionName;
					dd.onPress=function(){
						var settings = new Settings();
						var target = settings[this.eventObject.target];
						var funct = target[this.eventObject.functionName];
						funct.call(target);
						
					};
				}
				else if(clip.attributes.type=="ComboBox"){
					
					//styles
					var o = _global.styles.ComboBox = new mx.styles.CSSStyleDeclaration();
					o.textSelectedColor = "0x000000";
					o.selectionColor = "0xFFFCD1";
					
					
					if(clip.data){
						for(var j=0;j<clip.data.option.length;j++){
							var option = clip.data.option[j];
							dd.addItem({data:option.attributes.value, label:settings.ref.GetString(option.getValue())});
						}
						//add a listener
						var listenerObj:Object = new Object();
						listenerObj.id = i;
						listenerObj.xml = clip;
						listenerObj.change=function(evt_obj:Object){
													
							//broadcast the value out to the scrollpane
							var settings = new Settings();
							settings.ref.broadcast(this.xml.attributes.target,
												   this.xml.attributes.functionName, 
												   		{
														param:evt_obj.target.param,
														index:evt_obj.target.selectedIndex,
														dropdown:evt_obj.target,
														value:evt_obj.target.selectedItem.data,
														label:evt_obj.target.selectedItem.label
														});
						};
						dd.param = clip.attributes.param;
						dd.addEventListener("change",listenerObj);
					}
				}
				else if(clip.attributes.type=="ScrollPane"){
					/*
					
					if we pass the contentPath in the <clip node, use that
					as our contentpath. otherwise, use the empty library clip.
					
					*/
					if(clip.attributes.contentPath){
						dd.contentPath = clip.attributes.contentPath;
					}
					else{
						dd.contentPath="empty";
					}
					dd.drawFocus = false;
					dd.vScrollPolicy="auto";
					dd.hScrollPolicy="off";

					
					//apply background colour to the scrollpane if we have that attribute.
					if(clip.attributes.backgroundColor){
						dd.setStyle("backgroundColor",clip.attributes.backgroundColor);
					}
					else{
						//dd.setStyle("backgroundColor","0xFFFFFF");
					}
					if(clip.attributes.borderStyle){
						dd.setStyle("borderStyle",clip.attributes.borderStyle);
					}
				}else if(clip.attributes.type =="CareerMatrix"){
					//
					//clip.get
				//	trace("*****what is this");
			
					dd.init(clip.attributes.xmlPath,clip.attributes.thumbPath);
					//
					
				}
			}
		}
		//attach xml
		if(xmlsa.xml){
			//trace("attach xml:" + xmlsa.xml);
			mc_content.xml=xmlsa.xml;
		}
		
		FillTextfields();
		
		//bring it up
		In();
	}
	public function broadcast(obj:Object){
		//trace("broadcast:" + obj.target);
		var settings = new Settings();
		settings.ref.broadcast(obj.target,obj.functionName,obj.params);
	}
	public function get xmlsa():XMLSA{
		return _xmlsa;
	}
	public function set xmlsa(val:XMLSA):Void{
		_xmlsa = val;
		init();
	}
	public function get mc_content():MovieClip{
		return _mc_content;
	}
	public function set mc_content(val:MovieClip):Void{
		_mc_content = val;
	}
	public function get contentDisplayed():Boolean{
		return _contentDisplayed;
	}
	public function set contentDisplayed(val:Boolean):Void{
		_contentDisplayed=val;
	}
}