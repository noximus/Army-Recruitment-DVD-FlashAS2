﻿import mx.events.EventDispatcher;import mx.utils.Delegate;import mx.transitions.Tween;import mx.transitions.easing.None;import mx.styles.CSSStyleDeclaration;import util.xml.XMLSA;import util.eric.Extensions;import type.XString;import util.text.Style;class ArmyDVD extends EventDispatcher{		private var _section=0;	private var settings:Settings;	private var rootXML, stringsXML, contentXML:XMLSA;	private var extensions:Extensions;	private var mc:MovieClip;	private var lang:String="en";	private var ptr:XMLSA;	private var xmlToLoad:String;	private var tween:Object;	private var sounds:Sounds;		public var mc_navigation:MovieClip;		function ArmyDVD(_mc,cssPath:String){				mc=_mc;				//hide the navigation		//mc.mc_navigation._visible=false;				sounds = new Sounds(mc);				//this is a class that has as a static property a StyleSheet		//when it loads it calls this.init		Style.onLoad = Delegate.create(this,this.init);		Style.loadCSS(cssPath);		fscommand("fullscreen",true);		fscommand("allowscale",false);	}	private function init(bCssLoaded:Boolean):Void{				//mc = _mc;				extensions = new Extensions();				//mc_navigation=mc.mc_navigation;				initialize(this);				settings = new Settings();		settings.ref = this;								rootXML = new XMLSA();		rootXML.ignorewhite = true;		rootXML.onLoad = function(bSuccess:Boolean){			//this is the root logic xml file			//after this, load the strings file			var settings = new Settings();			settings.ref.LoadLang();			trace("loaded root: "+bSuccess);		};		stringsXML = new XMLSA();		stringsXML.ignorewhite = true;		stringsXML.onLoad = function(bSuccess:Boolean){			//this is the strings xml file			//settings.ref.CompletedLoadingXML();			//after this, load home			var settings = new Settings();			settings.ref.Home();						trace("loaded strings: "+bSuccess);		};		contentXML = new XMLSA();		contentXML.ignorewhite = true;		contentXML.onLoad = function(bSuccess:Boolean){			//this is an individual section's logic xml			var settings = new Settings();			settings.ref.ParseContentXML();			//trace("loaded content");			trace("loaded content: "+bSuccess);		};		rootXML.load("xml/root.xml");					}	public function CompletedLoadingXML():Void{			}	public function GetMenuXML($sectionID:String):XMLSA{		trace("get section id;" + $sectionID);		var paths = $sectionID.split("/");				ptr = new XMLSA(new XML(rootXML.toString()));				for(var i=0;i<paths.length;i++){			ptr = new XMLSA(new XML(ptr[paths[i]].toString()));			if(ptr==undefined){				trace("error:" + paths[i] + " ptr:" + ptr.toString());			}		}		return ptr;	}			public function GetNode($path:String):XMLSA{				var paths = $path.split("/");				ptr = new XMLSA(new XML(stringsXML.toString()));				for(var i=0;i<paths.length;i++){			ptr = new XMLSA(new XML(ptr[paths[i]].toString()));			if(ptr==undefined){				trace("error:" + paths[i] + " ptr:" + ptr.toString());			}		}		return ptr;			}	public function LoadSection($xml:String):Void{		trace("loadsection:"+$xml);		//fade out the old		if(settings.section.contentDisplayed==false){			trace("not displayed");			LoadContentXML($xml);		}else{			trace("out:" + settings.section);			settings.section.Out();						xmlToLoad=$xml;		}			}	public function DoneFadingOut():Void{		//called from Section.as when we're done fading out.		LoadContentXML(xmlToLoad);			}		public function GetString(str:String):String{		/*		gets a string from the language file		alternatively, if there is no match found		just returns the string				attributes:			str:    looks like string:xpath					for example: string:menuitems/menuitem1/name				*/		if(str.indexOf("string:")==0){									var objs:Array = str.split(":")[1];			ptr = new XMLSA(new XML(stringsXML.toString()));						var paths = objs.split("/");						for(var i=0;i<paths.length;i++){				ptr = new XMLSA(new XML(ptr[paths[i]].toString()));				if(ptr==undefined){					trace("error:" + paths[i] + " ptr:" + ptr.toString());				}			}			var ptrString:XString = new XString(ptr.getValue());			ptrString = ptrString.replace(" - "," — ");			ptrString = ptrString.replace("&#174;","®");			return ptrString.toString();					}		else{			return str;		}	}		public function Goto(sectionName:String){		//trace("goto:" + sectionName);		//broadcast("item","Goto",{id:sectionName});	}	public function Home():Void{				//loads the first section		//LoadContentXML(rootXML.home.getValue());				//attach xml to the nav		//mc_navigation.xml=rootXML.navigation;			}	public function LoadContentXML(xml:String):Void{		//requests a content (logic) xml file for a section.		contentXML.load(xml);	}		public function LoadLang():Void{				//loads the appropriate langauge file				if(settings.lang==""){			//the lang was not passed in flashvars			//just use the first <lang in the <langs> node			//trace("load:" + sxml.langs);						var langs:XMLSA = new XMLSA(new XML(rootXML.langs.toString()));			stringsXML.load(rootXML.langs.lang.getValue());		}	}			public function ParseContentXML():Void{		//trace("parse content xml:" + contentXML);			mc.mc_content.xmlsa = contentXML;	}		private function ParseRootXML():Void{				//this parses the root.xml file.				//load the home		LoadContentXML(rootXML.home.getValue());			}		/*	public function broadcast(target, functionName, paramsObject):Void{		dispatchEvent({target:target, functionName:functionName, params:paramsObject});	}*/		}