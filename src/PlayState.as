package
{
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{	
		private var supply:Supply;
		
		private var debug:FlxText;
		
		//Programatically added platforms - these will be removed when map is created
		private var floor:FlxTileblock;
		private var leftPlatform: FlxTileblock;
		private var rightPlatform: FlxTileblock;
		private var middlePlatform: FlxTileblock;
		
		private var zombieTimer: FlxTimer;
		
		//Darkness overlay and lighting immediately around the Player
		private var darkness:FlxSprite;
		private var light:Light;
		private var flashlight:Light;
		
		[Embed(source = "/../assets/light.png")] private var LightImageClass:Class;
		[Embed(source = "/../assets/flashlight.png")] private var FlashlightImageClass:Class;
		
		public function PlayState() 
		{
		}
		
		override public function create():void
		{
			Registry.bullets = new BulletManager;
			Registry.zombies = new ZombieManager;
			Registry.splatters = new SplatterManager;
			Registry.level1 = new Level1;
			
			//Setting the Background Color
			FlxG.bgColor = 0xff444444;
			
			//Creating the Player and adding
			Registry.player = new Player(32, 170);
			
			//Add the Registry classes
			add(Registry.level1);
			add(Registry.bullets);
			add(Registry.player);
			add(Registry.zombies);
			add(Registry.splatters);
			
			//Spits out the zombies
			zombieTimer = new FlxTimer();
			zombieTimer.start(2, 0, Registry.zombies.drop);
			
			// Not used yet
			//supply = new Supply();
			//add(supply);
			
			//Creating the Darkness overlay
			darkness = new FlxSprite(0,0);
			darkness.makeGraphic(FlxG.width, FlxG.height, 0xff000000);
			darkness.scrollFactor.x = darkness.scrollFactor.y = 0;
			darkness.blend = "multiply";
			
			//Creating and adding the Lighting effect
			light = new Light(Registry.player.x, Registry.player.y, LightImageClass, darkness);
			add(light);
			
			flashlight = new Light(Registry.player.x, Registry.player.y, FlashlightImageClass, darkness);
			flashlight.turnable = true;
			add(flashlight);
			
			//Adding the Darkness
			//Important that the Darkness is created before the light, but added after the light... Don't mess with it
			//add(darkness);		//Commenting out this line will remove the darkness
			
			//Add anything after darkness that you dont want to get darkened
			debug = new FlxText(0, 0, 200, "");
			add(debug);
		}
		
		override public function update():void
		{
			super.update();
			
			debug.text = "Splatter Pool: " + Registry.splatters.countLiving() + "/" + Registry.zombies.maxSize;
			
			FlxG.collide(Registry.player, Registry.level1.midground);

			FlxG.collide(Registry.zombies, Registry.level1.midground);

			FlxG.collide(Registry.splatters, Registry.level1.midground);
			    
			FlxG.overlap(Registry.zombies, Registry.bullets, Registry.zombies.bulletHitZombie);
			
			FlxG.overlap(Registry.player, Registry.zombies, turnOnLights);
			FlxG.overlap(Registry.player, Registry.zombies, Registry.player.zombieHitPlayer);
			
			FlxG.overlap(Registry.player, supply, hitSupply);
			
			//FlxG.overlap(Registry.bullets, Registry.level1.midground, Registry.bullets.bulletHitTile);
			//FlxG.collide(Registry.bullets, Registry.level1.midground);
			
			//Keep the light on the Player
			light.x = Registry.player.x + 5;
			light.y = Registry.player.y + 5;
		}
		
		override public function draw():void {
			darkness.fill(0xff000000);
			//darkness.fill(0xff222222);
			super.draw();
		}
		
		private function hitSupply(player:FlxObject, supply:FlxObject):void 
		{
			supply.kill();
		}
		
		private function turnOnLights(player:FlxObject, zombie:FlxObject):void 
		{
			darkness.kill();
		}
	}

}