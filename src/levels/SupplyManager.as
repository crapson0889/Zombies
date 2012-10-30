package levels 
{
	import org.flixel.*;
	
	public class SupplyManager extends FlxGroup
	{
		[Embed(source = "dungeon/mapCSV_Group1_Supplies.csv", mimeType = "application/octet-stream")] public var supplyCSV:Class;
		[Embed(source = "dungeon/terrain.png")] public var tileset:Class;
		
		public var supply:Supply;
		
		public function SupplyManager() 
		{
			super();
			
			Registry.supplyLocations = new FlxTilemap;
			Registry.supplyLocations.loadMap(new supplyCSV, tileset, 16, 16, 0, 0, 1, 31);
			newSupply();
		}
		
		override public function update():void 
		{
			super.update();
			
			if (Registry.player.overlaps(supply))
			{
				Registry.score++;
				supply.kill();
				trace("plus one point!");
				newSupply();
			}
		}
		
		public function newSupply():void 
		{
			var rand:uint = Math.floor(Math.random() * Registry.supplyLocations.getTileInstances(24).push());
			var supplyLocation:FlxPoint = Registry.supplyLocations.getTileCoords(24)[rand];
			supply = new Supply(supplyLocation.x-8, supplyLocation.y-8);
			add(supply);
		}
	}

}