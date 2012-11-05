package player 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import fx.*;

	public class PlayerManager extends FlxGroup
	{
		
		public var sprite:PlayerSprite;
		//public var gun:PlayerWeapon;
		//public var gunSprite:GunSprite;
		public var gun:GunManager;
		
		//Various lighting effects
		private var playerLight:PlayerLight;
		public var flashlight:Flashlight;
		public var flash:Flash;
		
		public function PlayerManager() 
		{	
			sprite = new PlayerSprite(FlxG.width / 2, FlxG.height / 2 - 20);
			
			gun = new PlayerWeapon("gun");
			add(gun.group);
			
			gunSprite = new GunSprite(sprite.x, sprite.y);
			add(gunSprite);
			
			//gun = new GunManager();
			
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
			
			//FlxControl.player1.setFireButton("CONTROL", FlxControlHandler.KEYMODE_JUST_DOWN, 150, gun.fire);
			
			//	Stop the player running off the edge of the screen and falling into nothing
			//FlxControl.player1.setBounds(16, 0, 288, 240);
			
			//	Because we are using the MOVEMENT_ACCELERATES type the first value is the acceleration speed of the sprite
			//	Think of it as the time it takes to reach maximum velocity. A value of 100 means it would take 1 second. A value of 400 means it would take 0.25 of a second.
			FlxControl.player1.setMovementSpeed(1000, 0, 100, 200, 1000, 0);
			
			//	Set a downward gravity of 400px/sec
			FlxControl.player1.setGravity(0, 400);
			
			//The light immediately around the player
			playerLight = new PlayerLight(sprite.x, sprite.y, Registry.darkness);
			add(playerLight);
			
			//The flashlight emitting from the player
			flashlight = new Flashlight(sprite.x, sprite.y, Registry.darkness);
			flashlight.origin = new FlxPoint(0, 0);
			add(flashlight);
			
			flash = new Flash(sprite.x, sprite.y, Registry.darkness);
			add(flash);
		}
		
		override public function update():void 
		{
			super.update();
			
			//For whatever reason the game didn't like these functions in their actual class... whatever
			gun.setFiringPosition(sprite.x, sprite.y, 6, 6);
			
			if (FlxG.mouse.justPressed())
			{
				gun.fireAtMouse();
				gunSprite.play("fire");
				flash.play("flash");
			}
		}
		
	}

}