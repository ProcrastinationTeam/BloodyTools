package states; 

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.tiled.TiledMap;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.tile.FlxTile;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import flixel.util.FlxStringUtil;
import haxe.Json;
import sys.io.File;


class PlayState extends FlxState
{
	public var level:TiledLevel;
	public var maps:FlxTilemap;
	
	
	public var score:FlxText;
	public var status:FlxText;
	public var coins:FlxGroup;
	public var player:Player;
	public var floor:FlxObject;
	public var exit:FlxSprite;
	
	private static var youDied:Bool = false;
	

	
	public var items:FlxSprite;
	
	
	override public function create():Void 
	{
		super.create();
		//player = new Player(100, 50);
		
		maps = GenerateLevel();
		
		/*
		var playerPos:Array<FlxPoint> = maps.getTileCoords(3, false);
		player = new Player(playerPos[0].x, playerPos[0].y);*/
		
		
		
		add(maps);
		add(player);
		//add(player);
		
		
		
		//UTILE POUR LE DEBUG
		FlxG.mouse.visible = true;
		
		bgColor = 0xffaaaaaa;
		
		// Load the level's tilemaps
		//coins = new FlxGroup();
		//level = new TiledLevel("assets/tiled/level.tmx", this);
		
		// Add backgrounds
		//add(level.backgroundLayer);

		// Draw coins first
		//add(coins);
		
		// Add static images
		//add(level.imagesLayer);
		
		// Load player objects
		//add(level.objectsLayer);
		//add(level.objectsLayer.
		
		// Add foreground tiles after adding level objects, so these tiles render on top of player
		//add(level.foregroundTiles);
		
		// Create UI
		//score = new FlxText(2, 2, 80);
		//score.scrollFactor.set(0, 0); 
		//score.borderColor = 0xff000000;
		//score.borderStyle = SHADOW;
		//score.text = "SCORE: " + (coins.countDead() * 100);
		//add(score);
		//
		//status = new FlxText(FlxG.width - 160 - 2, 2, 160);
		//status.scrollFactor.set(0, 0);
		//status.borderColor = 0xff000000;
		//score.borderStyle = SHADOW;
		//status.alignment = RIGHT;
		//status.text = youDied ? "Aww, you died!" : "Collect coins.";
		//add(status);
		//
		
		
		/*ESSAI CDB */
		//var file = File.getContent("assets/data/new.cdb");
		//var o = Json.parse("pic");
		//trace(o);
		
	}
	
	override public function update(elapsed:Float):Void 
	{
		player.acceleration.x = 0;
		
		FlxG.collide(player, maps);
		FlxG.overlap(items, player, getItem);
		
		
		super.update(elapsed);
		
		
		
		// Collide with foreground tile layer
		//level.collideWithLevel(player);
		
		
		
		//FlxG.overlap(exit, player, win);
		
		/*if (FlxG.overlap(player, floor))
		{
			youDied = true;
			FlxG.resetState();
		}*/
	}
	
	public function win(Exit:FlxObject, Player:FlxObject):Void
	{
		status.text = "Yay, you won!";
		score.text = "SCORE: 5000";
		player.kill();
	}
	
	public function getItem(Item:FlxObject, Player:FlxObject):Void
	{
		Item.kill();
		player.canDoubleJump = true;
		//score.text = "SCORE: " + (coins.countDead() * 100);
	/*	if (coins.countLiving() == 0)
		{
			status.text = "Find the exit";
			exit.exists = true;
		}*/
	}
	
	public function GenerateLevel():FlxTilemap
	{
		var mapTable = [FlxColor.WHITE, FlxColor.BLACK, FlxColor.RED, FlxColor.BLUE];
		var mps = new FlxTilemap();
		var atile = new FlxTile(mps, 1, 16, 16, true, FlxObject.ANY);
	

		var mapCSV = FlxStringUtil.imageToCSV("assets/data/map.png", false,1,mapTable);
		
		var mapTilePath:String = "assets/images/tO.png";
		mps.loadMapFromCSV(mapCSV, mapTilePath, 16, 16);
		//mps.loadMapFromGraphic("assets/data/map.png", false, 1, [FlxColor.WHITE, FlxColor.BLACK, FlxColor.RED,FlxColor.YELLOW], mapTilePath, 16, 16, OFF, 0, 1, 1);
		
		
		
		//Chargement de la position de départ du joueur
		var playerPos:Array<FlxPoint> = mps.getTileCoords(3, false);
		player = new Player(playerPos[0].x, playerPos[0].y);
		
		
		//Chargement de la position des objets et instanciation des objets
		var itemPos:Array<FlxPoint> = mps.getTileCoords(2, false);
		for (i in itemPos)
		{
			items = new FlxSprite(itemPos[0].x, itemPos[0].y);
			items.loadGraphic("assets/images/batery.png");
			add(items);
		}
		
		
		//Remove de la case propre au joueur
		var playerTiles:Array<Int> = mps.getTileInstances(3);
		var playerTile:Int = playerTiles[0];
		mps.setTileByIndex(playerTile, -1, true);
		
		var itemTiles:Array<Int> = mps.getTileInstances(2);
		var itemTile:Int = itemTiles[0];
		mps.setTileByIndex(itemTile, -1, true);
		
		
		
		
		return mps;
	}
	
	
}