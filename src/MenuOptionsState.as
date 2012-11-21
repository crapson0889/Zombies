package  
{
	import fx.Darkness;
	import org.flixel.FlxButton;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	import org.flixel.FlxTilemap;
	
	public class MenuOptionsState extends FlxState
	{
		private var soundButton:FlxButton;
		private var loggingButton:FlxButton;
		
		[Embed(source = "../assets/menu_background.csv", mimeType = "application/octet-stream")] public var backgroundCSV:Class;
		[Embed(source = "../assets/terrain.png")] public var tileset:Class;
		
		public function MenuOptionsState() 
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
			
			var title:FlxText = new FlxText(50, 10, 300, "Options");
			title.alignment = "center";
			title.shadow = 0xff333333;
			title.size = 16;
			add(title);
			
			var soundText:FlxText = new FlxText(50, 50, 300, "Toggle whether or not sounds will play during the game");
			soundText.shadow = 0xff333333;
			add(soundText);
			
			soundButton = new FlxButton(100, 80, "Sound: " + String(Registry.options.sound), Registry.options.soundSwitch);
			add(soundButton);
			
			var loggingText:FlxText = new FlxText(50, 130, 300, "Toggle whether or not the game collects anonymous data during the runtime of the game");
			loggingText.shadow = 0xff333333;
			add(loggingText);
			
			loggingButton = new FlxButton(100, 160, "Logging: " + String(Registry.options.logging), Registry.options.loggingSwitch);
			add(loggingButton);
		}
		
		override public function update():void
		{
			super.update();
			
			soundButton.label = new FlxText(soundButton.x - 2, soundButton.y + 4, soundButton.width, "Sound: " + Registry.options.soundString());
			soundButton.label.setFormat(null, 8, 0x444444, "center");
			
			loggingButton.label = new FlxText(loggingButton.x - 2, loggingButton.y + 4, loggingButton.width, "Logging: " + Registry.options.loggingString());
			loggingButton.label.setFormat(null, 8, 0x444444, "center");
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