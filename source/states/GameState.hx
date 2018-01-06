package states;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import states.GameState;

/**
 * ...
 * @author ElRyoGrande
 */
class GameState extends FlxState 
{
	public var player:Player;
	
	
	//MAPS AVEC TILED
	public var map:TiledLevel;
	public var floor:FlxObject;
	
	
	override public function create():Void
	{
		super.create();
		
		
		
		
		trace("START");
		map = new TiledLevel("assets/tiled/castleV.tmx", this);
		
		player = new Player(map.playerPos.x, map.playerPos.y);
		
		add(map.backgroundLayer);
		add(player);
		add(map.midgroundLayer);
		add(map.foregroundTiles);
		
		FlxG.camera.follow(player);
		//add(map.objectsLayer);
		
	}
	

	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		map.collideWithLevel(player);
		
	}
	
}