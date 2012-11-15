package zombies
{
	/*
	 * 	The handler for all the Zombies in the game
	 * */
	import org.flixel.*;
	
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
				var rand:uint = Math.floor(Math.random() * 3);
				var location:uint = 0;
				switch (rand) 
				{
					case 0:
						location = 88;
						break;
					
					case 1:
						location = 192;
						break;
					
					case 2:
						location = 296;
						break;
					
					default:
				}
				Zombie(getFirstAvailable()).drop(location, 0, currentDirection);
			}
		}
		
		public function explosionHitZombie(zombie:Zombie, bullet:FlxObject):void
		{
			bullet.exists = false;
			zombie.health-=1;
			
			if (zombie.health <= 0)
			{
				Registry.splatters.explode(zombie.x, zombie.y, new FlxPoint(bullet.x, bullet.y), new FlxPoint(Registry.player.sprite.x, Registry.player.sprite.y));
				zombie.exists = false;
			}
			
		}
		/*
		public function bulletHitZombie(zombie:Zombie, bullet:FlxObject):void 
		{
			bullet.exists = false;

			zombie.health-=Registry.player.gun().damage;
			Registry.splatters.spurt(zombie.x, zombie.y, new FlxPoint(bullet.x, bullet.y), new FlxPoint(Registry.player.sprite.x, Registry.player.sprite.y));
			//This needs to be moved to PlayerWeaponRocket
			//Registry.explosions.explode(zombie.x, zombie.y, new FlxPoint(bullet.x, bullet.y), new FlxPoint(Registry.player.sprite.x, Registry.player.sprite.y));
			if (zombie.health == 0)
			{
				Registry.splatters.explode(zombie.x, zombie.y, new FlxPoint(bullet.x, bullet.y), new FlxPoint(Registry.player.sprite.x, Registry.player.sprite.y));
				zombie.exists = false;
			}
		}
		*/
	}
}