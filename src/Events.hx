package;

class Events
{
	public static function jobTicked(job:Job, pet:Pet):Void {
		pet.stamina -= 10;
		pet.exp += 4;
		var rand = Math.random();

		function bounty(amount:Int) {
			for (i in 0...amount) {
				var resource = pickOne(["Moon Chunk", "Moon Gem", "Soap", "Air Duster", "Wine", "Glowstick"]);
				obtainItem(resource);
			}
		}

		if (job.name == "Moonrock Muncher") {
			//Stats
			pet.ferocity += 1;
			pet.sensitivity -= 1;
			//Resources
			if (rand >= 0.5) {
				for (i in 0...2) obtainItem("Moon Chunk");
				for (i in 0...10) obtainItem("Moon Gem");
			} else if (rand <= 0.4) {
				for (i in 0...5) obtainItem("Moon Chunk");
				for (i in 0...2) obtainItem("Moon Gem");
			} else {
				for (i in 0...3) obtainItem("Moon Gem");
				for (i in 0...3) obtainItem("Moon Chunk");
			}
		} else if (job.name == "Maid") {
			//Stats
			pet.ferocity -= 1;
			pet.sensitivity += 1;
			//Resources
			if (rand >= 0.5) {
				for (i in 0...3) obtainItem("Soap");
				for (i in 0...3) obtainItem("Air Duster");
				for (i in 0...5) obtainItem("Moon Chunk");
			} else if (rand <= 0.4) {
				for (i in 0...2) obtainItem("Soap");
				obtainItem("Air Duster");
			} else {
				for (i in 0...3) obtainItem("Soap");
				for (i in 0...5) obtainItem("Moon Chunk");
			}
		} else if (job.name == "Priestess") {
			//Stats
			pet.spirit += 2;
			pet.sensitivity += 2;
			pet.ferocity -= 2;
			//Resources
			if (rand >= 0.5) {
				obtainItem("Wine");
				obtainItem("Moon Gem");
				
			} else if (rand <= 0.2) {
				for (i in 0...6) obtainItem("Moon Gem");
				for (i in 0...6) obtainItem("Wine");
				pet.maxStamina++;
			} else {
				obtainItem("Moon Gem");
				for (i in 0...6) obtainItem("Wine");
				for (i in 0...6) obtainItem("Moon Gem");
			}
		} else if (job.name == "Burglemeister") {
			//Stats
			pet.spirit -= 1;
			pet.sensitivity -= 2;
			pet.ferocity += 2;
			//Resources
			if (rand >= 0.5) {
				bounty(1);
			} else if (rand <= 0.2) {
				bounty(2);
				for (i in 0...10) obtainItem("Moon Chunk");
				pet.maxStamina++;
			} else {
				for (i in 0...10) obtainItem("Moon Chunk");
				bounty(10);
			}
		} else if (job.name == "Rave Goddess") {
			//Stats
			pet.rhythm += 3;
			pet.spirit += 3;
			//Resources
			if (rand >= 0.5) {
				for (i in 0...5) obtainItem("Glowstick");
					
			} else if (rand <= 0.2) {
				for (i in 0...10) obtainItem("Glowstick");
					if (itemCountByName("Meth") > 0) removeItem("Meth");
			} else {
				obtainItem("Moon Chunk");
				for (i in 0...10) obtainItem("Glowstick");
				for (i in 0...10) obtainItem("Moon Chunk");
				for (i in 0...6) obtainItem("Moon Gem");
				if (itemCountByName("Wine") > 0) removeItem("Wine");
			}
		} else if (job.name == "Game Designer") {
			//Stats
			pet.rhythm -= 1;
			pet.ferocity -= 3;
			//Resources
			if (rand >= 0.5) {
				bounty(10);
				if (itemCountByName("Moon Chunk") > 0) removeItem("Moon Chunk");
				if (itemCountByName("Moon Chunk") > 0) removeItem("Moon Gem"); 
			} else if (rand <= 0.05) {
				bounty(30);
				pet.maxStamina--;
			} else {
				bounty(15);
				for (i in 0...10) obtainItem("Moon Chunk");
				if (itemCountByName("Wine") > 0) removeItem("Wine");
				
			}
		} else if (job.name == "Eater of the Rich") {
			//Stats
			pet.spirit -= 2;
			pet.ferocity += 2;
			// Resources
			if (rand >= 0.5) {
				for (i in 0...5) obtainItem("Moon Gem");
				
			} else if (rand <= 0.05) {
				for (i in 0...30) obtainItem("Moon Gem");
				pet.maxStamina++;
			} else {
				for (i in 0...5) obtainItem("Moon Gem");
				for (i in 0...5) obtainItem("Moon Chunk");
			}
		} else if (job.name == "Moongem Miner") {
			//Stats
			pet.rhythm += 1;
			pet.sensitivity -= 1;
			//Resources
			if (rand >= 0.5) {
				for (i in 0...5) obtainItem("Moon Gem");
				for (i in 0...10) obtainItem("Moon Chunk");
				
			} else if (rand <= 0.05) {
				for (i in 0...30) obtainItem("Moon Gem");
				for (i in 0...30) obtainItem("Moon Chunk");
				pet.maxStamina--;
			} else {
				for (i in 0...20) obtainItem("Moon Gem");
				for (i in 0...40) obtainItem("Moon Chunk");
				if (itemCountByName("Glowstick") > 0) removeItem("Glowstick");
			}
		} else if (job.name == "Banker") {
			//Stats
			pet.rhythm -= 2;
			pet.spirit -= 2;
			//Resources
			if (rand >= 0.9) {
				for (i in 0...50) obtainItem("Moon Chunk");
				
			} else if (rand <= 0.05) {
				for (i in 0...10) obtainItem("Moon Gem");
				for (i in 0...50) obtainItem("Moon Chunk");
			} else {
				if (rand > 0.5) {
				for (i in 0...5) obtainItem("Moon Gem");
				} else {
				for (i in 0...10) obtainItem("Moon Chunk");
				}
			}
		} else if (job.name == "Sleep") {
			pet.exp -= 1;
			pet.stamina += 20;
		} else if (job.name == "Test job") {
			log('Job ticked');
			if (rand >= 0.5) {
				for (i in 0...2) obtainItem("Moon Chunk");
				obtainItem("Moon Gem");
			} else if (rand <= 0.4) {
				for (i in 0...3) obtainItem("Moon Chunk");
				obtainItem("Moon Gem");
			} else {
				for (i in 0...3) obtainItem("Moon Gem");
				for (i in 0...3) obtainItem("Moon Chunk");
			}
		}

		if (pet.stamina <= 10 && job.name != "Sleep") {
			pet.job = "None";
			log('${pet.name} comes home exhausted.');
			return; // TODO: Be super careful
		}

		if (pet.stamina >= pet.maxStamina && job.name == "Sleep") {
			pet.job = "None";
			if (Math.random() > 0.5) {
				log('${pet.name} wakes feeling rejuvenated.');
			} else {
				log('${pet.name} stretches out in her bed.');
			}
			return; // TODO: Be super careful
		}

		if (!isJobReady(pet.job)) {
			if (pet.job != "Sleep") log('${pet.name}\'s shift ended');
			pet.job = "None";
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


	public static function dayTicks(pet:Pet):Void {
		for (item in pet.items) {
			if (item.name == "Cute Hat") {
				pet.exp++;
				log('${pet.name} gained 1 EXP from the Cute Hat today.');
			} else if (item.name == "Cute Necklace") {
				pet.exp += 4;
				log('${pet.name} gained 4 EXP from the Cute Necklace today.');
			} else if (item.name == "Washable Inverted Cross Tattoo") {
				pet.exp += 10;
				pet.spirit -= 2;
				log('${pet.name} gained 10 EXP and lost 2 spirit from the Washable Inverted Cross Tattoo today.');
			} else if (item.name == "Nightlight") {
				if (pet.job == "Sleep") pet.exp += 25;
				log('${pet.name} got to sleep at a reasonable hour and Nighlight gained her 25 EXP!');
			} else if (item.name == "Comfy Little Bed of Spikes") {
				if (pet.job == "Sleep") pet.exp += 40;
				log('${pet.name} got to sleep at a reasonable hour and Comfy Little Bed of Spikes gained her 40 EXP!');
			} else if (item.name == "Heisenberg Hat") {
				pet.exp += 100;
				log('${pet.name} gained 100 EXP from the Heisenberg Hat today. She\'s also very comfortable with meth now.');
			}
		}

		var win:Bool = true;
		for (p in Game.data.pets)
			if (p.level < 10)
				win = false;

		if (win)
			log("You win!");

	}

	public static function equipmentAdded(pet:Pet, item:Item):Void {
		if (item.name == "Cute Hat") {
			if (pet.ferocity >= 50 && pet.trust <= 50) {
				log('She eats the hat. You stitch it back together and tell her to stop that.');
			} else if (pet.ferocity <= 50 && pet.trust >= 50) {
				log('She looks adorable.');
			} else if (pet.ferocity <= 50 && pet.trust <= 50) {
				log('She nibbles at the hat, wary.');
			} else if (pet.ferocity >= 50 && pet.trust >= 50) {
				log('She blushes and says it looks stupid. She wears it anyway.');
			} 	
		} else if (item.name == "Cute Necklace") {
			if (pet.sensitivity <= 50 && pet.trust <= 50) {
				log('She tries to eat the necklace but her teeth aren\'t hard enough.');
			} else if (pet.sensitivity >= 50 && pet.trust <= 50) {
				log('She sniffs the necklace.');
			} else if (pet.sensitivity >= 50 && pet.trust >= 50) {
				log('She looks at it, the glittery gems reflecting in her wide eyes.');
			} else if (pet.sensitivity <= 50 && pet.trust >= 50) {
				log('She doesn\'t even seem to notice you draped it over her neck.');
			} 	
		} else if (item.name == "Washable Inverted Cross Tattoo") {
			if (pet.spirit <= 50 && pet.trust >= 50) {
				log('She thinks it\'s rad as heck.');
			} else if (pet.spirit <= 50 && pet.trust <= 50) {
				log('She\'s not sure if you\'re stereotyping her or not. ');
			} else if (pet.spirit >= 50 && pet.trust >= 50) {
				log('She likes it, but she\'s a little worried about God hating her. You tell her it\'ll be fiiiine.');
			} else if (pet.spirit >= 50 && pet.trust <= 50) {
				log('She considers washing it off when you aren\'t looking, anxious about her eternal soul.');
			}
		} else if (item.name == "Nightlight") {
			if (pet.sensitivity >= 50 && pet.spirit >= 50) {
				log('She thinks the light is God and reveres it.');
			} else if (pet.sensitivity >= 50 && pet.spirit <= 50) {
				log('It\'s too bright. She makes you put a sticker over it.');
			} else if (pet.sensitivity <= 50 && pet.spirit <= 50) {
				log('She\'s sort of embarrassed. She doesn\'t think she needs a god-darn nightlight.');
			} else if (pet.sensitivity <= 50 && pet.spirit >= 50) {
				log('She thinks her new nightlight is a ghost.');
			}
		} else if (item.name == "Comfy Little Bed of Spikes") {
			if (pet.ferocity >= 50 && pet.spirit >= 50) {
				log('She says her prayers at night with her elbows on the spikes, totally unperturbed.');
			} else if (pet.ferocity >= 50 && pet.spirit <= 50) {
				log('She loves jumping on her bed.');
			} else if (pet.ferocity <= 50 && pet.spirit <= 50) {
				log('She\'s a little terrified of it at first, but you show her the spikes don\'t hurt if you lay on it right.');
			} else if (pet.ferocity <= 50 && pet.spirit >= 50) {
				log('She calls it a \"Satan bed\" and refuses to sleep on it. You\'re a demon, you remind her. Oh yeah, she says.');
			}
		} else if (item.name == "Heisenberg Hat") {
			if (pet.ferocity >= 50) log('She tells you to say her name.') else log('She thinks it\'s pretty swankish.');
		}
	}

	public static function equipmentRemoved(pet:Pet, item:Item):Void {
		log('Equipment "${item.name}" was removed from pet "${pet.name}"');
	}

	public static function consumableUsed(pet:Pet, item:Item):Void {
		var rand = (Math.random() > 0.5);
		var stamina20 = false;
		if (item.name == "Demon Treatz") {
			if (pet.stamina >= (pet.maxStamina - 10)) {
				println('She\'s full.');
			} else {
				if (pet.level >= 6) {
					pet.stamina += 20;
					var stamina20 = true;
				} else {
					pet.stamina += 30;
					var stamina20 = false;
				}

				if (pet.trust >= 50 && pet.ferocity >= 50 && pet.stamina >= 50) {
					println('You pop a couple pellets past your demon\'s lips.');
				} else if (pet.trust <= 50 && pet.ferocity >= 50 && pet.stamina <= 50) {
					if (rand) {
						println('She nearly bites your hand off to scarf down the pellets.');
					} else {
						println('She tears a hole in the bag and devours every last one of your Treatz.');
					}
				} else if (pet.trust <= 50 && pet.ferocity <= 50 && pet.stamina >= 50) {
					println('You hold some pellets out to her in a palm. She warily noses your hand until they drop, then picks at them.');
				} else if (pet.trust <= 50 && pet.ferocity <= 50 && pet.stamina <= 50) {
					println('You toss her some Demon Treatz. She stares at you, backs away. Slowly she sniffs them... tastes one... devours them.');
				} else if (pet.trust <= 50 && pet.ferocity >= 50 && pet.stamina >= 50) {
					println('She snaps at your hand and gives a guttural growl... nibbles at a few.');
				} else if (pet.trust >= 50 && pet.ferocity >= 50 && pet.stamina <= 50) {
					println('You hold out some Demon Treatz to her. She scarfs them from your palm, careful not to scratch you with her razor-teeth.');
				} else if (pet.trust >= 50 && pet.ferocity <= 50 && pet.stamina >= 50) {
					println('She\'s not very hungry, but she licks a couple out from the Demon Treatz bag anyway.');
				} else if (pet.trust >= 50 && pet.ferocity <= 50 && pet.stamina <= 50) {
					println('She gives a cute little keening noise and happily slurps the Treatz from your palm. Once her belly is full she sprawls out lazily and demon-purrs.');
				}

				if (stamina20) log('${pet.name} gained +20 stamina.') else log('${pet.name} gained +30 stamina.');
			}
		} else if (item.name == "Atlas Shrugged Paperback") {
			var bigLoss = false;
			if (pet.spirit > 5) {
				if (pet.level >= 3 && pet.level <= 8) {
					pet.spirit -= 5;
					pet.ferocity += 5;
					bigLoss = true;
				} else {
					pet.spirit -= 2;
					pet.ferocity -= 2;
				}

				if (pet.sensitivity >= 50 && pet.spirit <= 50) {
					println('It makes her feel pointless.');
				} else if (pet.sensitivity <= 50 && pet.spirit >= 50) {
					println('This is a load of bull-hockey, she says, but you can tell it still bothered her a little.');
				} else if (pet.sensitivity >= 50 && pet.spirit >= 50) {
					println('She starts crying and questioning her faith. Once that\'s over her expression steels.');
				} else if (pet.sensitivity <= 50 && pet.spirit <= 50) {
					println('She found it sort of boring.');
				}

				if (bigLoss) {
					log('${pet.name} lost 5 spirit and gained 5 ferocity.');
				} else {
					log('${pet.name} lost 2 spirit and gained 2 ferocity.');
				}
			} else {
				println('${pet.name} couldn\'t bring herself to read it. She\'s just too nihilistic.');
			}
		} else if (item.name == "Meth") {
			var hasHat:Bool = false;
			for (item in pet.items)
				if (item.name == "Heisenberg Hat")
					hasHat = true;

			if ((pet.maxStamina > 60 && pet.stamina < (pet.maxStamina - 10)) || hasHat) {
				pet.stamina += 60;
				if (!hasHat) pet.maxStamina -= 10;
				if (!hasHat) pet.trust -=15;
				if (pet.trust <= 50 && pet.rhythm >= 50) {
					println('She gets really paranoid and uncomfortable around you. You catch her dancing in the other room.');
				} else if (pet.trust <= 50 && pet.rhythm <= 50) {
					println('She thinks there\'s moonbugs in the carpet.');
				} else if (pet.trust >= 50 && pet.rhythm <= 50) {
					println('The extra energy makes her want to dance all fancy and floppy. She isn\'t very good, but she\'s having fun, and that\'s what matters.');
				} else if (pet.trust >= 50 && pet.rhythm >= 50) {
					println('She\'s twacked outta her dome zone. She grabs you by the hand and dances with you.');
				}
				log ('Gained 60 stamina, lost 10 max stamina, and lost 15 trust.');
			} else {
				println('She turns it down. She\'s trying to turn her life around, she says.');
			}
		} else if (item.name == "Bubblebath") {
			var trustBoost = false;
			if (pet.level <= 7 && pet.trust <= 90) {
				pet.trust += 10;
				trustBoost = true;
			}
			pet.stamina += 30;
			pet.ferocity -= 5;
			if (pet.ferocity <= 50 && pet.sensitivity <= 50) {
				println('She doesn\'t seem to mind the scrubs nor the dubs.');
			} else if (pet.ferocity <= 50 && pet.sensitivity >= 50) {
				println('She loves it. She asks you for a rubber ducky too next time.');
			} else if (pet.ferocity >= 50 && pet.sensitivity <= 50) {
				println('She bites at the bubbles.');
			} else if (pet.ferocity >= 50 && pet.sensitivity >= 50) {
				println('She pretends like she\'s too ferocious for a bubblebath, but you can tell she\'s having a great time.');
			}
			if (trustBoost) log('Gained 30 stamina, lost 5 ferocity, and gained 10 trust.') else log('Gained 30 stamina and lost 5 ferocity.');
		} else if (item.name == "Glowforce Supersonic Energy Beverage") {
			if (pet.stamina < pet.maxStamina) {
				pet.maxStamina += 5;
				var staminaDifference = (pet.maxStamina - pet.stamina);
				pet.stamina += staminaDifference;
			if (pet.ferocity >= 50 && pet.rhythm >= 50) {
				println('She goes wild and rips up the curtains and breakdances in the living room.');
			} else if (pet.ferocity <= 50 && pet.rhythm <= 50) {
				println('She starts rambling about demon culture and her parents. She\'s making most of it up.');
			} else if (pet.ferocity <= 50 && pet.rhythm >= 50) {
				println('You look away for a second and when you look back she\'s doing a lithe belly-dance sort of thing.');
			} else if (pet.ferocity >= 50 && pet.rhythm <= 50) {
				println('She snaps at some birds outside the house and chases them eight blocks away.');
			}
				log('${pet.name} max stamina increased by 5 and stamina refilled.');
			} else {
				log('She\'s too wired already!');
			}
		} else if (item.name == "Richard Simmons Workout DVD: The Route to Cute Glutes") {
			 var expBoost:Int = Math.ceil((Math.pow(2, pet.level) - pet.exp) * 0.5);
			 pet.exp += expBoost;
			 pet.maxStamina += 10;
			 pet.stamina -= 40;
			 if (pet.stamina < 0) pet.stamina = 0;
			 if (pet.spirit >= 50 && pet.rhythm <= 50) {
				println('This guy is great, she says, barely able to follow the steps.');
			} else if (pet.spirit >= 50 && pet.rhythm >= 50) {
				println('She works out big time. By the end of the DVD she\'s sprawled out on the couch panting.');
			} else if (pet.spirit <= 50 && pet.rhythm <= 50) {
				println('She doesn\'t have much fun with Richard.');
			} else if (pet.spirit <= 50 && pet.rhythm >= 50) {
				println('She follows the steps with absolute perfection. This is boring, she says.');
			}
				log('${pet.name}\'s max stamina increased by 10, had half of her remaining EXP filled, and lost 40 stamina.');
		}
	}

	public static function foundPet(pet:Pet):Void {
		log('A new pet was found');
	}
}
