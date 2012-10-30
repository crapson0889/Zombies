package levels
{
	import flash.display.Sprite;
	import org.flixel.*;
	
	public class Level1 extends FlxGroup
	{
		[Embed(source = "dungeon/mapCSV_Group1_Background.csv", mimeType = "application/octet-stream")] public var backgroundCSV:Class;
		[Embed(source = "dungeon/mapCSV_Group1_Midground.csv", mimeType = "application/octet-stream")] public var midgroundCSV:Class;
		[Embed(source = "dungeon/mapCSV_Group1_Foreground.csv", mimeType = "application/octet-stream")] public var foregroundCSV:Class;
		[Embed(source = "dungeon/terrain.png")] public var tileset:Class;
		
		public var background:FlxTilemap;
		public var midground:FlxTilemap;
		public var foreground:FlxTilemap;
		//public var supplyLocations:FlxTilemap;
			
		public function Level1() 
		{
			super();		
			background = new FlxTilemap;
			background.loadMap(new backgroundCSV, tileset, 16, 16, 0, 0, 1, 31);
			
			midground = new FlxTilemap;
			midground.loadMap(new midgroundCSV, tileset, 16, 16, 0, 0, 1, 1);
			
			foreground = new FlxTilemap;
			foreground.loadMap(new foregroundCSV, tileset, 16, 16, 0, 0, 1, 31);
			
			add(background);
			add(midground);
			add(foreground);
		}
		
	}

}