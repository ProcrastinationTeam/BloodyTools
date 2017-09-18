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
	public var _staminaBar 				: FlxBar;
	public var _player:Hero;
	
	public function new(player:Hero) 
	{
		
		super();
		
		_player = player;
		
		_lifeBar = new FlxBar(8, 8, LEFT_TO_RIGHT,100 , 10);
		_lifeBar.createImageBar("assets/new_images/emptyBar.png", "assets/new_images/fillBar.png", FlxColor.TRANSPARENT, FlxColor.LIME);
		add(_lifeBar);
		
		_staminaBar = new FlxBar(8, 20, LEFT_TO_RIGHT, 100 , 10);
		_staminaBar.createImageBar("assets/new_images/emptyBar.png", "assets/new_images/fillBar.png", FlxColor.TRANSPARENT, FlxColor.LIME);
		add(_staminaBar);
		_staminaBar.value = 100;
		
		//DEBUGGER
		FlxG.watch.add(_staminaBar, "value", "Value");
		
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		if (FlxG.keys.anyJustPressed([FlxKey.L]))
		{
			_lifeBar.value = 100;
			_lifeBar.updateBar();
		}
		
		LifeEvolution();
		StaminaEvolution();
		
	}
	
	public function LifeEvolution()
	{
		
	}
	
	
	public function StaminaEvolution()
	{
		if (_player.isExhausted)
		{
			_staminaBar.value += 0.3;
		}
		else
		{
			if (FlxG.keys.anyPressed([FlxKey.O]))
			{
				consumeStamina(0.5);
			}
			else
			{
				_staminaBar.value += 0.3;
			}
		}
		
		
		
		
		if (_staminaBar.value == 0)
		{
			_player.isExhausted = true;
		}
		
		if (_staminaBar.value == 100)
		{
			if (_player.isExhausted)
			{
				_player.isExhausted = false;
			}
		}
		
	}
	
	public function regenStamina()
	{
		_staminaBar.value += 1;
	}
	
	public function consumeStamina(value:Float)
	{
		_staminaBar.value -= value;
	}
	
	
	public function consumeLife(value:Int)
	{
		_lifeBar.value -= value;
	}
	
	public function regenLife()
	{
		_lifeBar.value += 1;
	}
	
}