package ;

class Statics
{
	public static var lastTime:Float = 0;
	public static var letters:Array<String> = [
		"a", "b", "c", "d", "e"
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
		Game.data.log.push(str);
	}

	public static function getChar(echo:Bool=true):String {
		var result = Sys.getChar(echo);
		return String.fromCharCode(result);
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

	public static function menu(
			title:String,
			options:Array<String>
			):String {
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

		return options[result-1];
	}
}
