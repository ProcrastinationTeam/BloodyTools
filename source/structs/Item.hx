package structs;

import enums.ItemType;
import enums.WeaponType;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ElRyoGrande
 */
class Item extends FlxSprite 
{
	public var _type:ItemType;
	public var _name:String;
	public var _skinName:String;
	public var _weaponType:WeaponType;
	
	//MATCH ENTRE _skinName et _name possible
	
	public function new(?X:Float=0, ?Y:Float=0, type:ItemType, name:String) 
	{
		super(X, Y);
		_name = name;
		_type = type;
		
		
		switch (_type) 
		{
			case ItemType.weapon:
				_weaponType = WeaponType.axe; 
				//TEST SKIN NAME
				_skinName = "axe16";
				//Changé tous les path
				var imageName = "assets/new_images/" + _skinName + ".png";
				this.loadGraphic(imageName, true, 16, 16, false);
				
			case ItemType.consumable:
				_skinName = "potion";
				var imageName = "assets/new_images/" + _skinName + ".png";
				this.loadGraphic(imageName, true, 16, 16, false);
				
			case ItemType.wearable:
				
			case ItemType.story:
				
			default:
				
		}
		
		//if (_type == ItemType.weapon)
		//{
			////a génériser
			//
		//}
		//else
		//{
			//_weaponType = null;
		//}
		

		
		
		
		
		
	}
	
}