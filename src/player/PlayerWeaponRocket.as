package player 
{
	import org.flixel.FlxEmitter;
	import org.flixel.FlxParticle;
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.FlxWeapon;
	import org.flixel.plugin.photonstorm.BaseTypes.Bullet;
	import org.flixel.FlxObject;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import fx.*;
	
	public class PlayerWeapon extends FlxWeapon
	{
		[Embed(source = '../../assets/bullet.png')] private var bulletPNG:Class;
		
		public function PlayerWeapon(name:String) 
		{
			super(name);
			makeImageBullet(50, bulletPNG, 0);
			setBulletSpeed(200);
			trace(FlxG.worldBounds.height, FlxG.worldBounds.width);
			setBulletBounds(FlxG.worldBounds);
			
			
			
		}
		
		public function destroyBullet(bullet:FlxObject, level:FlxObject):void
		{
			
			if (bullet is Bullet)
			{
				bullet.kill();
				
				Registry.explosions.explode(bullet.x, bullet.y, new FlxPoint(bullet.x, bullet.y), new FlxPoint(Registry.player.sprite.x, Registry.player.sprite.y));
				
			}
		}
		
	}

}