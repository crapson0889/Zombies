package player 
{
	/*
	 * Slow firing high powered semi-automatic
	 * */
	
	import zombies.Zombie;
	
	public class PlayerWeaponRifle extends PlayerWeapon
	{
		
		public function PlayerWeaponRifle(name:String) 
		{
			super(name);
			
			automatic = false;
			setFireRate(1000);
			damage = 10;
		}
		
		public override function bulletHit(bullet:FlxObject, object:FlxObject):void
		{
			if (object is Zombie)
			{
				object.health -= damage;
				
				Registry.splatters.spurt(zombie.x, zombie.y, new FlxPoint(bullet.x, bullet.y), new FlxPoint(Registry.player.sprite.x, Registry.player.sprite.y));
				Registry.explosions.explode(zombie.x, zombie.y, new FlxPoint(bullet.x, bullet.y), new FlxPoint(Registry.player.sprite.x, Registry.player.sprite.y));
				
				if (zombie.health == 0)
				{
					Registry.splatters.explode(zombie.x, zombie.y, new FlxPoint(bullet.x, bullet.y), new FlxPoint(Registry.player.sprite.x, Registry.player.sprite.y));
					zombie.exists = false;
				}
			}
			else if(bullet is Bullet)
				bullet.kill();
		}
		
	}

}