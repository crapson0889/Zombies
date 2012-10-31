package  weapons
{
	/*
	 *	Handles all of the bullets in the game
	 * */
	import org.flixel.*;

	public class BulletManager extends FlxGroup
	{
		
		public function BulletManager() 
		{
			super();
			
			//	There are 40 bullets in our pool
			for (var i:int = 0; i < 100; i++)
			{
				add(new Bullet);
			}
		}
		
		public function fire():void
		{
			if (getFirstAvailable())
			{
				Bullet(getFirstAvailable()).fire(Registry.player.x, Registry.player.y);
			}
		}

		public function bulletHitTile(bullet:Bullet, tile:FlxTilemap):void 
		{
			bullet.exists = false;
			//bullet.kill();
			//add(new Bullet());
		}
		
	}

}