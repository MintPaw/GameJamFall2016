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
		initShop();
		pause();

		genPet();

		// for (prod in data.products) {
		// 	if (prod.consumable)
		// 		obtainConsumable(prod.name);
		// 	else if (prod.equippable)
		// 		obtainEquipment(prod.name);
		// 	else
		// 		obtainItem(prod.name);
		// }

		while (true) {
			clear();
			update();
			drawMainMenu();
		}
	}

	public function genPet():Void {
		var p = newPet();
		foundPet(p);
	}

	public function update():Void {
		var secondsInHour:Float = 10;
		var hoursInDay:Float = 24;

		data.seconds += pollElapsed();
		var hoursPassed:Int = Std.int(data.seconds / secondsInHour);
		data.seconds -= hoursPassed*secondsInHour;
		data.hour += hoursPassed;

		var daysPassed:Int = Std.int(data.hour / hoursInDay);
		data.hour -= Std.int(daysPassed*hoursInDay);
		data.day += daysPassed;

		for (p in data.pets) {
			p.stamina = Std.int(clamp(p.stamina, 0, p.maxStamina));
			p.trust = Std.int(clamp(p.trust, 0, 100));
			p.sensitivity = Std.int(clamp(p.sensitivity, 0, 100));
			p.ferocity = Std.int(clamp(p.ferocity, 0, 100));
			p.spirit = Std.int(clamp(p.spirit, 0, 100));
			p.rhythm = Std.int(clamp(p.rhythm, 0, 100));
		}

		for (i in 0...hoursPassed)
			hourTick();

		for (i in 0...daysPassed)
			dayTick();
	}

	public function hourTick():Void {
		for (p in data.pets) {
			if (p.job != "None")
				jobTicked(jobByName(p.job), p);
			else
				idlePetTicked(p);

			if (p.exp > Math.pow(2, p.level)) {
				p.exp = 0;
				p.level++;
				log('${p.name} gained a level.');
			}
		}
	}

	public function dayTick():Void {
		if (data.day > 2*data.pets.length && data.pets.length < 30) genPet();
		for (p in data.pets)
			dayTicks(p);
	}

	public function drawMainMenu():Void {
		var time:Int = Game.data.hour % 24;
		var min:Int = Math.round(Game.data.seconds/10*60);
		var minStr:String = Std.string(min);

		drawLog();

		var result:String = menu(
				"Main menu",
				["Pets", "Shop", "Inventory", "Jobs", "Refresh", "Simulate time passing" ,"Quit"]
				);

		if (result == "Pets") {
			clear();
			drawPetsMenu();
		} else if (result == "Jobs") {
			clear();
			drawJobTable();
			pause();
		} else if (result == "Shop") {
			drawShop();
		} else if (result == "Simulate time passing") {
			drawTimeMenu();
		} else if (result == "Inventory") {
			clear();
			drawInvetory();
			pause();
		} else if (result == "Quit") {
			exit();
		}
	}

	public function drawLog():Void {
		println("=========================================================");
		println("Log:");
		for (i in data.log.length-10...data.log.length)
			if (data.log[i] != null)
				println(data.log[i]);
		println("=========================================================");
		println('Day ${data.day} ${getTimeString()}');
		print("\n");
	}

	public function drawTimeMenu():Void {
		clear();
		println("You decide to piddle around for this many hours: ");
		var result:Float = Std.parseFloat(getString());

		for (i in 0...10) {
			clear();
			lastTime -= result;
			update();
			drawLog();
			drawInvetory();
			sleep(500);
		}
	}

	public function drawInvetory():Void {
		var items:Array<String> = [];
		for (it in data.items)
			items.push(it.name);

		for (i in 0...items.length)
			items[i] += "  x" + itemCountByName(items[i]);

		var realItems:Array<String> = [];
		for (it in items)
			if (realItems.indexOf(it) == -1)
				realItems.push(it);

		for (line in realItems)
			println(line);
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
		println("Experience: "+pet.exp);
		println("Level: "+pet.level);
		println("Stamina: "+pet.stamina+"/"+pet.maxStamina);
		println("Trust: "+pet.trust);
		println("Sensitivity: "+pet.sensitivity);
		println("Ferocity: "+pet.ferocity);
		println("Spirit: "+pet.spirit);
		println("Rhythm: "+pet.rhythm);
		print("Equipment: ");

		var addComma = false;
		for (i in 0...3) {
			if (pet.items[i] != null) {
				if (addComma) println(" ,");
				print(pet.items[i].name);
				addComma = true;
			}
		}

		println("");
		println("Job: "+pet.job);
		println("");

		var petOptions:Array<String> = [];
		petOptions.push("Give consumable.");
		petOptions.push("Change equipment.");
		petOptions.push("Change name.");
		if (pet.job == "None") petOptions.push("Send to work.") else petOptions.push("Bring home.");
		petOptions.push("Back");

		var result:String = menu("Pet", petOptions);

		if (result == "Give consumable.") drawPetConsumableMenu(pet);
		if (result == "Change equipment.") drawPetEquipmentMenu(pet);
		if (result == "Change name.") drawPetNameMenu(pet);
		if (result == "Send to work.") drawPetJobMenu(pet);
		if (result == "Bring home.") {
			pet.job = "None";
			println("She came home.");
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
				println("She went off and started her workday.");
				pause();
			} else {
				println("That job isn\'t available.");
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
		if (result == "Back.") return;

		var slot:Int = slotChoices.indexOf(result);
		var toRemove:Bool = result.indexOf("Remove") != -1;

		if (toRemove) {
			var it:Item = p.items[slot];
			p.items.remove(it);
			data.items.push(it);
			equipmentRemoved(p, it);
			pause();
		} else {
			drawPetEquipMenu(p);
		}
	}

	public function drawPetNameMenu(pet:Pet):Void {
		clear();
		print('You stroke your chin. Yes, a better name for ${pet.name} would be: ');
		pet.name = getString();
		println('Yes, much better. From now on she shall be known as ${pet.name}.');
		pause();
	}

	public function drawPetEquipMenu(p:Pet):Void {
		var equipmentChoices:Array<String> = [];
		for (it in data.items)
			if (it.equippable)
				if (equipmentChoices.indexOf(it.name) == -1)
					equipmentChoices.push(it.name);

		for (i in 0...equipmentChoices.length) {
			equipmentChoices[i] += "  x" + itemCountByName(equipmentChoices[i]);
		}

		var realEquipmentChoices:Array<String> = [];
		for (it in equipmentChoices)
			if (realEquipmentChoices.indexOf(it) == -1)
				realEquipmentChoices.push(it);

		realEquipmentChoices.push("Back");
		var result:String = menu("Choose equipment", realEquipmentChoices);
		if (result == "Back") return;

		result = result.substring(0, result.indexOf("  "));
		println("Chose " + result);

		update();
		var it:Item = itemByName(result);
		data.items.remove(it);
		p.items.push(it);
		equipmentAdded(p, it);
		pause();
	}

	public function drawPetConsumableMenu(p:Pet):Void {
		var consumableChoices:Array<String> = [];
		for (item in data.items)
			if (item.consumable)
				consumableChoices.push(item.name);

		consumableChoices.push("Back");
		var result:String = menu("Choose consumable", consumableChoices);
		if (result == "Back") return;

		var item:Item = itemByName(result);
		consumableUsed(p, item);
		data.items.remove(item);
		pause();
	}

	public function newGameData():GameData {
		var d:GameData = {
			seconds: 0,
			hour: 0,
			day: 0,
			pets: [],
			jobs: [],
			items: [],
			products: [],
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
		var petNames:Array<String> = [
			"Velma",
			"Gorg",
			"Forkstench",
			"Big Jane Johnson",
			"Spanglehope",
			"Thronsteer, Seer of Gordongus",
			"Slambo",
			"Wingus",
			"Floatilla, Float-Demon",
			"Ebony Darkness Dementia Raven Way",
			"Aragorn",
			"Farstenstile"
		];
		for (i in 0...data.pets.length) petNames.push("newPet #"+i);

		var pet:Pet = {
			name: petNames[data.pets.length],
			job: "None",
			items: [],
			exp: 0,
			level: 1,
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
	day:Int,
	pets:Array<Pet>,
	jobs:Array<Job>,
	items:Array<Item>,
	products:Array<Product>,
	log:Array<String>
}

typedef Pet = {
	name:String,
	exp:Int,
	level:Int,
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
