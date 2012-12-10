package levels
{
	import flash.display.Sprite;
	import org.flixel.*;
	import fx.Light;
	
	public class Level1 extends FlxGroup
	{
		//[Embed(source = "dungeon/mapCSV_Group1_Background.csv", mimeType = "application/octet-stream")] public var backgroundCSV:Class;
		//[Embed(source = "dungeon/mapCSV_Group1_Midground.csv", mimeType = "application/octet-stream")] public var midgroundCSV:Class;
		//[Embed(source = "dungeon/mapCSV_Group1_Foreground.csv", mimeType = "application/octet-stream")] public var foregroundCSV:Class;
		//[Embed(source = "dungeon/terrain.png")] public var tileset:Class;
		[Embed(source = "ZombiesLevel/mapCSV_Group1_Background.csv", mimeType = "application/octet-stream")] public var backgroundCSV:Class;
		[Embed(source = "ZombiesLevel/mapCSV_Group1_Midground.csv", mimeType = "application/octet-stream")] public var midgroundCSV:Class;
		[Embed(source = "ZombiesLevel/mapCSV_Group1_Foreground.csv", mimeType = "application/octet-stream")] public var foregroundCSV:Class;
		[Embed(source = "ZombiesLevel/tileset.png")] public var tileset:Class;
		[Embed(source = "/../assets/portalLight.png")] private var PortalLightImageClass:Class;
		[Embed(source = "/../assets/portalLightLarge.png")] private var PortalLightLargeImageClass:Class;
		
		public var background:FlxTilemap;
		public var midground:FlxTilemap;
		public var foreground:FlxTilemap;
		private var portalLightLeft:Light;
		private var portalLightCenter:Light;
		private var portalLightRight:Light;
		private var portalLightBottom:Light;
			
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
			
			portalLightLeft = new Light(96, 24, PortalLightImageClass, Registry.darkness);
			add(portalLightLeft);
			portalLightCenter = new Light(200, 16, PortalLightLargeImageClass, Registry.darkness);
			add(portalLightCenter);
			portalLightRight = new Light(304, 24, PortalLightImageClass, Registry.darkness);
			add(portalLightRight);
			portalLightBottom = new Light(200, 272, PortalLightLargeImageClass, Registry.darkness);
			portalLightBottom.angle = 180;
			add(portalLightBottom);
		}
		
	}

}