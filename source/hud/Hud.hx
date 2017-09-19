package hud;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.group.FlxGroup.FlxTypedGroup;

class Hud extends FlxTypedGroup<FlxSprite>
{
	public var _width			: Int = 720;
	public var _height			: Int = 720;
	private var _player 		: Hero;

	public var _testSprite		: FlxSprite;
	public var _miniMap			: FlxSprite;
	public var _playerInfos		: FlxSprite;

	public function new(player:Hero)
	{
		super();

		_player = player;

		var x:Int = 20000;
		
		//_miniMap = new FlxSprite(player.x,player.y).makeGraphic(64, 64, FlxColor.BLUE);
		//_miniMap.scrollFactor.x = 0;
		//_miniMap.scrollFactor.y = 0;
		//add(_miniMap);
	}
}