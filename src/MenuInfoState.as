package  
{
	import fx.Darkness;
	import org.flixel.FlxButton;
	import org.flixel.FlxText;
	import org.flixel.FlxState;
    import org.flixel.FlxG;
	import org.flixel.FlxTilemap;
	
	public class MenuInfoState extends FlxState
	{
		[Embed(source = "../assets/menu_background.csv", mimeType = "application/octet-stream")] public var backgroundCSV:Class;
		[Embed(source = "../assets/terrain.png")] public var tileset:Class;
		
		public function MenuInfoState() 
		{
			super();
		}
		
		override public function create():void 
		{
			super.create();
			
			Registry.darkness = new Darkness;
			
			var background:FlxTilemap = new FlxTilemap;
			background.loadMap(new backgroundCSV, tileset, 16, 16, 0, 0, 1, 31);
			add(background);
			
			add(Registry.darkness); //Added the darkness. I think we can get some cool torch effect going at the beginning of the game.
			
			var backButton:FlxButton = new FlxButton(10, 10, "Back", backToMenu);
			add(backButton);
			
			var title:FlxText = new FlxText(50, 10, 300, "Information");
			title.alignment = "center";
			title.shadow = 0xff333333;
			title.size = 16;
			add(title);
			
			var instructions:FlxText = new FlxText(50, 50, 300, "Navigate the map to collect glowing supplies and increase your score. Watch out for Zombies! You only have a limited amount of time before the battery on your flashlight runs out.\n\n" + 
			"'A' and 'D' to move left/right \n" + "Spacebar to Jump! \n" + "Mouse Click to shoot!\n\n" + 
			"This game was created for a class project for CECS 550 at Speed School or University of Louisville\n\n" + 
			"Credits: \nChristopher Rapson\nPhillip Rose\nSteven Harris\nMike Zanchi\nJesse Garrett");
			instructions.shadow = 0xff333333;
			add(instructions);
			
			var version:FlxText = new FlxText(50, FlxG.height - 30, 300, "Ver 0.17a");
			version.shadow = 0xff333333;
			version.alignment = "right";
			add(version);
		}
		
		override public function draw():void {
			Registry.darkness.fill(0xff333333);
			
			super.draw();
		}
		
		private function backToMenu():void 
		{
			FlxG.switchState(new MenuMainState);
		}
		
	}

}