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
	import weapons.*;
	import fx.*;
	import zombies.*;
	import levels.*;
	
	public class PlayState extends FlxState
	{	
		//Simple text overlay... Will be replaced by a traditional GUI overlay later on
		private var debug:FlxText;
		
		//A timer to output a zombie into the map every few seconds
		private var zombieTimer: FlxTimer;
		
		//Darkness overlay and lighting immediately around the Player
		private var darkness:Darkness;
		private var light:PlayerLight;
		private var flashlight:Flashlight;
		
		public function PlayState() 
		{
			super();
		}
		
		//This function is ran at the beginning of the game to create the assets of the game
		override public function create():void
		{
			super.create();
			
			//Holds the layers of the level of the game
			Registry.level1 = new Level1;
			add(Registry.level1);
			
			//Holds all the bullets of the game
			Registry.bullets = new BulletManager;
			add(Registry.bullets);
			
			//Holds all the zombies of the game
			Registry.zombies = new ZombieManager;
			add(Registry.zombies);
			
			//Holds all the blood emitters of the game
			Registry.splatters = new SplatterManager;
			add(Registry.splatters);
			
			//The user controlled player of the game
			Registry.player = new Player;
			add(Registry.player);
			
			//Spits out the zombies
			zombieTimer = new FlxTimer();
			zombieTimer.start(2, 0, Registry.zombies.drop);
			
			//Creating the Darkness overlay
			darkness = new Darkness();
			
			//The light immediately around the player
			light = new PlayerLight(Registry.player.x, Registry.player.y, darkness);
			add(light);
			
			//The flashlight emitting from the player
			flashlight = new Flashlight(Registry.player.x, Registry.player.y, darkness);
			add(flashlight);
			
			//----*IMPORTANT*----
			//The darkness is created before the light, but added after the light... Don't mess with it
			add(darkness);		//Commenting out this line will remove the darkness
			
			//----*IMPORTANT*----
			//Add anything after darkness that you dont want to get darkened
			debug = new FlxText(0, 0, 200, "");
			add(debug);
		}
		
		override public function update():void
		{
			super.update();
			
			debug.text = "Splatter Pool: " + Registry.splatters.countLiving() + "/" + Registry.zombies.maxSize;
			
			//Collisions with the map
			FlxG.collide(Registry.player, Registry.level1.midground);
			FlxG.collide(Registry.zombies, Registry.level1.midground);
			FlxG.collide(Registry.splatters, Registry.level1.midground);
			
			//If bullet hits zombie call funciton
			FlxG.overlap(Registry.zombies, Registry.bullets, Registry.zombies.bulletHitZombie);
			
			//If zombie hits player its game over
			FlxG.overlap(Registry.player, Registry.zombies, gameOver);
		}
		
		//Override the draw function to fill the screen with the darkness
		override public function draw():void {
			darkness.fill(0xff000000);
			super.draw();
		}
		
		//The current ending to the game. 
		private function gameOver(player:FlxObject, zombie:FlxObject):void 
		{
			darkness.kill();
			Registry.splatters.playerDeath(Registry.player.x, Registry.player.y);
			Registry.player.kill();
		}
	}
}