package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.input.keyboard.FlxKey;
import flixel.system.FlxAssets.FlxGraphicAsset;
import utils.Tweaking;

/**
 * ...
 * @author ElRyoGrande
 */
class Hero extends FlxSprite 
{
	public var horizontalSpeed:Int = 150;
	public var maxMoveSpeed:Int = 100;
	public var jumpingVelocity:Int=500;
	
	public var doubleJump :Int = 0;
	public var jumpC :Int = 0;
	
	public var buttonJumpRelease : Bool = false;
	public var playerIsGrip 	 :Bool = false;
	public var isJumping 		:Bool = false;
	public var canDoubleJump : Bool = false;
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		this.loadGraphic("assets/new_images/hero.png", true, 16, 16, false);
		this.scale.set(2, 2);
		this.setSize(16, 24);
		this.acceleration.y = 420;
		//this.drag.set(1000, 0);
		
		
		// Basic player physics
		this.drag.x = 640;
		this.maxVelocity.set(120, 200);
		
	}
	
	override public function update(elapsed:Float):Void
	{
		// Version 1 du move
		movement();

		//move();
		//weaponSprite.setPosition(this.x, this.y);
		super.update(elapsed);
	}
	
		private function movement():Void
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

		//if (FlxG.keys.anyPressed([FlxKey.RIGHT]))
		//{
			//if (!weaponSprite.visible)
			//{
				//weaponSprite.visible = true;
			//}
		//}
		//if (FlxG.keys.anyJustReleased([FlxKey.RIGHT]))
		//{
			//if (weaponSprite.visible)
			//{
				//weaponSprite.visible = false;
			//}
		//}

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
			//jumpTimer.start(100);
			//initialHeight = this.y;
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
			//maxHeightReach = false;
			buttonJumpRelease = true;
		}

		//if (velocity.x != 0)
		//{
			//if (moveDown)
			//{
				//animation.play("crouchWalk");
			//}
			//else
			//{
				//animation.play("walk");
			//}
		//}
		//else
		//{
			//if (!moveDown)
			//{
				//animation.play("idle");
			//}
			//else
			//{
				//animation.play("crouchWalk");
			//}
		//}
		//
		//if (velocity.y < 0)
		//{
//
			//animation.play("jump");
		//}
		//else if (velocity.y > 0)
		//{
			////trace("HIGH : " + -(this.y - initialHeight));
			//animation.play("fall");
//
		//}
	//
		
	
		
	}
}