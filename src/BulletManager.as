package  
{
	import org.flixel.*;

	public class BulletManager extends FlxGroup
	{
		
		public function BulletManager() 
		{
			super();
			
			//	There are 40 bullets in our pool
			for (var i:int = 0; i < 40; i++)
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
		
	}

}