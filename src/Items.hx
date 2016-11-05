package;

class Items {

	public static function obtainConsumable(name:String):Item {
		var item:Item = obtainItem(name);
		item.consumable = true;
		return item;
	}

	public static function obtainEquipment(name:String):Item {
		var item:Item = obtainItem(name);
		item.equippable = true;
		return item;
	}

	public static function obtainItem(name:String):Item {
		var item:Item = {
			name: name,
			equippable: false,
			consumable: false
		}
		Game.data.items.push(item);
		return item;
	}

	public static function itemByName(name:String):Item {
		for (item in Game.data.items)
			if (item.name == name)
				return item;
		return null;
	}

}

typedef Item = {
	name:String,
	equippable:Bool,
	consumable:Bool
}
