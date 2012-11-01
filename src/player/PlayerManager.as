package player 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;

	public class PlayerManager extends FlxGroup
	{
		[Embed(source = '../../assets/bullet.png')] private var bulletPNG:Class;
		
		public var sprite:PlayerSprite;
		public var gun:FlxWeapon;
		
		public function PlayerManager() 
		{	
			sprite = new PlayerSprite(FlxG.width / 2, FlxG.height / 2 - 20);
			
			gun = new FlxWeapon("gun", sprite, "x", "y");
			gun.makeImageBullet(50, bulletPNG, 0);
			gun.setBulletDirection(FlxWeapon.BULLET_RIGHT, 200);
			add(gun.group);
			
			add(sprite);
			
			//	Enable the Controls plugin - you only need do this once (unless you destroy the plugin)
			if (FlxG.getPlugin(FlxControl) == null)
			{
				FlxG.addPlugin(new FlxControl);
			}
			
			//	Add this sprite to the FlxControl plugin and tell it we want the sprite to accelerate and decelerate smoothly
			FlxControl.create(sprite, FlxControlHandler.MOVEMENT_ACCELERATES, FlxControlHandler.STOPPING_DECELERATES, 1, true, false);
			
			//	Sprite will be controlled with the left and right cursor keys
			FlxControl.player1.setWASDControl(false, false, true, true);
			
			//	And SPACE BAR will make them jump up to a maximum of 200 pixels (per second), only when touching the FLOOR
			FlxControl.player1.setJumpButton("SPACE", FlxControlHandler.KEYMODE_PRESSED, 200, FlxObject.FLOOR, 250, 200);
			
			FlxControl.player1.setFireButton("CONTROL", FlxControlHandler.KEYMODE_JUST_DOWN, 150, gun.fire);
			
			//	Stop the player running off the edge of the screen and falling into nothing
			//FlxControl.player1.setBounds(16, 0, 288, 240);
			
			//	Because we are using the MOVEMENT_ACCELERATES type the first value is the acceleration speed of the sprite
			//	Think of it as the time it takes to reach maximum velocity. A value of 100 means it would take 1 second. A value of 400 means it would take 0.25 of a second.
			FlxControl.player1.setMovementSpeed(400, 0, 100, 200, 400, 0);
			
			//	Set a downward gravity of 400px/sec
			FlxControl.player1.setGravity(0, 400);
		}
		
		override public function update():void 
		{
			super.update();
			
			if (sprite.facing == FlxObject.RIGHT)
			{
				gun.setBulletDirection(FlxWeapon.BULLET_RIGHT, 200);
			}
			else
			{
				gun.setBulletDirection(FlxWeapon.BULLET_LEFT, 200);
			}
		}
		
	}

}