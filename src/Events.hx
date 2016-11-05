package;

class Events
{

	public static function jobTicked(job:Job, pet:Pet):Void {
		log('Job "${job.name}" ticked on pet "${pet.name}"');

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
			pet.stamina += 20;
		}

		if (pet.stamina <= 10) {
			pet.job = "None";
			log('${pet.name} was tired and came home');
		}

	}

	public static function idlePetTicked(p:Pet):Void {
		p.stamina -= 1;
		p.exp += 1;
		if (p.stamina <= 0) {
			p.job = "Sleep";
			log('${p.name} waited up for you, but couldn\'t quite make it.');
		}
	}

	public static function equipmentTicks(p:Pet):Void {
		for (item in p.items) {
			if (item.name == "Spirit Increaser") {
				p.spirit += 1;
			} else {
				log('Equipment "${item.name}" ticked on pet "${p.name}", but it was not intercepted');
			}
		}
	}
}
