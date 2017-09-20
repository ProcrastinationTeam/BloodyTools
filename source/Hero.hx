package;

import enums.WeaponType;
import flixel.text.FlxText;
import hud.Hud;
import hud.PlayerHud;
import inventory.InGameInventory;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.weapon.FlxWeapon;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import hud.InventoryHUD;
import inventory.Inventory;
import utils.Tweaking;
import weapons.Axe;
import weapons.Sword;
import weapons.Weapon;

/**
 * ...
 * @author ElRyoGrande
 */
class Hero extends FlxSprite 
{
	//BASIC STATS
	public var pHealth:Int = 200;
	public var maxHealth:Int = 200;
	public var stamina:Int = 100;
	public var maxStamina:Int = 100;
	
	
	//PLAYER STATE
	public var isSprinting:Bool = false;
	public var isExhausted:Bool = false;
	
	
	//MOVEMENT
	public var horizontalSpeed:Int = 150;
	public var maxMoveSpeed:Int = 100;
	public var jumpingVelocity:Int=500;
	
	public var doubleJump :Int = 0;
	public var jumpC :Int = 0;
	
	public var buttonJumpRelease : Bool = false;
	public var playerIsGrip 	 :Bool = false;
	public var isJumping 		:Bool = false;
	public var canDoubleJump : Bool = false;
	
	//ATTACK SYSTEM
	public var isVulnerable:Bool = true;
	
	
	
	//HUD SYSTEM
	public var playerHud:PlayerHud;
	public var HUD:Hud;
	public var inventoryHUD:InventoryHUD;
	
	//INVENTORY SYSTEM
	public var inventory:Inventory;
	public var igInvent:InGameInventory;
	
	//public var currentEquipedWeapon : Sword;
	public var currentEquipedWeapon : Weapon;
	
	
	
	//Weapon system
	//public var weaponSprite : FlxSprite;
	public var weaponSprite : Weapon;
	
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		this.loadGraphic("assets/new_images/hero.png", true, 16, 16, false);
		this.scale.set(2, 2);
		this.setSize(16, 24);
		this.acceleration.y = 420;
		
		
		
		// Basic player physics
		this.drag.x = 640;
		this.maxVelocity.set(120, 200);
		
		//HUD
		playerHud = new PlayerHud(this);
		
		
	
		
		//INVENTORY SYSTEM
		inventory = new Inventory(10,this);
		
		
		//WEAPON TEST
		currentEquipedWeapon = new Weapon(this,WeaponType.axe);
		weaponSprite = currentEquipedWeapon;
		weaponSprite.visible = false;
		
	}
	
	override public function update(elapsed:Float):Void
	{
		// Version 1 du move
		movement();
		attackSystem();
		
		if (FlxG.keys.anyJustPressed([FlxKey.P]))
		{
			
			weaponSprite.SwitchWeapon(WeaponType.sword);
			
			weaponSprite.visible = false;

			//var tempCurrent = new Axe(this);
			//currentEquipedWeapon = 
			//weaponSprite = tempCurrent;
			//weaponSprite.loadGraphic("assets/new_images/axeC64.png", true, 64, 62, false); 
		}

		super.update(elapsed);
	}
	
	private function switchWeapon():Void{
		
	}
	
	private function attackSystem():Void
	{
		//FIRST ATTACK TEST
		if (FlxG.keys.anyJustPressed([FlxKey.K]))
		{
			weaponSprite.Attack();
			weaponSprite.setPosition(this.x, this.y);
			weaponSprite.visible = true;
		}

		if (FlxG.keys.anyJustReleased([FlxKey.K]))
		{
			weaponSprite.visible = false;
		}
		
		if (!isVulnerable)
		{
			//if (attacks.members.length > 0)
			//{
				//trace("CHECK ATTACK");
			//}
			//si touché
			//if()
			
		}
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

		if (FlxG.keys.anyPressed([FlxKey.RIGHT]))
		{
			if (!weaponSprite.visible)
			{
				trace("ATTACK");
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