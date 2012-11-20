package player 
{
	//Commented out unneeded imports
	//import org.flixel.FlxEmitter;
	//import org.flixel.FlxParticle;
	//import org.flixel.FlxSprite;
	//import org.flixel.plugin.photonstorm.FlxWeapon;
	import org.flixel.plugin.photonstorm.BaseTypes.Bullet;
	import org.flixel.FlxObject;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	//import fx.*;
	
	public class PlayerWeaponRocket extends PlayerWeapon
	{
		//Needs new bullet image. This is not being used at the moment
		//[Embed(source = '../../assets/bullet.png')] private var bulletPNG:Class;
		
		//Sound Needed in this class: exploding rocket
		[Embed(source = '../../assets/sounds/explosion1.mp3')] private var explosionSND:Class;
		
		public function PlayerWeaponRocket(name:String) 
		{
			super(name);
			
			automatic = false;
			damage = 30;
			setFireRate(2000);
			ammo = 4;
		}
		
		public override function bulletHit(bullet:FlxObject, object:FlxObject):void
		{
			if (bullet is Bullet)
			{
				Registry.explosions.explode(bullet.x, bullet.y, new FlxPoint(bullet.x, bullet.y), new FlxPoint(Registry.player.sprite.x, Registry.player.sprite.y));
				FlxG.play(explosionSND);
				
				Registry.logger.Log("rocketHit", "RocketHitsZombie", "none", "a rocket has hit a zombie");
			}
			
			super.bulletHit(bullet, object);
		}
		
	}

}