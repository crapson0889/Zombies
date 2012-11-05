package player 
{
	import org.flixel.plugin.photonstorm.FlxWeapon;
	import org.flixel.plugin.photonstorm.BaseTypes.Bullet;
	import org.flixel.FlxObject;
	import org.flixel.FlxG;
	
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
			if(bullet is Bullet)
				bullet.kill();
		}
		
	}

}