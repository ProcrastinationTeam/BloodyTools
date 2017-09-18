package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ElRyoGrande
 */
class Enemy extends FlxSprite 
{

	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		this.loadGraphic("assets/new_images/MisterDougy.png", true, 16, 16, false);
		this.scale.set(2, 2);
		this.setSize(16, 24);
		
		this.acceleration.y = 420;
		//this.drag.set(1000, 0);
		
		
		// Basic player physics
		this.drag.x = 640;
		this.maxVelocity.set(120, 200);
	}
	
}