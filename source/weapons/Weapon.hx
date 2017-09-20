package weapons;

import enums.WeaponType;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

/**
 * ...
 * @author ElRyoGrande
 */

 
 
class Weapon extends FlxSprite 
{
	public var _damage:Int;
	public var _range:Int;
	public var _weaponType:WeaponType;
	public var _durability:Int;
	public var _weight:Int;
	
	
	
	public var _skin:String;
	
	//public function new(?X:Float=0, ?Y:Float=0) 
	public function new(player:Hero, weaponT:WeaponType) 
	{
		//super(X, Y);
		super(player.x, player.y);
		scrollFactor.set(0, 0);
		//Init everythings
		_weaponType = weaponT;
		_damage = 10;
		_range = 5;
		_skin = "assets/new_images/axeC64.png";
		
		switch (_weaponType) 
		{
			case WeaponType.axe:
				this.loadGraphic("assets/new_images/axeC64.png", true, 64, 62, false);
			case WeaponType.sword:
				this.loadGraphic("assets/new_images/blade.png", true, 64, 64, false);
			case WeaponType.dagger:
				
			case WeaponType.spear:
			
			case WeaponType.none:
				makeGraphic(1, 1, FlxColor.TRANSPARENT, false);
			default:
				
		}
		
		
		
	}
		

	//public function SwitchWeapon(weapT:WeaponType)
	//{
		//trace("SWITCH");
		//switch (weapT) 
		//{
			//case WeaponType.axe:
				//this.loadGraphic("assets/new_images/axeC64.png", true, 64, 62, false);
			//case WeaponType.sword:
				//this.loadGraphic("assets/new_images/blade.png", true, 64, 64, false);
			//case WeaponType.dagger:
				//
			//case WeaponType.spear:
				//
			//default:
				//
		//}
		//
	//}

	
	
	public function Attack()
	{
		
	}
}