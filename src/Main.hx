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

		obtainConsumable("Energy giver");
		obtainEquipment("Spirit Increaser");
		while (true) {
			clear();
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

		for (i in 0...hoursPassed)
			tick();
	}

	public function tick():Void {
		for (p in data.pets) {
			equipmentTicks(p);
			if (p.job != "None")
				jobTicked(jobByName(p.job), p);
			else
				idlePetTicked(p);
		}
	}

	public function drawMainMenu():Void {
		println("Time is: "+data.hour+"hrs.");
		println("Realtime seconds: "+data.seconds+"sec.");
		println("Log:");
		for (i in data.log.length-10...data.log.length)
			if (data.log[i] != null)
				println(data.log[i]);

		var result:String = menu(
				"Main menu",
				["Pets", "Shop", "Jobs", "Refresh", "Quit"]
				);
		println(result+" was picked");

		if (result == "Pets") {
			clear();
			drawPetsMenu();
		}
		if (result == "Jobs") {
			clear();
			drawJobTable();
			pause();
		}
		if (result == "Quit") exit();
	}

	public function drawJobTable():Void {
		var nameLen:Int = 0;
		for (j in data.jobs)
			nameLen = Std.int(Math.max(j.name.length, nameLen));

		var lineLen:Int = 0;
		for (job in data.jobs) {
			var line:String = job.name;
			while (line.length < nameLen) line += " ";
			line += " |";

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

	public function drawPetsMenu():Void {
		var petNames:Array<String> = [];
		for (p in data.pets) petNames.push(p.name);
		petNames.push("Back");

		var result:String = menu("Pets", petNames);
		if (result != "Back") drawPetMenu(result);
	}

	public function drawPetMenu(petName:String):Void {
		var pet:Pet = petByName(petName);

		clear();
		println("Name: "+pet.name);
		println("Stamina: "+pet.stamina+"/"+pet.maxStamina);
		println("Trust: "+pet.trust);
		println("Sensitivity: "+pet.sensitivity);
		println("Ferocity: "+pet.ferocity);
		println("Spirit: "+pet.spirit);
		println("Rhythm: "+pet.rhythm);
		println("");
		println("Job: "+pet.job);
		println("");

		var petOptions:Array<String> = [];
		petOptions.push("Items");
		if (pet.job == "None") petOptions.push("Send to job") else petOptions.push("Come home");
		petOptions.push("Back");

		var result:String = menu("Pet", petOptions);

		if (result == "Items") drawPetEquipmentMenu(pet);
		if (result == "Send to job") drawPetJobMenu(pet);
		if (result == "Come home") {
			pet.job = "None";
			println("Pet came home.");
			pause();
		}
	}

	public function drawPetJobMenu(pet:Pet):Void {
		drawJobTable();

		var jobNames:Array<String> = [];
		for (job in data.jobs) jobNames.push(job.name);
		jobNames.push("Back");
		var result:String = menu("Which job", jobNames);

		update();

		if (result != "Back") {
			if (isJobReady(result)) {
				pet.job = result;
				println("Pet went to job.");
				pause();
			} else {
				println("Job not currently available.");
				pause();
			}
		}
	}

	public function drawPetEquipmentMenu(p:Pet):Void {
		var slotChoices:Array<String> = [];
		for (i in 0...3) {
			if (p.items[i] == null)
				slotChoices.push("Equip to slot "+(i+1));
			else
				slotChoices.push("Remove the "+p.items[i].name);
		}

		slotChoices.push("Back");
		var result:String = menu("Equipment action", slotChoices);
		if (result == "Back") return;

		var slot:Int = slotChoices.indexOf(result);
		var toRemove:Bool = result.indexOf("Remove") != -1;

		if (toRemove) {
			var it:Item = p.items[slot];
			p.items.remove(it);
			data.items.push(it);
		} else {
			drawPetEquipMenu(p);
		}
	}

	public function drawPetEquipMenu(p:Pet):Void {
		var equipmentChoices:Array<String> = [];
		for (it in data.items)
			if (it.equippable)
				equipmentChoices.push(it.name);

		equipmentChoices.push("Back");
		var result:String = menu("Choose equipment", equipmentChoices);
		if (result == "Back") return;

		update();
		var it:Item = itemByName(result);
		data.items.remove(it);
		p.items.push(it);
	}

	public function newGameData():GameData {
		var d:GameData = {
			seconds: 0,
			hour: 0,
			pets: [],
			jobs: [],
			items: [],
			log: []
		};
		return d;
	}

	public function petByName(name:String):Pet {
		for (p in data.pets)
			if (p.name == name)
				return p;
		return null;
	}

	public function newPet():Pet {
		var pet:Pet = {
			name: "noname pet",
			job: "None",
			items: [],
			maxStamina: 100,
			stamina: 100,
			trust: 0,
			sensitivity: 0,
			ferocity: 0,
			spirit: 0,
			rhythm: 0
		}
		data.pets.push(pet);
		return pet;
	}
}

typedef GameData = {
	seconds:Float,
	hour:Int,
	pets:Array<Pet>,
	jobs:Array<Job>,
	items:Array<Item>,
	log:Array<String>
}

typedef Pet = {
	name:String,
	job:String,
	items:Array<Item>,

	maxStamina:Int,
	stamina:Int,

	trust:Int,
	sensitivity:Int,
	ferocity:Int,
	spirit:Int,
	rhythm:Int
}
