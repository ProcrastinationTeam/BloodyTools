package weapons;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ElRyoGrande
 */
class Sword extends Weapon 
{
	public var yolo:FlxSprite;
	public var _player:Hero;
	
	public function new(player:Hero) 
	{
		_player = player;
		super(player,_weaponType);
		yolo = this.loadGraphic("assets/new_images/blade.png", true, 64, 64, false);
		
		
	}
	
	override public function update(elapsed:Float):Void
	{
		//this.setPosition(this.x-(yolo.width/2) , this.y+(yolo.height/2));

		super.update(elapsed);
	}
	
	override public function Attack()
	{
		this.setPosition(_player.x-10, _player.y+50);
	}
	
}