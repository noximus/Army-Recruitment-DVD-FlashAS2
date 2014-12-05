import util.xml.XMLSA;
import ui.nav.Navigation;
import ui.main.MainNavigation;
import ui.nav.NavigationItem;
import ui.main.Subnav;
import ui.Section;
import ui.Camostripe;
import ui.locator.Locator;
dynamic class Settings{	

	private static var _community;
	public function get community(){
		return _community;
	}
	public function set community(val):Void{
		_community=val;
	}

	private static var _locator:Locator;
	public function get locator():Locator{
		return _locator;
	}
	public function set locator(val:Locator):Void{
		_locator=val;
	}
	private static var _sounds:Sounds;
	public function get sounds():Sounds{
		return _sounds;
	}
	public function set sounds(val:Sounds):Void{
		_sounds=val;
	}

	private static var _mainCamostripe:Camostripe;
	public function get mainCamostripe():Camostripe{
		return _mainCamostripe;
	}
	public function set mainCamostripe(val:Camostripe):Void{
		_mainCamostripe=val;
	}

	//globe
	private static var _globe:Globe;
	public function get globe():Globe{
		return _globe;
	}
	public function set globe(val:Globe):Void{
		_globe=val;
	}
	private static var _section:MovieClip;
	public function get section():MovieClip{
		//return _section;
		//dirty hack
		return _level0.mc_content;
	}
	public function set section(val:MovieClip):Void{
		_section=val;
	}

	//the main nav
	private static var _mainNav:MainNavigation;
	private static var _mainSubnav:Subnav;

	//the main class
	private static var _ref:ArmyDVD;
	
	//the nav
	private static var _nav:Navigation;
	
	//the language we're choosing. 'en' ...
	//if it's blank this just picks the first
	private static var _lang:String="";
	
	//the id of the section we're in
	//active, rotc, reserve
	private static var _sectionID:String="active";
	
	public function toString():String{
		return "[object Settings]";
	}
	
	public function get mainNav():MainNavigation{
		return _mainNav;
	}
	public function set mainNav(val:MainNavigation):Void{
		_mainNav=val;
	}
	public function get mainSubnav():Subnav{
		return _mainSubnav;
	}
	public function set mainSubnav(val:Subnav):Void{
		_mainSubnav=val;
	}
	public function get nav():Navigation{
		return _nav;
	}
	public function set nav(val:Navigation):Void{
		_nav=val;
	}
	
	public function get sectionID():String{
		return _sectionID;
	}
	public function set sectionID(val:String):Void{
		_sectionID=val;
	}
	public function get ref():ArmyDVD{
		return _ref;
	}
	public function set ref(val:ArmyDVD):Void{
		_ref=val;
	}
	public function get lang():String{
		return _lang;
	}
	public function set lang(val:String):Void{
		_lang = val;
	}
}