package player 
{
	/*
	 * Slow firing high powered semi-automatic
	 * */
	
	import zombies.Zombie;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.plugin.photonstorm.BaseTypes.Bullet;
	
	public class PlayerWeaponRifle extends PlayerWeapon
	{
		
		public function PlayerWeaponRifle(name:String) 
		{
			super(name);
			
			automatic = false;
			setFireRate(1000);
			damage = 10;
			ammo = 10;
		}
		
		public override function bulletHit(bullet:FlxObject, object:FlxObject):void
		{
			if (object is Zombie)
			{
				object.health -= damage;
				
				Registry.splatters.spurt(object.x, object.y, new FlxPoint(bullet.x, bullet.y), new FlxPoint(Registry.player.sprite.x, Registry.player.sprite.y));
				
				if (object.health <= 0)
				{
					Registry.splatters.explode(object.x, object.y, new FlxPoint(bullet.x, bullet.y), new FlxPoint(Registry.player.sprite.x, Registry.player.sprite.y));
					object.exists = false;
				}
			}
			else if(bullet is Bullet)
				bullet.kill();
		}
		
	}

}