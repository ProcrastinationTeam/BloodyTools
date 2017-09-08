package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxPoint;
import flixel.math.FlxVelocity;
import flixel.system.FlxSound;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import utils.Tweaking;
import flixel.math.FlxPoint;

class Player extends FlxSprite
{

	public var doubleJump :Int = 0;
	public var JumpC :Int = 0;
	public var jumpTimer : FlxTimer;
	public var timerManager : FlxTimerManager;
	public var jumpingVelocity : Int = 600;
	public var maxJumpHeight : Float  = 200.0;
	public var currentHeight : Float ;
	public var initialHeight : Float ;
	public var maxHeightReach : Bool  = false;
	public var isJumping 		:Bool = false;

	//2nd MOVE
	public var canDoubleJump : Bool = false;
	public var jumpC :Int = 0;
	public var horizontalSpeed : Int = 1000;
	public var buttonJumpRelease : Bool = false;
	public var playerIsGrip 	 :Bool = false;

	//Weapon system
	public var weaponSprite : FlxSprite;

	public function new(?X:Float=0, ?Y:Float=0)
	{
		super(X, Y);

		//DEBUG SECTION WATCHER
		FlxG.watch.add(this, "canDoubleJump", "canDoubleJump");
		FlxG.watch.add(this, "jumpC", "JumpCount");
		FlxG.watch.add(this, "velocity", "vel");
		//TIMER DE TEST POUR LE SAUT
		timerManager = new FlxTimerManager();
		jumpTimer = new FlxTimer();

		//CHARGEMENT DU SPRITE ET SES ANIMS
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

		drag.x = maxVelocity.x * 10;
		acceleration.y = 3000;

		//a rebuild
		scale = new FlxPoint(2, 2);
		//updateHitbox();
		setSize(6 * 2, 3 * 2);
		offset.set(2, 18);

		//WEAPON SYSTEM INIT

		weaponSprite = new FlxSprite(this.x, this.y);
		weaponSprite.makeGraphic(16, 16, FlxColor.RED, false);
		weaponSprite.visible = false;
		//weaponSprite.loadGraphic(Tweaking.weaponSprite, true, 16, 16);

	}

	override public function update(elapsed:Float):Void
	{
		// Version 1 du move
		//movement();

		move();
		//weaponSprite.setPosition(this.x, this.y);
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
			if (isJumping)
			{
				isJumping = false;
				animation.play("afterfall");
			}

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

		if (moveDown)
		{
			animation.play("crouch");
		}

		/* JUMP */

		if (FlxG.keys.anyJustPressed([Tweaking.moveUp]))
		{
			trace(" Debut du Jump");
			jumpTimer.start(100);
			initialHeight = this.y;
			isJumping = true;

		}

		if (FlxG.keys.anyPressed([Tweaking.moveUp]))
		{

			if ((isTouching(FlxObject.FLOOR) || doubleJump < 2) && JumpC == 0)
			{
				//velocity.y = -maxVelocity.y / 2;
				velocity.y = -jumpingVelocity;
				JumpC++;
			}

			//trace("Jump Height : " + -(this.y - initialHeight));
			/*	if (maxJumpHeight < -(this.y - initialHeight) && !maxHeightReach)
				{
					trace("END OF THE JUMP");
					velocity.y = 0;
					maxHeightReach = true;
				}*/

		}

		if (FlxG.keys.anyJustReleased([Tweaking.moveUp]))
		{
			JumpC = 0;
			doubleJump++;
			if (jumpTimer.elapsedTime < 0.5)
			{
				trace("DOWN");
				velocity.y = 0; //* 9.81 * 3;
			}

			maxHeightReach = false;
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

		/* JUMP ANIMATION */
		//trace("Velocity Y  : " + velocity.y);
		if (velocity.y < 0)
		{

			animation.play("jump");
		}
		else if (velocity.y > 0)
		{
			//trace("HIGH : " + -(this.y - initialHeight));
			animation.play("fall");

		}

	}

	private function move():Void
	{
		/**DEBUG SECTION **\
		 ******************/

		if (FlxG.keys.anyPressed([FlxKey.SHIFT]))
		{
			if (FlxG.keys.anyPressed([FlxKey.J]))
			{
				canDoubleJump = true;
			}
		}

		//IS GROUNDED

		if (isTouching(FlxObject.FLOOR))
		{
			jumpC = 0;
			if (isJumping)
			{
				isJumping = false;
				//animation.play("afterfall");
			}
		}

		/**ATTACK**/

		if (FlxG.keys.anyPressed([FlxKey.RIGHT]))
		{
			if (!weaponSprite.visible)
			{
				weaponSprite.visible = true;
			}
		}
		if (FlxG.keys.anyJustReleased([FlxKey.RIGHT]))
		{
			if (weaponSprite.visible)
			{
				weaponSprite.visible = false;
			}
		}

		/**MOVE**/

		var moveLeft:Bool = FlxG.keys.anyPressed([Tweaking.moveLeft]);
		var moveRight:Bool = FlxG.keys.anyPressed([Tweaking.moveRight]);
		var moveDown:Bool = FlxG.keys.anyPressed([Tweaking.moveDown]);
		
		acceleration.x = 0;
		if (!playerIsGrip)
		{
			if (moveLeft)
			{
				if (isTouching(FlxObject.FLOOR))
				{
					acceleration.x += -horizontalSpeed ;
				}
				else
				{
					acceleration.x += -horizontalSpeed * 4 ;
				}
				
				facing = FlxObject.LEFT;
			}
			if (moveRight)
			{
				if (isTouching(FlxObject.FLOOR))
				{
					acceleration.x += horizontalSpeed ;
				}
				else
				{
					acceleration.x += horizontalSpeed * 4 ;
				}
				
				facing = FlxObject.RIGHT;
			}
		}
		
		if (FlxG.keys.anyJustPressed([Tweaking.moveUp]))
		{
			trace(" Debut du Jump");
			jumpTimer.start(100);
			initialHeight = this.y;
			isJumping = true;
		}

		if (FlxG.keys.anyPressed([Tweaking.moveUp]))
		{
			if (playerIsGrip)
			{
				velocity.y = - jumpingVelocity;
				acceleration.y = 3000;
				playerIsGrip = false;
				buttonJumpRelease = false;
				jumpC++;

			}
			else
			{
				//SIMPLE SAUT
				if (isTouching(FlxObject.FLOOR) && jumpC == 0)
				{
					velocity.y = -jumpingVelocity;
					jumpC++;
					buttonJumpRelease = false;
				}

				//DOUBLE SAUT
				if (canDoubleJump)
				{
					if (jumpC == 1 && buttonJumpRelease)
					{
						velocity.y = -jumpingVelocity;
						jumpC++;
						buttonJumpRelease = false;
					}
				}
			}

		}

		if (FlxG.keys.anyJustReleased([Tweaking.moveUp]))
		{
			//JumpC = 0;
			doubleJump++;
			maxHeightReach = false;
			buttonJumpRelease = true;
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
			//trace("HIGH : " + -(this.y - initialHeight));
			animation.play("fall");

		}
	
		
	
		
	}
}