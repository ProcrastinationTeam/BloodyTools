package hud;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ElRyoGrande
 */
class InventoryHUD extends FlxSprite 
{

	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		this.loadGraphic("assets/new_images/inventory.png", false, 34, 16, false);
		this.scrollFactor.set(0, 0);
		this.setPosition(600, 460);
	}
	
}