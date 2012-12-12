package zombies
{
	/*
	 * 	The handler for all the Zombies in the game
	 * */
	import org.flixel.*;
	
	public class ZombieManager extends FlxGroup
	{
		//Sound needed in this class: Zombie Death noise (for death from explosion splash damage).
		[Embed(source = '../../assets/sounds/zombiedies.mp3')] protected var zdeathSND:Class;
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
				Zombie(getFirstAvailable()).drop(location, 0, currentDirection, Math.floor(Math.random()*3));
			}
			if(Registry.options.logging)
				Registry.logger.Log("New Zombie", String(location), "None", "a new zombie has dropped");
		}
		
		public function explosionHitZombie(zombie:Zombie, bullet:FlxObject):void
		{
			bullet.exists = false;
			zombie.health-=1;
			
			if (zombie.health <= 0)
			{
				Registry.splatters.explode(zombie.x, zombie.y, new FlxPoint(bullet.x, bullet.y), new FlxPoint(Registry.player.sprite.x, Registry.player.sprite.y));
				zombie.exists = false;
				if (Registry.options.sound)
					FlxG.play(zdeathSND);
				if(Registry.options.logging)
					Registry.logger.Log("Dead Zombie", "rocket", "None", "Zombie killed by shrapnel");
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