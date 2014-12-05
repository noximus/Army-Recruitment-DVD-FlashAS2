//MovieClip
//dynamics
//extensions
dynamic class util.eric.Extensions {
	function Extensions() {
		init();
	}
	private function init():Void {
		//String
		//apparently this doesn't work with mtasc
		String.prototype.replace = function(oldChar, newChar):String  {
			var processedText = this;
			var subStringPos = 0;
			do {
				subStringPos = processedText.indexOf(oldChar, subStringPos);
				if (subStringPos>-1) {
					processedText = String(processedText.slice(0, subStringPos)+newChar+processedText.slice(subStringPos+oldChar.length));
					subStringPos = subStringPos+(newChar.length+1);
				}
			} while (subStringPos>-1);
			return processedText;
		};
		//MovieClip
		MovieClip.prototype.mytrace = function(str, tracetoo) {
			if (tracetoo != false) {
				//trace("\n\n"+str+"\n\n");
			}
			_root.mc_trace._y = (455.9-45);
			_root.mc_trace.tf_trace.text = str;
		};
		MovieClip.prototype.TrimTextfield = function(tf) {
			tf._width = tf.textWidth+5;
			tf._height = tf.textHeight+5;
			if (arguments[1]) {
				//an underline
				var mc_underline = arguments[1];
				mc_underline._width = tf._width-4;
			}
			if (arguments[2]) {
				//a movieclip placed to the right
				var mc_icon = arguments[2];
				mc_icon._x = tf._x+tf._width+2;
			}
		};
		MovieClip.prototype.fadeTextFieldToColor = function(tf, endColor, fadeRate) {
			this.tf = tf;
			this.endColor = endColor;
			this.fadeRate = fadeRate;
			var tf_color = new Object();
			var color_end = new Object();
			color_end.r = endColor >> 16;
			color_end.temp = endColor ^ color_end.r << 16;
			color_end.g = color_end.temp >> 8;
			color_end.b = color_end.temp ^ color_end.g << 8;
			this.onEnterFrame = function() {
				tf_color.hex = this.tf.textColor;
				tf_color.r = tf_color.hex >> 16;
				tf_color.temp = tf_color.hex ^ tf_color.r << 16;
				tf_color.g = tf_color.temp >> 8;
				tf_color.b = tf_color.temp ^ tf_color.g << 8;
				var color_new = new Object();
				//r
				if (Math.abs(tf_color.r-color_end.r)<fadeRate) {
					color_new.r = color_end.r;
				} else {
					if (tf_color.r<color_end.r) {
						color_new.r = tf_color.r+fadeRate;
					} else {
						color_new.r = tf_color.r-fadeRate;
					}
				}
				//g
				if (Math.abs(tf_color.g-color_end.g)<fadeRate) {
					color_new.g = color_end.g;
				} else {
					if (tf_color.g<color_end.g) {
						color_new.g = tf_color.g+fadeRate;
					} else {
						color_new.g = tf_color.g-fadeRate;
					}
				}
				//b
				if (Math.abs(tf_color.b-color_end.b)<fadeRate) {
					color_new.b = color_end.b;
				} else {
					if (tf_color.b<color_end.b) {
						color_new.b = tf_color.b+fadeRate;
					} else {
						color_new.b = tf_color.b-fadeRate;
					}
				}
				(color_new.r<=15) ? color_new.r=String("0"+color_new.r.toString(16)) : color_new.r=String(color_new.r.toString(16));
				(color_new.g<=15) ? color_new.g=String("0"+color_new.g.toString(16)) : color_new.g=String(color_new.g.toString(16));
				(color_new.b<=15) ? color_new.b=String("0"+color_new.b.toString(16)) : color_new.b=String(color_new.b.toString(16));
				var newcolor = String("0x"+color_new.r+color_new.g+color_new.b);
				this.tf.textColor = newcolor;
			};
		};
	}
}
