package  
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	
	public class UserInterface extends FlxGroup
	{
		[Embed(source = '../assets/battery.png')] private var batteryPNG:Class;
		[Embed(source = '../assets/pistol@2x.png')] private var pistolPNG:Class;
		[Embed(source = '../assets/rocket@2x.png')] private var rocketPNG:Class;
		[Embed(source = '../assets/uzi@2x.png')] private var uziPNG:Class;
		[Embed(source = '../assets/rifle@2x.png')] private var riflePNG:Class;
		
		public var score:FlxText;
		//public var batteryText:FlxText;
		public var battery:FlxSprite;
		public var weapon:FlxText;
		public var ammo:FlxText;
		private var created:Boolean = false;
		
		public var pistol:FlxSprite;
		public var rocket:FlxSprite;
		public var uzi:FlxSprite;
		public var rifle:FlxSprite;
		
		public function UserInterface() 
		{
			super();
			
			score = new FlxText(8, 8, 200, "");
			score.size = 16;
			add(score);
			
			//batteryText = new FlxText(0, 16, 200, "");
			//add(batteryText);
			
			battery = new FlxSprite(363, 10);
			battery.loadGraphic(batteryPNG, true, false, 32, 32);
			battery.addAnimation("drain", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], 1, false);
			battery.addAnimation("refresh", [0], 64, false);
			battery.exists = false;
			add(battery);
			
			weapon = new FlxText(0, 280, 400, "");
			weapon.alignment = "right";
			//add(weapon);
			
			ammo = new FlxText(56, 288, 400, "");
			//ammo.alignment = "right";
			add(ammo);
			
			pistol = new FlxSprite(14, 254);
			pistol.loadGraphic(pistolPNG, true, false, 40, 40);
			add(pistol);
			
			rocket = new FlxSprite(14, 254);
			rocket.loadGraphic(rocketPNG, true, false, 40, 40);
			rocket.exists = false;
			add(rocket);
			
			uzi = new FlxSprite(14, 254);
			uzi.loadGraphic(uziPNG, true, false, 40, 40);
			uzi.exists = false;
			add(uzi);
			
			rifle = new FlxSprite(14, 254);
			rifle.loadGraphic(riflePNG, true, false, 40, 40);
			rifle.exists = false;
			add(rifle);
		}
		
		public function create():void 
		{
			battery.exists = true;
			
			created = true;
		}
		
		override public function update():void 
		{
			super.update();
			
			if (Registry.player.flashlight.batteryLife == 12)
			{
				battery.play("refresh");
			}
			if (Registry.player.flashlight.batteryLife != 0)
			{
				battery.play("drain");
			}
			
			score.text = "Score: " + Registry.score;
			//batteryText.text = "Battery: " + Registry.player.flashlight.batteryLife;
			weapon.text = "Weapon: " + Registry.player.gun().name;
			if(Registry.player.ammo != 0)
				ammo.text = String(Registry.player.ammo);
			else
				ammo.text = "";
			
			pistol.exists = false;
			rocket.exists = false;
			uzi.exists = false;
			rifle.exists = false;
			
			switch (Registry.player.currentGun) 
			{
				case 1:
					pistol.exists = true;
					break;
				case 2:
					rocket.exists = true;
					break;
				case 3:
					uzi.exists = true;
					break;
				case 4:
					rifle.exists = true;
					break;
				default:
					pistol.exists = true;
					break;
			}
		}
		
	}

}