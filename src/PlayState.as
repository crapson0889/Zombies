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
			
			//Setting the Background Color
			FlxG.bgColor = 0xff444444;
			
			//Creating the Player and adding
			Registry.player = new Player(32, 170);
			
			//Add the Registry classes
			add(Registry.player);
			add(Registry.bullets);
			add(Registry.zombies);
			add(Registry.splatters);
			
			//Spits out the zombies
			zombieTimer = new FlxTimer();
			zombieTimer.start(2, 0, Registry.zombies.drop);
			
			// Not used yet
			//supply = new Supply();
			//add(supply);
			
			//Creating platforms and adding them
			floor = new FlxTileblock(0, 240, 320, 16);
			floor.makeGraphic(340, 16, 0xffA63E00);
			
			leftPlatform = new FlxTileblock(0, 192, 96, 16);
			leftPlatform.makeGraphic(96, 16, 0xffA63E00);
			
			rightPlatform = new FlxTileblock(248, 192, 96, 16);
			rightPlatform.makeGraphic(96, 16, 0xffA63E00);
			
			middlePlatform = new FlxTileblock(96, 144, 152, 16);
			middlePlatform.makeGraphic(152, 16, 0xffA63E00);
			
			add(floor);
			add(leftPlatform);
			add(rightPlatform);
			add(middlePlatform);
			
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
			
			//If user collides with platform... collide
			FlxG.collide(Registry.player, floor);
			FlxG.collide(Registry.player, leftPlatform);
			FlxG.collide(Registry.player, rightPlatform);
			FlxG.collide(Registry.player, middlePlatform);
			
			FlxG.collide(Registry.zombies, floor);
			FlxG.collide(Registry.zombies, leftPlatform);
			FlxG.collide(Registry.zombies, rightPlatform);
			FlxG.collide(Registry.zombies, middlePlatform);
			
			FlxG.collide(Registry.splatters, floor);
			FlxG.collide(Registry.splatters, leftPlatform);
			FlxG.collide(Registry.splatters, rightPlatform);
			FlxG.collide(Registry.splatters, middlePlatform);
			    
			FlxG.overlap(Registry.zombies, Registry.bullets, Registry.zombies.bulletHitZombie);
			
			FlxG.overlap(Registry.player, Registry.zombies, turnOnLights);
			FlxG.overlap(Registry.player, Registry.zombies, Registry.player.zombieHitPlayer);
			
			FlxG.overlap(Registry.player, supply, hitSupply);
			
			FlxG.overlap(Registry.bullets, floor, Registry.bullets.bulletHitTile);
			FlxG.overlap(Registry.bullets, leftPlatform, Registry.bullets.bulletHitTile);
			FlxG.overlap(Registry.bullets, rightPlatform, Registry.bullets.bulletHitTile);
			FlxG.overlap(Registry.bullets, middlePlatform, Registry.bullets.bulletHitTile);
			
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