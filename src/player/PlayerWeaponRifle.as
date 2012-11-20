package player 
{
	/*
	 * Slow firing high powered semi-automatic that has bullets that travel through the zombies
	 * */
	
	import zombies.Zombie;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxG;
	import org.flixel.plugin.photonstorm.BaseTypes.Bullet;
	
	public class PlayerWeaponRifle extends PlayerWeapon
	{
		
		public function PlayerWeaponRifle(name:String) 
		{
			super(name);
			
			automatic = false;
			setFireRate(1000); //Might need to mess with this value. The weapon feels fast for being a one hit kill on the zombies. 
			damage = 10;
			ammo = 10;
		}
		
		//We override this function so that the bullet doesn't disappear unless it hits a wall. This creates the cool effect of the bullet traveling through the zombie.
		public override function bulletHit(bullet:FlxObject, object:FlxObject):void
		{
			if (object is Zombie)
			{
				//Registry.logger.Log("rifleHit", "Rifle hit Zombie", "none", "a rifle shot has hit a zombie");
				
				object.health -= damage;
				
				Registry.splatters.spurt(object.x, object.y, new FlxPoint(bullet.x, bullet.y), new FlxPoint(Registry.player.sprite.x, Registry.player.sprite.y));
				
				if (object.health <= 0)
				{
					Registry.splatters.explode(object.x, object.y, new FlxPoint(bullet.x, bullet.y), new FlxPoint(Registry.player.sprite.x, Registry.player.sprite.y));
					object.exists = false;
					if (Registry.sound.sound)
						FlxG.play(super.zdeathSND);
					//Registry.logger.Log("deadZombie", "Zombie killed", "none", "a zombie has been killed by rifle");
				}
				else
				{
					if (Registry.sound.sound)
						FlxG.play(super.hitSND);				
				}
			}
			else if(bullet is Bullet)
				bullet.kill();
		}
		
	}

}