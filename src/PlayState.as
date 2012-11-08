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
		
		//A timer to output a zombie into the map every few seconds
		private var zombieTimer: FlxTimer;
		
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
			
			//Holds all the bullets of the game
			//Registry.bullets = new BulletManager;
			//add(Registry.bullets);
			
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
			add(Registry.darkness);		//Commenting out this line will remove the darkness
			
			//----*IMPORTANT*----
			//Add anything after darkness that you dont want to get darkened
			debug = new FlxText(0, 0, 200, "");
			add(debug);
			battery = new FlxText(0, 16, 200, "");
			add(battery);
		}
		
		override public function update():void
		{
			super.update();
			
			debug.text = "Score: " + Registry.score;
			battery.text = "Battery: " + Registry.player.flashlight.batteryLife;
			
			//Collisions with the map
			FlxG.collide(Registry.player.sprite, Registry.level1.midground);
			FlxG.collide(Registry.zombies, Registry.level1.midground);
			FlxG.collide(Registry.splatters, Registry.level1.midground);
			
			FlxG.collide(Registry.player.gun.group, Registry.level1.midground, Registry.player.gun.destroyBullet);

			//If bullet hits zombie call function
			FlxG.overlap(Registry.zombies, Registry.player.gun.group, Registry.zombies.bulletHitZombie);
			
			//If Particle from explosion hits zombie
			FlxG.overlap(Registry.zombies, Registry.explosions, Registry.zombies.explosionHitZombie);
			
			//If zombie hits player its game over
			FlxG.overlap(Registry.player.sprite, Registry.zombies, gameOver);
			
			if (Registry.player.sprite.y > FlxG.height && gameIsOver == false)
				gameOver(Registry.player.sprite, new Zombie);
		}
		
		//Override the draw function to fill the screen with the darkness
		override public function draw():void {
			if(gameIsOver == false)
				Registry.darkness.fill(0xff000000);
			else
				Registry.darkness.fill(0xff777777);
			super.draw();
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