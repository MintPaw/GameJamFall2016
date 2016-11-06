package;

class Items
{
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

	public static function removeItem(name:String):Void {
		Game.data.items.remove(itemByName(name));
	}

	public static function itemCountByName(name:String):Int {
		var count:Int = 0;
		for (item in Game.data.items)
			if (item.name == name)
				count++;

		return count;
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
