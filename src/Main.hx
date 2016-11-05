package;

class Main
{
  public static function main() {
    var game:Game = new Game();
  }
}

class Game
{
  public static var data:GameData;

  public function new() {
    // Entry point
    clear();
    println("GAME START");
    init();
    data = newGameData();
    initJobs();
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
      ["Pets", "Shop", "Jobs", "Quit"]
    );
    println(result+" was picked");
    println("Time is: "+data.hour+"hrs.");
    println("Realtime seconds: "+data.seconds+"sec.");

    if (result == "Jobs") drawJobTable();
    if (result == "Quit") exit();

    pause();
  }

  public function drawJobTable():Void {
    clear();
    
    var nameLen:Int = 0;
    for (j in data.jobs)
      nameLen = Std.int(Math.max(j.name.length, nameLen));

    var lineLen:Int = 0;
    for (job in data.jobs) {
      var line:String = job.name;
      while (line.length < nameLen) line += " ";
      line+=" |";

      for (i in 0...(job.start*4))
	line += " ";
      for (i in 0...((job.end-job.start)*4))
	line += "#";

      println(line);

      lineLen = Std.int(Math.max(line.length, lineLen));
    }

    var timeBar:String = "";
    for (i in 0...nameLen+2) timeBar += " ";
    for (i in 0...24) {
      var hr:Int = i;
      var ext:String = "a ";
      if (hr > 12) {
	hr -= 12;
	ext = "p ";
      }
      var hrString:String = Std.string(hr);
      if (hrString.length == 1) hrString = "0"+hrString;
      timeBar += hrString+ext;
    }

    var bottomBar:String = "";
    for (i in 0...timeBar.length) bottomBar += "-";

    var arrowBar:String = "";
    for (i in 0...nameLen+2) arrowBar += " ";
    for (i in 0...(data.hour*4)) arrowBar += " ";
    arrowBar += "^";

    println(bottomBar);
    println(timeBar);
    println(arrowBar);
  }

  public function newGameData():GameData {
    var d:GameData = {
      seconds: 0,
      hour: 0,
      pets: [],
      jobs: []
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
  pets:Array<Pet>,
  jobs:Array<Job>
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
