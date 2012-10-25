package zombies
{
	/*
	 * 	The handler for all the Zombies in the game
	 * */
	import org.flixel.*;
	import weapons.Bullet;
	
	public class ZombieManager extends FlxGroup
	{
		public var currentDirection:int;
		
		public function ZombieManager() 
		{
			super();
			maxSize = Registry.zombieCount;
			
			currentDirection = 1;
			
			for (var j:int = 0; j < Registry.zombieCount; j++)
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
		}
		
		public function bulletHitZombie(zombie:Zombie, bullet:Bullet):void 
		{
			bullet.exists = false;

			zombie.health--;
			Registry.splatters.spurt(bullet.x, bullet.y, bullet.direction);
			
			if (zombie.health == 0)
			{
				Registry.splatters.explode(zombie.x, zombie.y, bullet.direction);
				zombie.exists = false;
			}
		}
	}
}