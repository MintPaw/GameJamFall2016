package ;

class Statics
{
	public static var lastTime:Float = 0;
	public static var letters:Array<String> = [
		"a", "b", "c", "d", "e", "f", "g", "h", "i",
		"j", "k", "l", "m", "n", "o", "p", "q", "r",
		"s", "t", "u", "v", "w", "x", "y", "z"
	];

	public static function init():Void {
		getTime();
	}

	public static function print(str:String):Void {
		Sys.print(str);
	}

	public static function println(str:String):Void {
		print(str+"\n");
	}

	public static function clear():Void {
		Sys.command("clear");
	}

	public static function log(str:String):Void {
		Game.data.log.push("Day "+Game.data.day+" "+getTimeString()+" - "+str);
	}

	public static function getChar(echo:Bool=true):String {
		var result = Sys.getChar(echo);
		return String.fromCharCode(result);
	}

	public static function getString():String {
		return Sys.stdin().readLine();
	}

	public static function pause(echo:Bool=true):Void {
		println("Press any key to continue...");
		getChar(false);
	}

	public static function exit():Void {
		println("Goodbye.");
		Sys.exit(0);
	}

	public static function getTime():Float {
		return Timer.stamp();
	}

	public static function pollElapsed():Float {
		var passed:Float = getTime() - lastTime;
		lastTime = getTime();
		return passed;
	}

	public static function menu(title:String, options:Array<String>):String {
		println(title+":");
		for (i in 0...options.length) {
			if (i < 9) println((i+1)+". "+options[i]);
			else println(letters[i-9]+". "+options[i]);
		}

		var result:Int = -1;
		while (true) {
			print("Choice (1-"+options.length+"): ");
			var character = getChar();
			print("\n");

			if (Std.parseInt(character) != null)
				result = Std.parseInt(character);
			else
				for (i in 0...letters.length)
					if (letters[i] == character)
						result = i+10;

			if (result-1 >= options.length || result == -1) {
				println("Out of range");
				continue;
			}
			break;
		}

		print("\n");
		return options[result-1];
	}

  public static function pickOne(array:Array<Dynamic>, exclude:Array<Dynamic>=null):Dynamic {
    if (array.length == 0) return -1;
    if (exclude == null) exclude = [];
    var result:Dynamic = null;
    while (result == null || exclude.indexOf(result) != -1) result = array[Math.floor(Math.random()*array.length)];
    return result;
  }

		public static function clamp(num:Float, min:Float, max:Float):Float {
			return Math.min(Math.max(min, num), max);
		}

		public static function sleep(time:Int):Void {
			Sys.sleep(time/1000);
		}

		public static function getTimeString():String {
			var hr:Int = Game.data.hour % 24;
			var hrStr:String;

			var min:Int = Math.round(Game.data.seconds/10*60);
			var minStr:String = Std.string(min);

			var ampm:String = "";

			if (hr <= 12) {
				hrStr = Std.string(hr);
				ampm = "am";
			} else {
				hrStr = Std.string(hr-12);
				ampm = "pm";
			}

			if (minStr.length < 2) minStr = "0"+minStr;
			if (hrStr.length < 2) hrStr = "0"+hrStr;

			var timeStr:String = "";
			timeStr = hrStr+":"+minStr+ampm;

			return timeStr;
		}

}
