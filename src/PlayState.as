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
	
	public class PlayState extends FlxState
	{	
		[Embed(source = '../assets/cursor.png')] private var cursorPNG:Class;
		
		//Simple text overlay... Will be replaced by a traditional GUI overlay later on
		private var debug:FlxText;
		private var battery:FlxText;
		private var weapon:FlxText;
		private var ammo:FlxText;
		
		//A timer to output a zombie into the map every few seconds
		private var zombieTimer: FlxTimer;
		
		private var introTimer: FlxTimer;
		private var introCount:int;
		
		//Used to lighten the darkness at the end of the game
		private var gameIsOver:Boolean = false;
		
		public function PlayState() 
		{
			super();
		}
		
		//This function is ran at the beginning of the game to create the assets of the game
		override public function create():void
		{
			super.create();
			
			FlxG.mouse.load(cursorPNG, 1, 8, 8);
			
			//Creating the Darkness overlay
			Registry.darkness = new Darkness();
			
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
			Registry.supplyManager = new SupplyManager;
			add(Registry.supplyManager);
			
			//Spits out the zombies
			zombieTimer = new FlxTimer();
			zombieTimer.start(2, 0, Registry.zombies.drop);
			
			//----*IMPORTANT*----
			//The darkness is created before the light, but added after the light... Don't mess with it
			//add(Registry.darkness);		//Commenting out this line will remove the darkness
			
			//----*IMPORTANT*----
			//Add anything after darkness that you dont want to get darkened
			debug = new FlxText(0, 0, 200, "");
			add(debug);
			battery = new FlxText(0, 16, 200, "");
			add(battery);
			weapon = new FlxText(0, 32, 200, "");
			add(weapon);
			ammo = new FlxText(0, 48, 200, "");
			add(ammo);
			
			Registry.player.exists = false;
			
			introTimer = new FlxTimer();
			introTimer.start(0.25, 13, darken);
			introCount = 0;
		}
		
		public function createEverythingElse():void 
		{
			Registry.player.exists = true;
			Registry.player.flashlight.batteryLife = 10;
		}
		
		override public function update():void
		{
			super.update();
			
			debug.text = "Score: " + Registry.score;
			battery.text = "Battery: " + Registry.player.flashlight.batteryLife;
			weapon.text = "Weapon: " + Registry.player.gun().name;
			ammo.text = "Ammo: " + Registry.player.ammo;
			
			//Collisions with the map
			FlxG.collide(Registry.player.sprite, Registry.level1.midground);
			FlxG.collide(Registry.zombies, Registry.level1.midground);
			FlxG.collide(Registry.splatters, Registry.level1.midground);
			FlxG.collide(Registry.explosions, Registry.level1.midground);
			
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
		
		public function darken(time:FlxTimer):void 
		{
			introCount++;
			trace(introCount);
		}
		
		//The current ending to the game. 
		private function gameOver(player:FlxObject, zombie:FlxObject):void 
		{
			Registry.splatters.playerDeath(Registry.player.sprite.x, Registry.player.sprite.y);
			Registry.player.kill();
			gameIsOver = true;
			var gameOverMenu:GameOverMenu = new GameOverMenu();
			add(gameOverMenu);
		}
	}
}