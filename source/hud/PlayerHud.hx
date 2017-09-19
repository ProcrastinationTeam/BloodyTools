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

 //HUD GLOBAL DU JOUEUR
 //Regroupe les différents HUD au même endroit
 
class PlayerHud extends FlxTypedGroup<FlxSprite> 
{
	//BARRES ET EMPLACEMENT ITEMS
	public var _lifeBar					: FlxBar;
	public var _staminaBar 				: FlxBar;
	
	//A TRANSFORMER EN UNIQUE INVENTORY HUD
	public var _itemsHUDw				: FlxSprite;
	public var _itemsHUDw2				: FlxSprite;
	
	public var _player:Hero;
	
	public function new(player:Hero) 
	{
		
		super();
		
		
		_player = player;
		
		//BARRE DE VIE
		_lifeBar = new FlxBar(8, 8, LEFT_TO_RIGHT,100 , 10);
		_lifeBar.createImageBar("assets/new_images/emptyBar.png", "assets/new_images/fillBar.png", FlxColor.TRANSPARENT, FlxColor.LIME);
		_lifeBar.scrollFactor.x = 0;
		_lifeBar.scrollFactor.y = 0;
		_lifeBar.setRange(0, 100);
		//_lifeBar.barHeight = 20;
		_lifeBar.value = 100;
		add(_lifeBar);
		
		//BARRE DE STAMINA
		_staminaBar = new FlxBar(8, 20, LEFT_TO_RIGHT, 40 , 10);
		_staminaBar.createImageBar("assets/new_images/emptySBar.png", "assets/new_images/fillSBar.png", FlxColor.TRANSPARENT, FlxColor.LIME);
		_staminaBar.scrollFactor.x = 0;
		_staminaBar.scrollFactor.y = 0;
		_staminaBar.value = 100;
		add(_staminaBar);
		
		
		//ITEMS
		_itemsHUDw = new FlxSprite(player.x,player.y);
		_itemsHUDw.loadGraphic("assets/new_images/inventory.png", false, 34, 16, false);
		_itemsHUDw.scrollFactor.set(0, 0);
		_itemsHUDw.setPosition(600, 460);
		add(_itemsHUDw);
		
		//ITEMS
		_itemsHUDw2 = new FlxSprite(player.x,player.y);
		_itemsHUDw2.loadGraphic("assets/new_images/inventory.png", false, 34, 16, false);
		_itemsHUDw2.scrollFactor.set(0, 0);
		_itemsHUDw2.setPosition(580, 440);
		add(_itemsHUDw2);
		
		//DEBUGGER
		//FlxG.watch.add(_staminaBar, "value", "Value");
		
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