package
{
	/*
	 * The meat and potatoes of the game
	 * 
	 * Just because this is where all of the initializaitons are for the game, most of the logic
	 * should be kept with the item itself. This will keep this file manageable and will allow
	 * coders to understand what an object does without having to jump between sources.
	 * */
	import org.flixel.*;
	import player.*;
	import fx.*;
	import zombies.*;
	import levels.*;
	import Logger;
	import org.flixel.plugin.photonstorm.API.FlxKongregate;
	
	public class PlayState extends FlxState
	{	
		[Embed(source = '../assets/cursor.png')] private var cursorPNG:Class;
		[Embed(source = "../assets/sounds/ZombiesGameLoop.mp3")] public var MusicMode:Class;
		
		//Simple text overlay... Will be replaced by a traditional GUI overlay later on
		private var userInterface:UserInterface;
		//public var soundButton:FlxButton;
		//public var soundOn:FlxText = new FlxText(20, 0, 400, "Sound: On");
		//public var soundOff:FlxText = new FlxText(20, 0, 400, "Sound: Off");
		
		//A timer to output a zombie into the map every few seconds
		private var zombieTimer: FlxTimer;
		
		private var introTimer: FlxTimer;
		private var introCount:int;
		
		//Used to lighten the darkness at the end of the game
		private var gameIsOver:Boolean = false;
		
		private var survive:FlxText;
		
		public function PlayState() 
		{
			super();
		}
		
		//This function is ran at the beginning of the game to create the assets of the game
		override public function create():void
		{
			super.create();
			
			Registry.musicIsOn = false;
			if(Registry.options.sound)
				FlxG.playMusic(MusicMode);
			
			FlxKongregate.init(apiHasLoaded);
			
			FlxG.mouse.load(cursorPNG, 1, 8, 8);
			
			//Creating the Darkness overlay
			Registry.darkness = new Darkness();
			
			//Initialize the Logger
			Registry.logger = new Logger;
			//Entry in the logger for a new run, to distinguish between executions
			Registry.logger.Log("new run", "New Game Execution", "none", "new launch");
		
			//Holds the layers of the level of the game
			Registry.level1 = new Level1;
			add(Registry.level1);
			
			//Holds all of the explosions in the game
			Registry.explosions = new ExplosionManager;
			add(Registry.explosions);
			
			//Holds all the blood emitters of the game
			Registry.splatters = new SplatterManager;
			add(Registry.splatters);
			
			//Holds all the zombies of the game
			Registry.zombies = new ZombieManager;
			add(Registry.zombies);
			
			//The user controlled player of the game
			Registry.player = new PlayerManager;
			add(Registry.player);
			
			//Supply manager handles adding supplies and checking collisions
			Registry.supplies = new SupplyManager;
			add(Registry.supplies);
			
			Registry.utilities = new UtilityManager;
			add(Registry.utilities);
			
			//Spits out the zombies
			zombieTimer = new FlxTimer();
			zombieTimer.start(2, 0, Registry.zombies.drop);
			
			//----*IMPORTANT*----
			//The darkness is created before the light, but added after the light... Don't mess with it
			add(Registry.darkness);		//Commenting out this line will remove the darkness
			
			survive = new FlxText(0, 0, FlxG.width, "Survive!");
			survive.size = 32;
			survive.y = FlxG.height / 2 - survive.height / 2;
			survive.alignment = "center";
			add(survive);
			
			//----*IMPORTANT*----
			//Add anything after darkness that you dont want to get darkened
			
			//This is no longer needed... The issue with the sound not being able to be toggled in the MenuState has been fixed
			/*
			//button to run sound on/off
			soundButton = new FlxButton(300, 280, "Sound", switchSound);
			soundButton.color = 0x00FF00
			add(soundButton);
			*/
			
			Registry.player.exists = false;
			
			introTimer = new FlxTimer();
			introTimer.start(0.1, 13, darken);
			introCount = 0;
			
			//Logging is not checked for this so that we can see if anyone tried our game
			Registry.logger.Log("Game Started", "Logging: "+Registry.options.loggingString(), "Sound: "+Registry.options.soundString(), "Player has started a game!");
		}
		
		public function createEverythingElse():void 
		{
			Registry.player.exists = true;
			Registry.player.flashlight.batteryLife = 12;
			
			userInterface = new UserInterface;
			add(userInterface);
			
			FlxG.log("Game Started");
			
			survive.exists = false;
			
			userInterface.create();
		}
		
		//This is no longer needed... The issue with the sound not being able to be toggled in the MenuState has been fixed
		/*
		public function switchSound():void
		{
			//Registry.logger.Log("sound button", "pressed", "none", "the button to switch sound has been pressed " + String(Registry.sound.sound));
			Registry.sound.soundSwitch();
			Registry.logger.Log("sound button", "processed", "none", "sound is now " + String(Registry.sound.sound));
			
			if (Registry.sound.sound) {
				soundButton.color = 0x00FF00;
			}
			
			else{
				soundButton.color = 0xFF0000;
			}
			
		}
		*/
		
		override public function update():void
		{
			super.update();
			
			//Collisions with the map
			FlxG.collide(Registry.player.sprite, Registry.level1.midground);
			FlxG.collide(Registry.zombies, Registry.level1.midground);
			FlxG.collide(Registry.splatters, Registry.level1.midground);
			FlxG.collide(Registry.explosions, Registry.level1.midground);
			FlxG.collide(Registry.utilities, Registry.level1.midground);
			
			FlxG.collide(Registry.player.pistol.group, Registry.level1.midground, Registry.player.pistol.bulletHit);
			FlxG.collide(Registry.player.rocket.group, Registry.level1.midground, Registry.player.rocket.bulletHit);
			FlxG.collide(Registry.player.uzi.group, Registry.level1.midground, Registry.player.uzi.bulletHit);
			FlxG.collide(Registry.player.rifle.group, Registry.level1.midground, Registry.player.rifle.bulletHit);
			
			//If bullet hits zombie call function
			FlxG.overlap(Registry.player.pistol.group, Registry.zombies, Registry.player.pistol.bulletHit);
			FlxG.overlap(Registry.player.rocket.group, Registry.zombies, Registry.player.rocket.bulletHit);
			FlxG.overlap(Registry.player.uzi.group, Registry.zombies, Registry.player.uzi.bulletHit);
			FlxG.overlap(Registry.player.rifle.group, Registry.zombies, Registry.player.rifle.bulletHit);
			
			//If Particle from explosion hits zombie
			FlxG.overlap(Registry.zombies, Registry.explosions, Registry.zombies.explosionHitZombie);
			
			//If zombie hits player its game over
			FlxG.overlap(Registry.player.sprite, Registry.zombies, gameOver);
			
			if (Registry.player.sprite.y > FlxG.height && gameIsOver == false)
				gameOver(Registry.player.sprite, new Zombie);
		}
		
		//Override the draw function to fill the screen with the darkness
		override public function draw():void {
			/*if(gameIsOver == false)
				Registry.darkness.fill(0xff000000);
			else
				Registry.darkness.fill(0xff777777);*/
			//This is the fade in the darkness routine that happens at the beginning of the game
			if (gameIsOver == false)
			{
				switch (introCount) 
				{
					case 0:
						Registry.darkness.fill(0xffaaaaaa);
						break;
					case 1:
						Registry.darkness.fill(0xff999999);
						break;
					case 2:
						Registry.darkness.fill(0xff888888);
						break;
					case 3:
						Registry.darkness.fill(0xff777777);
						break;
					case 4:
						Registry.darkness.fill(0xff666666);
						break;
					case 5:
						Registry.darkness.fill(0xff555555);
						break;
					case 6:
						Registry.darkness.fill(0xff444444);
						break;
					case 7:
						Registry.darkness.fill(0xff333333);
						break;
					case 8:
						Registry.darkness.fill(0xff222222);
						break;
					case 9:
						Registry.darkness.fill(0xff111111);
						break;
					case 10:
						Registry.darkness.fill(0xff000000);
						break;
					case 12:
						if(Registry.player.exists == false)
							createEverythingElse();
						Registry.darkness.fill(0xff000000);
						break;
					case 13:
						Registry.darkness.fill(0xff000000);
						break;
					default:
				}
			}
			else
				Registry.darkness.fill(0xff777777);
			super.draw();
		}
		
		//This handles the fading in of the darkness for the game
		public function darken(time:FlxTimer):void 
		{
			introCount++;
		}
		
				
		private function apiHasLoaded():void 
		{
			FlxKongregate.connect();
			FlxG.log("connected to Kongregate");
			FlxG.log(FlxKongregate.isLocal);
		}
		
		//The current ending to the game. 
		private function gameOver(player:FlxObject, zombie:FlxObject):void 
		{
			FlxKongregate.submitStats("score", Registry.score);
			if(Registry.options.logging)
				Registry.logger.Log("Player killed", "Game Over", "None", "Player has been killed by a zombie. Score: "+Registry.score);
			Registry.splatters.playerDeath(Registry.player.sprite.x, Registry.player.sprite.y);
			Registry.player.kill();
			gameIsOver = true;
			var gameOverMenu:GameOverMenu = new GameOverMenu();
			add(gameOverMenu);
		}
	}
}