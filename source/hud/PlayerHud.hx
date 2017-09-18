package hud;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;


import flixel.ui.FlxBar;
import flixel.util.FlxColor;

/**
 * ...
 * @author ElRyoGrande
 */
class PlayerHud extends FlxTypedGroup<FlxSprite> 
{
	public var _lifeBar					: FlxBar;
	
	public function new(player:Hero) 
	{
		super();
		_lifeBar = new FlxBar(8, 8, LEFT_TO_RIGHT,100 , 10);
		
	//	_lifeBar.createGradientBar([FlxColor.RED], [FlxColor.BLUE, FlxColor.PURPLE, FlxColor.RED], 16, 90);
		//_lifeBar.createGradientFilledBar([FlxColor.WHITE, FlxColor.ORANGE, FlxColor.RED], 1, 180, false, FlxColor.BLACK);
		//_lifeBar.createImageFilledBar("assets/new_images/lifeBar.png", FlxColor.LIME);
		_lifeBar.createImageBar("assets/new_images/emptyBar.png", "assets/new_images/fillBar.png", FlxColor.TRANSPARENT, FlxColor.LIME);
		add(_lifeBar);
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		if (FlxG.keys.anyJustPressed([FlxKey.L]))
		{
			_lifeBar.value = 100;
			_lifeBar.updateBar();
		}
		if (FlxG.keys.anyPressed([FlxKey.O]))
		{
			_lifeBar.value -= 10;
			_lifeBar.updateBar();
		}
		
	}
	
}