package;

import flixel.FlxGame;
import openfl.display.Sprite;
import states.GameState;
import states.PlayState;
import states.LevelState;

class Main extends Sprite
{
	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, GameState));
	}
}