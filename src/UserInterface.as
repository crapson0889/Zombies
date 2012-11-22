package  
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	
	public class UserInterface extends FlxGroup
	{
		[Embed(source = '../assets/battery.png')] private var batteryPNG:Class;
		
		public var debug:FlxText;
		//public var batteryText:FlxText;
		public var battery:FlxSprite;
		public var weapon:FlxText;
		public var ammo:FlxText;
		private var created:Boolean = false;
		
		public function UserInterface() 
		{
			super();
			
			debug = new FlxText(0, 0, 200, "");
			add(debug);
			
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
			add(weapon);
			
			ammo = new FlxText(0, 290, 400, "");
			ammo.alignment = "right";
			add(ammo);
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
			
			debug.text = "Score: " + Registry.score;
			//batteryText.text = "Battery: " + Registry.player.flashlight.batteryLife;
			weapon.text = "Weapon: " + Registry.player.gun().name;
			ammo.text = "Ammo: " + Registry.player.ammo;
		}
		
	}

}