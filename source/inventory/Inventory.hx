package inventory;

import enums.ItemType;
import enums.WeaponType;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import structs.Item;
import weapons.Axe;
import weapons.Weapon;

/**
 * ...
 * @author ElRyoGrande
 */

 //POUR STOCKER TOUS LES ITEMS DU JOUEUR
 
class Inventory extends FlxTypedGroup<FlxSprite> 
{
	
	//Reference sur le joueur
	public var _player:Hero;
	
	public var weaponItems:FlxTypedGroup<Weapon>;
	public var consumableItems:FlxTypedGroup<FlxSprite>;
	public var wearableItems:FlxTypedGroup<FlxSprite>;
	public var storyItems:FlxTypedGroup<FlxSprite>;
	
	
	
	public function new(MaxSize:Int=0,player:Hero) 
	{
		super(MaxSize);
		_player = player;
		
		//FULL TEST
		weaponItems = new FlxTypedGroup<Weapon>();
		trace("TAILLE INVENTAIRE : " + weaponItems.length);
		
		weaponItems.maxSize = 2;
		//weaponItems.add(new Weapon(player, WeaponType.axe));
		//weaponItems.add(new Weapon(player, WeaponType.sword));
		//
		
		
		
		//POUR LE TEST AVEC LE HUD DES ARMES
		wearableItems = new FlxTypedGroup<FlxSprite>();
		
		var yoooolo = new FlxSprite(0, 0);
		yoooolo.loadGraphic("assets/new_images/axe16.png", false, 16, 16, false);
		
		var yolot = new FlxSprite(0, 0);
		yolot.loadGraphic("assets/new_images/shur.png", false, 16, 16, false);
		
		wearableItems.add(yoooolo);
		wearableItems.add(yolot);
		//trace(weaponItems.members[0]._weaponType + " , " + weaponItems.members[1]._weaponType);
		
		
		
	}
	
	
	
	public function addItemToInventory(item:Item)
	{
		switch(item._type)
		{
			case ItemType.consumable:
				trace("On ajoute un consommable !");
			case ItemType.story:
				trace("On ajoute un objet d'histoire !");
			case ItemType.weapon:
				trace("On ajoute une arme !");
				weaponItems.add(new Weapon(_player, item._weaponType));
				trace("TAILLE INVENTAIRE : " + weaponItems.length);
			case ItemType.wearable:
				trace("On ajoute une armure !");
			default:
		}
	}
	
	
}