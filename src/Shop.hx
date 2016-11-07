package;

class Shop
{
	public static function initShop():Void {
		newConsumableProduct("Demon Treatz", ["Moon Chunk" => 10]);
		newConsumableProduct("Atlas Shrugged Paperback ", ["Moon Chunk" => 15, "Moon Gem" => 2]);
		newConsumableProduct("Meth", ["Moon Chunk" => 20, "Moon Gem" => 15, "Air Duster" => 10]);
		newConsumableProduct("Bubblebath", ["Moon Gem" => 10, "Soap" => 10]);
		newConsumableProduct("Glowforce Supersonic Energy Beverage", ["Moon Chunk" => 100, "Moon Gem" => 50, "Wine" => 10]);
		newConsumableProduct("Richard Simmons Workout DVD: The Route to Cute Glutes ", ["Moon Gem" => 150]);

		newEquippableProduct("Cute Hat", ["Moon Chunk" => 1]);
		newEquippableProduct("Cute Necklace", ["Moon Gem" => 8]);
		newEquippableProduct("Washable Inverted Cross Tattoo", ["Moon Chunk" => 20, "Moon Gem" => 10, "Soap" => 10]);
		newEquippableProduct("Nightlight", ["Moon Chunk" => 50, "Moon Gem" => 50, "Glowstick" => 20]);
		newEquippableProduct("Comfy Little Bed of Spikes", ["Moon Chunk" => 300]);
		// newEquippableProduct("Heavenly Bed", ["Moon Chunk" => 600]);
		// newEquippableProduct("The Devil's Own Crusty Mattress", ["Moon Chunk" => 200, "Moon Gem" => 40]);

		// newEquippableProduct("Studded Glowchoker", ["Moon Gem" => 80, "Glowstick" => 30]);
		// newEquippableProduct("Steamy Shower", ["Moon Chunk" => 200, "Soap" => 10, "Air Duster" => 30]);
		// newEquippableProduct("Necronomargaritaville", ["Moon Chunk" => 350, "Moon Gem" => 100, "Wine" => 50, "Demon Treatz" => 10]);
		newEquippableProduct("Heisenberg Hat", ["Meth" => 100]);
		// newEquippableProduct("Cuter Hat", ["Moon Chunk" => 200, "Moon Gem" => 200]);
		// newEquippableProduct("Multiplicatizer Choker", ["Moon Chunk" => 750, "Studded Glowchoker" => 3]);
	}

	public static function drawShop():Void {
		clear();
		var longestItemName:Int = 0;

		var affordable:Array<String> = [];
		var unAffordable:Array<String> = [];

		for (prod in Game.data.products) {
			longestItemName = Math.round(Math.max(longestItemName, prod.name.length));

			for (key in prod.price.keys()) {
				var amount:Int = prod.price.get(key);
				if (itemCountByName(key) < amount) {
					unAffordable.push(prod.name);
					break;
				}
			}
		}

		for (prod in Game.data.products)
			if (unAffordable.indexOf(prod.name) == -1)
				affordable.push(prod.name);

		var shopChoices:Array<String> = [];

		for (prod in Game.data.products) {
			var s:String = prod.name;
			while (s.length < longestItemName) s += " ";
			if (affordable.indexOf(prod.name) == -1) s += "(TOO EXPENSIVE)";
			for (key in prod.price.keys())
				s += '(${key}: ${prod.price.get(key)})';
			shopChoices.push(s);
		}

		shopChoices.push("Back");
		var result:String = menu("Buy which", shopChoices);
		if (result == "Back") return;

		var productResult:Product = Game.data.products[shopChoices.indexOf(result)];

		if (unAffordable.indexOf(productResult.name) != -1) {
			println("This item is too expensive");
		} else {
			println("You bought a "+productResult.name);

			for (key in productResult.price.keys()) {
				var amount:Int = productResult.price.get(key);
				for (i in 0...amount) {
					Game.data.items.remove(itemByName(key));
				}
			}

			if (productResult.consumable)
				obtainConsumable(productResult.name);
			else if (productResult.equippable)
				obtainEquipment(productResult.name);
			else
				obtainItem(productResult.name);
		}

		pause();
	}

	public static function newConsumableProduct(name:String, price:Map<String, Int>):Product {
		var product:Product = newProduct(name, price);
		product.consumable = true;
		return product;
	}

	public static function newEquippableProduct(name:String, price:Map<String, Int>):Product {
		var product:Product = newProduct(name, price);
		product.equippable = true;
		return product;
	}

	public static function newProduct(name:String, price:Map<String, Int>):Product {
		var product:Product = {
			name: name,
			consumable: false,
			equippable: false,
			price: price
		};
		Game.data.products.push(product);
		return product;
	}

	public static function productByName(name:String):Product {
		for (prod in Game.data.products)
			if (prod.name == name)
				return prod;
		return null;
	}
}

typedef Product = {
	name:String,
	consumable:Bool,
	equippable:Bool,
	price:Map<String, Int>
}
