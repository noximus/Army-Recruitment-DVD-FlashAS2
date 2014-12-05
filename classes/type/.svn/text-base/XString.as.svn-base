class type.XString extends String{
	function XString(str:String){
		super(str);
	}
	public function replace(oldChar:String, newChar:String):XString{
		var processedText:String = this.toString();
		var subStringPos:Number = 0;
		do {
			subStringPos = processedText.indexOf(oldChar, subStringPos);
			if (subStringPos>-1) {
				processedText = String(processedText.slice(0, subStringPos)+newChar+processedText.slice(subStringPos+oldChar.length));
				subStringPos = subStringPos+(newChar.length+1);
			}
		} while (subStringPos>-1);
		return new XString(processedText);
	}
	
}