package levels 
{
	import fx.Light;
	import org.flixel.*;
	
	public class SupplyManager extends FlxGroup
	{
		[Embed(source = "dungeon/mapCSV_Group1_Supplies.csv", mimeType = "application/octet-stream")] public var supplyCSV:Class;
		[Embed(source = "dungeon/terrain.png")] public var tileset:Class;
		[Embed(source = "../../assets/supplyLight.png")] private var SupplyLightImageClass:Class;
		[Embed(source = "../../assets/sounds/supply.mp3")] private var supplySND:Class;
		
		public var supply:Supply;
		private var supplyLight:Light;
		private var lightTimer:FlxTimer;
		private var lightAlpha:Number = 1;
		
		public function SupplyManager() 
		{
			super();
			
			Registry.supplyLocations = new FlxTilemap;
			Registry.supplyLocations.loadMap(new supplyCSV, tileset, 16, 16, 0, 0, 1, 31);
			newSupply();
			supplyLight = new Light(0, 0, SupplyLightImageClass, Registry.darkness);
			add(supplyLight);
			lightTimer = new FlxTimer();
			lightTimer.start(0.1, 0, lightAlphaChange);
		}
		
		override public function update():void 
		{
			super.update();
			
			supplyLight.x = supply.x + 8;
			supplyLight.y = supply.y + 8;
			
			supplyLight.alpha = lightAlpha;
			
			if (Registry.player.sprite.overlaps(supply))
			{
				Registry.score++;
				supply.kill();
				Registry.player.flashlight.batteryLife += 12;
				if (Registry.options.sound)
					FlxG.play(supplySND);
				newSupply();
				Registry.player.newRandomWeapon();
				
				if(Registry.options.logging)
					Registry.logger.Log("Supplies Gathered", "new score: " + Registry.score, "None", "Player has collected supplies");
			}
		}
		
		private function newSupply():void 
		{
			var rand:uint = Math.floor(Math.random() * Registry.supplyLocations.getTileInstances(24).push());
			var supplyLocation:FlxPoint = Registry.supplyLocations.getTileCoords(24)[rand];
			supply = new Supply(supplyLocation.x-8, supplyLocation.y-8);
			add(supply);
		}
		
		private function lightAlphaChange(time:FlxTimer):void 
		{
			lightAlpha = lightAlpha - 0.1;
			if (lightAlpha < 0)
			{
				lightAlpha = 1;
			}
		}
	}

}