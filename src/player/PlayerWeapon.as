package player 
{
	import org.flixel.plugin.photonstorm.FlxWeapon;
	import org.flixel.plugin.photonstorm.BaseTypes.Bullet;
	import org.flixel.FlxObject;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import zombies.Zombie;
	
	public class PlayerWeapon extends FlxWeapon
	{
		[Embed(source = '../../assets/bullet.png')] private var bulletPNG:Class;
		
		//Sounds needed in this class: bullet hits zombie, Zombie Death noise
		[Embed(source = '../../assets/sounds/bullethit.mp3')] protected var hitSND:Class;
		[Embed(source = '../../assets/sounds/zombiedies.mp3')] protected var zdeathSND:Class;
		
		//This is still being tested
		public var automatic:Boolean = false;
		public var damage:uint = 5;
		public var ammo:uint = 0;
		
		public function PlayerWeapon(name:String) 
		{
			//As of right now the name means nothing. But FlxWeapon requires it, so we still have it.
			super(name);
			
			automatic = false;
			//If the weapon is automatic, you will want to change the fire rate
			//setFireRate(200);
			makeImageBullet(100, bulletPNG, 0);
			setBulletSpeed(200);
			trace(FlxG.worldBounds.height, FlxG.worldBounds.width);
			setBulletBounds(FlxG.worldBounds);
		}
		
		public function bulletHit(bullet:FlxObject, object:FlxObject):void
		{
			if (object is Zombie)
			{
				
				
				object.health -= damage;
				
				Registry.splatters.spurt(object.x, object.y, new FlxPoint(bullet.x, bullet.y), new FlxPoint(Registry.player.sprite.x, Registry.player.sprite.y));
				//This needs to be moved to PlayerWeaponRocket
				//Registry.explosions.explode(object.x, object.y, new FlxPoint(bullet.x, bullet.y), new FlxPoint(Registry.player.sprite.x, Registry.player.sprite.y));
				
				if (object.health <= 0)
				{
					Registry.splatters.explode(object.x, object.y, new FlxPoint(bullet.x, bullet.y), new FlxPoint(Registry.player.sprite.x, Registry.player.sprite.y));
					object.exists = false;
					if (Registry.sound.sound)
					{
						FlxG.play(zdeathSND);
					}
					//Registry.logger.Log("deadZombie", "Zombie killed", "none", "a zombie has been killed by pistol or uzi");
				}
				else
				{
					if (Registry.sound.sound)
						FlxG.play(hitSND);
				}
				
				
			}
			if(bullet is Bullet)
				bullet.exists = false;
		}
		
	}

}