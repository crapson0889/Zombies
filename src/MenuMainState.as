package
{
	import fx.Darkness;
	import org.flixel.FlxButton;
	import org.flixel.FlxText;
	import org.flixel.FlxState;
    import org.flixel.FlxG;
	import org.flixel.FlxTilemap;
	
	public class MenuMainState extends FlxState
	{
		[Embed(source = "../assets/menu_background.csv", mimeType = "application/octet-stream")] public var backgroundCSV:Class;
		[Embed(source = "../assets/terrain.png")] public var tileset:Class;
		[Embed(source = "../assets/sounds/ZombiesTitle.mp3")] public var MusicMode:Class;
		
		public function MenuMainState()
		{	
			super();
		}
		
		override public function create():void 
		{
			super.create();
			
			if (!Registry.musicIsOn)
			{
				FlxG.playMusic(MusicMode);
				Registry.musicIsOn = true;
			}
			//FlxG.music = MusicMode;
			
			
			Registry.darkness = new Darkness;
			
			var background:FlxTilemap = new FlxTilemap;
			background.loadMap(new backgroundCSV, tileset, 16, 16, 0, 0, 1, 31);
			add(background);
			
			add(Registry.darkness); //Added the darkness. I think we can get some cool torch effect going at the beginning of the game.
			
			Registry.options = new OptionManager;
			
			var title:FlxText = new FlxText(0, 50, 400, "Zombies' Descent");
			title.alignment = "center";
			title.shadow = 0xff333333;
			title.size = 24;
			add(title);
			
			var startButton:FlxButton = new FlxButton(100, 160, "Start Game", startGame);
			startButton.x = FlxG.width / 2 - startButton.width / 2;
			add(startButton);
			
			var optionsButton:FlxButton = new FlxButton(100, 190, "Options", switchToOptionsState);
			optionsButton.x = FlxG.width / 2 - optionsButton.width / 2;
			add(optionsButton);
			
			var infoButton:FlxButton = new FlxButton(100, 220, "Information", switchToInfoState);
			infoButton.x = FlxG.width / 2 - infoButton.width / 2;
			add(infoButton);
			
			if(Registry.options.logging)
				FlxG.debug = true;
			
			FlxG.mouse.show();
		}
		
		override public function draw():void {
			Registry.darkness.fill(0xff333333);
			
			super.draw();
		}
		
		private function startGame():void
        {
			var introState:MenuIntroState = new MenuIntroState();
			
            FlxG.switchState(introState);
        }
		
		private function switchToOptionsState():void 
		{
			FlxG.switchState(new MenuOptionsState);
		}
		
		private function switchToInfoState():void 
		{
			FlxG.switchState(new MenuInfoState);
		}
	}
}