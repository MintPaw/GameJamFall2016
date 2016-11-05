package ;

class Jobs {

	public static function initJobs():Void {
		newJob("Moonrock Muncher", 15, 21);
		newJob("Maid", 12, 18);
		newJob("Priestess", 6, 12);
		newJob("Burglemeister", 0, 6);
		newJob("Rave Goddess", 18, 0);
		newJob("Game Designer", 17, 23);
		newJob("Eater of the Rich", 3, 9);
		newJob("Moongem Miner", 7, 13);
		newJob("Banker", 9, 15);

		newJob("Sleep", 0, 24);
		newJob("Test job", 0, 24);
	}

	public static function newJob(
			name:String,
			start:Int,
			end:Int
			):Job {
		var job:Job = {
			name: name,
			start: start,
			end: end
		};
		Game.data.jobs.push(job);
		return job;
	}

	public static function isJobReady(name:String):Bool {
		var job:Job = jobByName(name);
		var ready:Bool =
			Game.data.hour >= job.start &&
			Game.data.hour < job.end;

		return ready;
	}

	public static function jobByName(name:String):Job {
		for (job in Game.data.jobs)
			if (job.name == name)
				return job;
		return null;
	}
}

typedef Job = {
	name:String,
	start:Int,
	end:Int
}
