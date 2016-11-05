package;

class Main
{
  public static function main() {
    var game:Game = new Game();
  }
}

class Game
{
  public var data:GameData;

  public function new() {
    // Entry point
    clear();
    println("GAME START");
    init();
    data = newGameData();
    pause();

    var p = newPet();
    p.stamina = 20;

    while (true) {
      update();
      drawMainMenu();
    }
  }

  public function update():Void {
    var secondsInHour:Float = 10;

    data.seconds += pollElapsed();
    var hoursPassed:Int = Std.int(data.seconds / secondsInHour);
    data.seconds -= hoursPassed*secondsInHour;
    data.hour += hoursPassed;
  }

  public function drawMainMenu():Void {
    clear();

    var result:String = menu(
      "Main menu",
      ["Pets", "Shop", "Quit"]
    );
    println(result+" was picked");
    println("Time is: "+data.hour+"hrs.");
    println("Realtime seconds: "+data.seconds+"sec.");
    if (result == "Quit") exit();

    pause();
  }

  public function newGameData():GameData {
    var d:GameData = {
      seconds: 0,
      hour: 0,
      pets: []
    };
    return d;
  }

  public function newPet():Pet {
    var pet:Pet = {
      name: "noname",
      maxStamina: 100,
      stamina: 100,
      trust: 0,
      sensitivity: 0,
      ferocity: 0,
      piety: 0,
      rhythm: 0,
    }
    data.pets.push(pet);
    return pet;
  }
}

typedef GameData = {
  seconds:Float,
  hour:Int,
  pets:Array<Pet>
}

typedef Pet = {
  name:String,

  maxStamina:Int,
  stamina:Int,

  trust:Int,
  sensitivity:Int,
  ferocity:Int,
  piety:Int,
  rhythm:Int
}
