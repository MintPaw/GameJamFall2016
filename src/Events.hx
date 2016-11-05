package;

class Events
{

	public static function jobTicked(job:Job, pet:Pet):Void {
		log('Job "${job.name}" ticked on pet "${pet.name}"');

		if (job.name == "Test Job") {
			pet.stamina -= 10;
		} else if (job.name == "Sleep") {
			pet.stamina += 10;
		} else {
			log('Job "${job.name}" ticked on pet "${pet.name}", but it was not intercepted');
		}

		if (pet.stamina <= 10) {
			pet.job = "None";
			log('${pet.name} was tired and came home');
		}

	}
}
