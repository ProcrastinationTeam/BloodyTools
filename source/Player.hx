package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.math.FlxVelocity;
import flixel.system.FlxSound;
import flixel.util.FlxTimer;
import utils.Tweaking;
import flixel.math.FlxPoint;

class Player extends FlxSprite
{
	
	public var doubleJump :Int = 0;
	public var JumpC :Int = 0;
	public var jumpTimer : FlxTimer;
	public var timerManager : FlxTimerManager;
	
	public function new(?X:Float=0, ?Y:Float=0)
	{
		super(X, Y);
		
		FlxG.watch.add(this, "doubleJump", "dJump");
		timerManager = new FlxTimerManager();
		jumpTimer = new FlxTimer();
		

		loadGraphic(Tweaking.playerSprite, true, 16, 16);
		setFacingFlip(FlxObject.RIGHT, false, false);
		setFacingFlip(FlxObject.LEFT, true, false);

		animation.add("idle", [0], 10, true);
		animation.add("walk", [1], 6, true);
		animation.add("crouch", [2], 30, true);
		animation.add("crouchWalk", [6], 30, true);
		animation.add("jump", [3], 30, true);
		animation.add("fall", [4], 30, true);
		animation.add("afterfall", [5], 30, true);

		/* A MODIFIER */
		maxVelocity.x = 400;
		maxVelocity.y = 2000;
		
		drag.x = maxVelocity.x * 8;
		acceleration.y = 3000;

		//a rebuild
		scale = new FlxPoint(3, 3);
		//updateHitbox();
		setSize(6 * 3, 3 * 3);
		offset.set(0, 22);
	}

	override public function update(elapsed:Float):Void
	{
		movement();

		super.update(elapsed);
	}
	
	
	public function onTimer(timer:FlxTimer):Void
	{
		trace("HELLO");
		
	}
	
	/**
	 * Gestion des mouvements
	 */
	private function movement():Void
	{
		var moveUp:Bool = FlxG.keys.anyPressed([Tweaking.moveUp]);
		var moveDown:Bool = FlxG.keys.anyPressed([Tweaking.moveDown]);
		var moveLeft:Bool = FlxG.keys.anyPressed([Tweaking.moveLeft]);
		var moveRight:Bool = FlxG.keys.anyPressed([Tweaking.moveRight]);
		
		
		acceleration.x = 0;
		
		if (isTouching(FlxObject.FLOOR))
		{
			doubleJump = 0;
		}
		
		if (moveLeft)
		{
			acceleration.x -= maxVelocity.x * 6;
			facing = FlxObject.LEFT;
		}
		if (moveRight)
		{
			acceleration.x += maxVelocity.x * 6;
			facing = FlxObject.RIGHT;
		}
		
		if (FlxG.keys.anyJustPressed([Tweaking.moveUp]))
		{
			trace(" Debut du Jump");
			//jumpTimer.active = true;
			jumpTimer.start(100);
			
		}
		
		if (moveDown)
		{
			animation.play("crouch");
		}
		
		
	if (FlxG.keys.anyPressed([Tweaking.moveUp]))
		{
			
			trace(jumpTimer.elapsedTime);
			
			if (jumpTimer.elapsedTime > 0.2)
			{
			
			}
			
			
			if ((isTouching(FlxObject.FLOOR) || doubleJump < 2) && JumpC == 0)
			{
				velocity.y = -maxVelocity.y / 2;
			}
			JumpC++;
			
			
		}
		if (FlxG.keys.anyJustReleased([Tweaking.moveUp]))
		{
			JumpC = 0;
			doubleJump++;
			if (jumpTimer.elapsedTime < 0.5)
			{
				trace("DOWN");
				velocity.y += 9.81 * 9.81 * 3;
			}
		}
		
		if (velocity.x != 0)
		{
			if (moveDown)
			{
				
				animation.play("crouchWalk");
			}
			else
			{
				animation.play("walk");	
			}
			
		}
		else
		{
			if (!moveDown)
			{
				animation.play("idle");
			}
			
		}
		
		
		if (velocity.y < 0)
		{
			animation.play("jump");
		}
		else if (velocity.y > 0)
		{
			animation.play("fall");
		}
		
	}
	
	
	
	
	private function move():Void
	{
		
	}
}