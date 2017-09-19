package inventory;

import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

/**
 * ...
 * @author ElRyoGrande
 */

 
//POUR STOCKER TOUS LES ITEMS PORTE PAR LE JOUEUR A L'INSTANT T

class InGameInventory extends FlxTypedGroup<FlxSprite> 
{

	public var leftHand1:FlxSprite;
	public var leftHand2:FlxSprite;
	public var rightHand1:FlxSprite;
	public var rightHand2:FlxSprite;
	
	public function new(MaxSize:Int=0) 
	{
		super(MaxSize);
		
		
		
		
		
		
	}
	
}