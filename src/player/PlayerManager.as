package player 
{
	/*
	 * This Class should handle all of the basic functions and variables pertaining to the Player
	 * */
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import fx.*;

	public class PlayerManager extends FlxGroup
	{
		//Sounds needed in this class: Player Death, Weapon fire, Jump
		[Embed(source = '../../assets/sounds/playerdeath.mp3')] private var playerdeathSND:Class;
		[Embed(source = '../../assets/sounds/gunshot1.mp3')] private var gunSND:Class;
		[Embed(source = '../../assets/sounds/gunshot2.mp3')] private var rifleSND:Class;
		[Embed(source = '../../assets/sounds/rocketlaunch.mp3')] private var rocketSND:Class;
		[Embed(source = '../../assets/sounds/jump.mp3')] private var jumpSND:Class;

		
		public var sprite:PlayerSprite;
		
		public var pistol:PlayerWeapon;
		public var rocket:PlayerWeaponRocket;
		public var uzi:PlayerWeaponUzi;
		public var rifle:PlayerWeaponRifle;
		
		public var ammo:int;
		
		public var gunSprite:GunSprite;
		public var rocketLauncherSprite:RocketLauncherSprite;
		public var uziSprite:UziSprite;
		public var rifleSprite:RifleSprite;
		
		public var currentGun:int;
		
		//Various lighting effects
		private var playerLight:PlayerLight;
		public var flashlight:Flashlight;
		public var flash:Flash;
		
		public function PlayerManager() 
		{	
			sprite = new PlayerSprite(FlxG.width / 2, FlxG.height / 2 - 20);
			
			//Add all the guns *Insert meme here*!
			currentGun = 1;
			ammo = 0;
			pistol = new PlayerWeapon("Pistol");
			add(pistol.group);
			rocket = new PlayerWeaponRocket("Rocket");
			add(rocket.group);
			uzi = new PlayerWeaponUzi("Uzi");
			add(uzi.group);
			rifle = new PlayerWeaponRifle("Rifle");
			add(rifle.group);
			
			gunSprite = new GunSprite(sprite.x, sprite.y);
			add(gunSprite);
			
			rocketLauncherSprite = new RocketLauncherSprite(sprite.x, sprite.y);
			add(rocketLauncherSprite);
			rocketLauncherSprite.exists = false;
			
			uziSprite = new UziSprite(sprite.x, sprite.y);
			add(uziSprite);
			uziSprite.exists = false;
			
			rifleSprite = new RifleSprite(sprite.x, sprite.y);
			add(rifleSprite);
			rifleSprite.exists = false;
			
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
			gun().setFiringPosition(sprite.x, sprite.y, 6, 6);
			
			//Tests to see if the weapon is automatic, calls mouse handlers accordingly then fires if mouse is pressed
			if (gun().automatic)
			{
				if (FlxG.mouse.pressed())
				{
					if (gun().fireAtMouse())
					{
						gunSprite.play("fire");
						flash.play("flash");
						ammo--;
						if (Registry.options.sound)
							FlxG.play(gunSND); 
					}
				}
			}
			else 
			{
				if (FlxG.mouse.justPressed())
				{
					if (gun().fireAtMouse())
					{
						gunSprite.play("fire");
						flash.play("flash");
						ammo--;
						
						//Play appropriate firing sound based on weapon type
						switch (gun()) 
						{
							case rocket:
								if (Registry.options.sound)
									FlxG.play(rocketSND);
								break;
							case rifle:
								if (Registry.options.sound)	
									FlxG.play(rifleSND);
								break;
							default:
								if (Registry.options.sound)
									FlxG.play(gunSND);
						}
					}
				}
			}
			
			if (ammo <= 0)
			{
				ammo = 0;
				currentGun = 1;
				
				rocketLauncherSprite.exists = false;
				uziSprite.exists = false;
				rifleSprite.exists = false;
				
				gunSprite.exists = true;
			}
			
			//This section needs will be replaced by a function that selects a weapon at random when a supply package has a weapon
			//		It will be removed when that is added
			//		New function will need to handle the gunSprite as well
			/*if (FlxG.keys.justPressed("H"))
			{
				if (currentGun == 4)
					currentGun = 0;
				currentGun++;
			}*/
			
			if (FlxG.keys.justPressed("SPACE"))
				if (Registry.options.sound)
					FlxG.play(jumpSND);
		}
		
		//Return the current gun
		public function gun():PlayerWeapon
		{
			switch (currentGun) 
			{
				case 1:
					return pistol;
				case 2:
					return rocket;
				case 3:
					return uzi;
				case 4:
					return rifle;
				default:
					return pistol;
			}
		}
		
		override public function kill():void 
		{
			if (Registry.options.sound)
				FlxG.play(playerdeathSND);
			super.kill();
		}
		
		public function newRandomWeapon():void
		{
			gunSprite.exists = false;
			rocketLauncherSprite.exists = false;
			uziSprite.exists = false;
			rifleSprite.exists = false;
			
			currentGun = Math.floor(Math.random() * 3) + 2;
			
			switch (currentGun) 
			{
				case 1:
					gunSprite.exists = true;
					break;
				case 2:
					rocketLauncherSprite.exists = true;
					break;
				case 3:
					uziSprite.exists = true;
					break;
				case 4:
					rifleSprite.exists = true;
					break;
				default:
					gunSprite.exists = true;
					break;
			}
			
			ammo = gun().ammo;
		}
		
	}

}