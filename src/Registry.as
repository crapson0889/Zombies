package
{
	/*
	 * Packages the most commonly used items in the game for global access
	 * 
	 * The basic Idea here is that the Registry would house some of the more commonly used
	 * items in the game so that they are easier to get to. For instance all of the 
	 * _____Managers are just FlxGroups that hold multiple instances of ______. This 
	 * allows for calls like Registry.splatters.explode() and handling the creation
	 * of the splatter would be handled by the manager and triggering is handled by the 
	 * manager. This makes coding easier and managing items easier.
	 * 
	 * More info here: http://www.photonstorm.com/archives/1136/flash-game-dev-tip-1-creating-a-cross-game-communications-structure
	 * */

	import fx.Darkness;
	import org.flixel.*;
	import player.PlayerManager;
	import weapons.BulletManager;
	import zombies.ZombieManager;
	import fx.SplatterManager;
	import levels.*;
	
	public class Registry
	{
		public static var player:PlayerManager;
		public static var bullets:BulletManager;
		public static var zombies:ZombieManager;
		public static var splatters:SplatterManager;
		public static var level1:Level1;
		public static var supplyLocations:FlxTilemap;
		public static var supplyManager:SupplyManager;
		public static var score:uint;
		public static var darkness:Darkness;
		
		public static const zombieCount:uint = 10;
		public static var batteryLife:uint = 10;
		
		public function Registry()
		{
		}
		
		public static function erase():void 
		{
			player = null;
			bullets = null;
			zombies = null;
			splatters = null;
			level1 = null;
			supplyLocations = null;
			supplyManager = null;
			darkness = null;
			score = 0;
			batteryLife = 10;
		}
	}
}