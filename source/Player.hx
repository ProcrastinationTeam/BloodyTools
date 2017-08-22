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
	public function new(?X:Float=0, ?Y:Float=0)
	{
		super(X, Y);

		loadGraphic(Tweaking.playerSprite, true, 16, 16);
		setFacingFlip(FlxObject.RIGHT, false, false);
		setFacingFlip(FlxObject.LEFT, true, false);

		animation.add("idle", [0], 10, true);
		animation.add("walk", [0, 1, 2, 1], 6, true);
		animation.add("run", [4, 3], 6, true);
		animation.add("text", [5, 6], 6, true);
		animation.add("call", [7, 8], 6, true);

		//drag.x = drag.y = 1600;
		
		maxVelocity.x = 400;
		maxVelocity.y = 2000;
		
		drag.x = maxVelocity.x * 8;
		acceleration.y = 3000;

		scale = new FlxPoint(3, 3);
		updateHitbox();
	}

	override public function update(elapsed:Float):Void
	{
		movement();

		super.update(elapsed);
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
		if (moveUp && isTouching(FlxObject.FLOOR))
		{
			velocity.y = -maxVelocity.y / 2;
		}
		
		if (velocity.x != 0)
		{
			animation.play("walk");
		}
		else
		{
			animation.play("idle");
		}
	}
}