package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

/**
 * ...
 * @author ElRyoGrande
 */
class Grip extends FlxSprite 
{

	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		makeGraphic(16, 6, FlxColor.TRANSPARENT, false);
		//setSize(16, 6);
		offset.set(3, 10);
	}
	
}