package
{
	/*
	 * Packages the most commonly used items in the game for global access
	 * */
	import org.flixel.*;
	
	public class Registry
	{
		public static var player:Player;
		public static var bullets:BulletManager;
		public static var zombies:ZombieManager;
		public static var splatters:SplatterManager;
		
		public static const zombieCount:Number = 10;
		
		public function Registry()
		{
		}
	}
}