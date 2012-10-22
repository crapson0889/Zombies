package
{
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{	
		//Player class handling our hero
		//private var player:Player;
		//Registry.player = new Player;
		//Registry.bullets = new BulletManager;
		
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
		
		public function PlayState() 
		{
		}
		
		override public function create():void
		{
			Registry.bullets = new BulletManager;
			Registry.zombies = new ZombieManager;
			Registry.fx = new Fx;
			
			//Setting the Background Color
			FlxG.bgColor = 0xff444444;
			
			//Creating the Player and adding
			Registry.player = new Player(32, 170);
			
			add(Registry.player);
			add(Registry.bullets);
			add(Registry.zombies);
			add(Registry.fx);
			
			zombieTimer = new FlxTimer();
			//Registry.zombies.drop();
			zombieTimer.start(1, 0, Registry.zombies.drop);
			
			supply = new Supply();
			add(supply);
			
			debug = new FlxText(0, 0, 200, "");
			add(debug);
			
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
			light = new Light(Registry.player.x, Registry.player.y, darkness);
			
			add(light);
			
			//Adding the Darkness
			//Important that the Darkness is created before the light, but added after the light... Don't mess with it
			//add(darkness);		//Commenting out this line will remove the darkness
		}
		
		override public function update():void
		{
			super.update();
			
			debug.text = "Bullet Pool: " + Registry.zombies.countLiving() + "/" + Registry.zombies.maxSize;
			
			//If user collides with platform... collide
			FlxG.collide(Registry.player, floor);
			FlxG.collide(Registry.player, leftPlatform);
			FlxG.collide(Registry.player, rightPlatform);
			FlxG.collide(Registry.player, middlePlatform);
			
			FlxG.collide(Registry.zombies, floor);
			FlxG.collide(Registry.zombies, leftPlatform);
			FlxG.collide(Registry.zombies, rightPlatform);
			FlxG.collide(Registry.zombies, middlePlatform);
			
			FlxG.overlap(Registry.zombies, Registry.bullets, Registry.zombies.bulletHitZombie);
			
			FlxG.overlap(Registry.player, supply, hitSupply);
			
			//Keep the light on the Player
			light.x = Registry.player.x + 5;
			light.y = Registry.player.y + 5;
		}
		
		override public function draw():void {
			//darkness.fill(0xff000000);
			darkness.fill(0xff222222);
			super.draw();
		}
		
		private function hitSupply(player:FlxObject, supply:FlxObject):void 
		{
			supply.kill();
		}
	}

}