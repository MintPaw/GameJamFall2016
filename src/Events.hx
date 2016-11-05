package;

class Events
{

	public static function jobTicked(job:Job, pet:Pet):Void {

		pet.stamina -= 10;
		pet.exp += 4;

		if (job.name == "Moonrock Muncher") {
			//Stats
			pet.ferocity += 1;
			pet.sensitivity -= 1;
		} else if (job.name == "Maid") {
			//Stats
			pet.ferocity -= 1;
			pet.sensitivity += 1;
		} else if (job.name == "Priestess") {
			//Stats
			pet.spirit += 2;
			pet.sensitivity += 2;
			pet.ferocity -= 2;
		} else if (job.name == "Burglemeister") {
			//Stats
			pet.spirit -= 1;
			pet.sensitivity -= 2;
			pet.ferocity += 2;
		} else if (job.name == "Rave Goddess") {
			//Stats
			pet.rhythm += 3;
			pet.spirit += 3;
		} else if (job.name == "Game Designer") {
			//Stats
			pet.rhythm -= 1;
			pet.ferocity -= 3;
		} else if (job.name == "Eater of the Rich") {
			//Stats
			pet.spirit -= 2;
			pet.ferocity += 2;
		} else if (job.name == "Moongem Miner") {
			//Stats
			pet.rhythm += 1;
			pet.sensitivity -= 1;
		} else if (job.name == "Banker") {
			//Stats
			pet.rhythm -= 2;
			pet.spirit -= 2;
		} else if (job.name == "Sleep") {
			pet.exp -= 4;
			pet.stamina += 20;
		}

		if (pet.stamina <= 10 && job.name != "Sleep") {
			pet.job = "None";
			log('${pet.name} comes home, exhausted.');
		}

		if (pet.stamina >= pet.maxStamina && job.name == "Sleep") {
			pet.job = "None";
			if (Math.random() > 0.5) {
				log('${pet.name} wakes feeling rejuvenated.');
			} else {
				log('${pet.name} stretches out in her bed.');
			}
		}

	}

	public static function idlePetTicked(pet:Pet):Void {
		pet.stamina -= 1;
		pet.exp += 1;
		if (pet.stamina <= 0) {
			pet.job = "Sleep";
			log('${pet.name} waited up for you, but couldn\'t quite make it.');
		}
	}

	public static function equipmentTicks(pet:Pet):Void {
		for (item in pet.items) {
			if (item.name == "Spirit Increaser") {
				pet.spirit += 1;
			} else {
				log('Equipment "${item.name}" ticked on pet "${pet.name}", but it was not intercepted');
			}
		}
	}

	public static function equipmentAdded(pet:Pet, item:Item):Void {
		log('Equipment "${item.name}" was added from pet "${pet.name}"');
	}

	public static function equipmentRemoved(pet:Pet, item:Item):Void {
		log('Equipment "${item.name}" was removed from pet "${pet.name}"');
	}

	public static function consumableUsed(pet:Pet, item:Item):Void {
		if (item.name == "Energy giver") {
			pet.stamina += 50;
			log('"${pet.name}" gained some energy');
		} else {
			log('Consumable "${item.name}" was consumed by pet "${pet.name}", but it was not intercepted');
		}
	}
}
