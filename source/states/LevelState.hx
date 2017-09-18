package states;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxPoint;
import flixel.tile.FlxTile;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import hud.PlayerHud;

/**
 * ...
 * @author ElRyoGrande
 */
class LevelState extends FlxState 
{
	//WORLD SETTINGS
	public static var TILE_WIDTH:Int = 16;
	public static var TILE_HEIGHT:Int = 16;
	//public static var LEVEL_WIDTH:Int = 50;
	//public static var LEVEL_HEIGHT:Int = 50;
	
	
	
	public var maps:FlxTilemap;
	public var player:Hero;
	public var floor:FlxObject;
	
	public var items:FlxSprite;
	public var grip :FlxSprite;
	
	
	//HUD
	public var _playerHud:PlayerHud;
	
	
	//SYSTEM ATTACK
	public var attacks:FlxTypedGroup<FlxSprite>;
	

	override public function create():Void 
	{
		super.create();
		
		
		
		//UTILE POUR LE DEBUG
		FlxG.mouse.visible = true;
		bgColor = 0xffaaaaaa;
		
		//GENERATION
		maps = GenerateLevel();
		
		FlxG.worldBounds.width = TILE_WIDTH * maps.widthInTiles;
		FlxG.worldBounds.height = TILE_HEIGHT * maps.heightInTiles;
		
		add(maps);
		add(player);
		
		//CAMERA SECTION
		camera.follow(player);
		
		//UI
		
		//HealthBar
		_playerHud = new PlayerHud(player);
		add(_playerHud);
		
		
		
		//Attack system basic
		attacks = new FlxTypedGroup<FlxSprite>();
		
	
	}
	
	override public function update(elapsed:Float):Void 
	{
		player.acceleration.x = 0;
		
		FlxG.collide(player, maps);
		//FlxG.overlap(items, player, getItem);
		//
		//FlxG.overlap(player, grip, getGripped);
		
		
		if (attacks.members.length > 0)
		{
			FlxG.overlap(player, attacks, onOverlaping);
			trace("CHECK ATTACK");
		}
	
		if (FlxG.keys.anyJustPressed([FlxKey.A]))
		{
			attacks.add(player);
		}
		if (FlxG.keys.anyJustPressed([FlxKey.E]))
		{
			attacks.remove(player,true);
		}
		
		if (FlxG.keys.anyJustPressed([FlxKey.R]))
		{
			FlxG.resetState();
		}
		
		
		super.update(elapsed);
		
	}
	
	public function onOverlaping(obj1:FlxObject, obj2:FlxObject)
	{
		trace("ON A HIT : " + obj2.toString());
	}
	
	
	//ALGO GENERATION MAP
	
	public function GenerateLevel():FlxTilemap
	{
		var mapTable = [FlxColor.WHITE, FlxColor.BLACK, FlxColor.BLUE, FlxColor.RED, FlxColor.GREEN];
		var mps = new FlxTilemap();
		var atile = new FlxTile(mps, 1, 16, 16, true, FlxObject.ANY);
	

		//var mapCSV = FlxStringUtil.imageToCSV("assets/data/mapo.png",false,1,mapTable);
		trace(mps.toString());
		var mapTilePath:String = "assets/data/tilezz.png";
		//mps.loadMapFromCSV(mapCSV, mapTilePath, 16, 16);
		mps.loadMapFromGraphic("assets/data/mapo.png", false, 1, [FlxColor.WHITE, FlxColor.BLACK,FlxColor.BLUE, FlxColor.RED,FlxColor.GREEN], mapTilePath, 16, 16, OFF, 0, 1, 1);
		trace("LVL WIDTH : " + mps.widthInTiles);
		
		trace("LVL HEIGHT : " + mps.heightInTiles);
		
		
		//Chargement de la position de départ du joueur
		var playerPos:Array<FlxPoint> = mps.getTileCoords(2, false);
		player = new Hero(playerPos[0].x, playerPos[0].y);
		
		
		//Chargement de la position des objets et instanciation des objets
		var itemPos:Array<FlxPoint> = mps.getTileCoords(3, false);
		for (i in itemPos)
		{
			items = new FlxSprite(itemPos[0].x, itemPos[0].y);
			items.loadGraphic("assets/images/batery.png");
			add(items);
		}
		
		//POUR LES AGGRIP
		//if (mps.getTileCoords(4, false) != null)
		//{
			mps.setTileProperties(4, FlxObject.NONE);
			var gripPos:Array<FlxPoint> = mps.getTileCoords(4, false);
			for (i in gripPos)
			{
			
			grip = new Grip(gripPos[0].x+9, gripPos[0].y+5);
			//grip.loadGraphic("assets/images/batery.png");
			//items.loadGraphic("assets/images/batery.png");
			grip.makeGraphic(16, 16, FlxColor.TRANSPARENT,true);
//
			//grip.width = 5;
			//grip.health = 10;
			grip.setSize(6, 4);
			//grip.offset.set(15, 4);

			add(grip);
			}
		
		//}
		
		
		
		
		
		//Remove de la case propre au joueur
		var playerTiles:Array<Int> = mps.getTileInstances(2);
		var playerTile:Int = playerTiles[0];
		mps.setTileByIndex(playerTile, -1, true);
		
		var itemTiles:Array<Int> = mps.getTileInstances(3);
		var itemTile:Int = itemTiles[0];
		mps.setTileByIndex(itemTile, -1, true);
		
		/*var gripTiles:Array<Int> = mps.getTileInstances(4);
		var gripTile:Int = gripTiles[0];
		mps.setTileByIndex(gripTile, -1, true);*/
		
		//mps.setTileProperties(1, FlxObject.ANY);
		trace(mps.totalTiles);
		return mps;
	}
	
	
}