package  
{
	import org.flixel.*;
	
	public class ZombieManager extends FlxGroup
	{
		public var currentDirection:int;
		
		public function ZombieManager() 
		{
			super();
			maxSize = 5;
			
			currentDirection = 1;
			
			for (var i:int = 0; i < 7; i++)
			{
				add(new Zombie);
			}
		}	
		
		public function drop(Timer:FlxTimer):void
		{			
			currentDirection = currentDirection * -1;
			
			if (getFirstAvailable())
			{
				Zombie(getFirstAvailable()).drop(170, 0, currentDirection);
			}
			else {
				trace("whoops");
			}
		}
		
		public function bulletHitZombie(bullet:FlxObject, zombie:FlxObject):void 
		{
			bullet.kill();
			
			zombie.kill();
			trace(zombie.x, zombie.y);
			Registry.fx.explodeBlock(zombie.x, zombie.y);
		}
	}
}