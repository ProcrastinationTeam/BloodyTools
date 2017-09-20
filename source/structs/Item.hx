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
	
	public function new(?X:Float=0, ?Y:Float=0, type:ItemType, name:String) 
	{
		super(X, Y);
		_name = name;
		_type = type;
		
		
		if (_type == ItemType.weapon)
		{
			//a génériser
			_weaponType = WeaponType.axe; 
		}
		else
		{
			_weaponType = null;
		}
		
		//TEST SKIN NAME
		_skinName = "axeC64";
		//Changé tous les path
		var imageName = "assets/new_images/" + _skinName + ".png";
		this.loadGraphic(imageName, true, 64, 62, false);
		
		
		
		
	}
	
}