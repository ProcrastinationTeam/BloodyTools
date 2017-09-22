package hud;

import flixel.FlxG;
import flixel.addons.ui.FlxUIState;
import flixel.input.keyboard.FlxKey;
import states.LevelState;

/**
 * ...
 * @author ElRyoGrande
 */
class InventoryUI extends FlxUIState 
{

	override public function create() 
	{
		_xml_id = "InventoryUI_BackUp";
		//_xml_id = "_state_default";
		super.create();
	}
	
	public override function getRequest(name:String, target:Dynamic, data:Dynamic, ?params:Array<Dynamic>):Dynamic
	{
		return null;
	}	
	
	public override function getEvent(name:String, target:Dynamic, data:Dynamic, ?params:Array<Dynamic>):Void
	{
		if (params != null)
		{
			switch (name)
			{
				case "click_button":
					switch (Std.string(params[0]))
					{
						case "back": FlxG.switchState(new LevelState());
					}
			}
		}
	}
	
	public override function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
			if (FlxG.keys.anyJustPressed([FlxKey.I]))
		{
			FlxG.switchState(new LevelState());
		}
	}
	
}