package  
{
	import fx.Darkness;
	import org.flixel.FlxButton;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	import org.flixel.FlxState;
    import org.flixel.FlxG;
	import org.flixel.FlxTilemap;
	
	public class MenuIntroState extends FlxState
	{
		[Embed(source = "../assets/menu_background.csv", mimeType = "application/octet-stream")] public var backgroundCSV:Class;
		[Embed(source = "../assets/terrain.png")] public var tileset:Class;
		[Embed(source = "../assets/mouse.png")] public var mousePNG:Class;
		[Embed(source = "../assets/wad.png")] public var wadPNG:Class;
		[Embed(source = "../assets/supply@2x.png")] public var supplyPNG:Class;
		
		private var mouseSprite:FlxSprite;
		private var wadSprite:FlxSprite;
		
		public function MenuIntroState() 
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
			
			add(Registry.darkness);
			
			var title:FlxText = new FlxText(50, 10, 300, "Instructions");
			title.alignment = "center";
			title.shadow = 0xff333333;
			title.size = 16;
			add(title);
			
			var mouseText:FlxText = new FlxText(50, 80, FlxG.width - 100, "Use this:           to kill zombies");
			mouseText.size = 16;
			add(mouseText);
			
			mouseSprite = new FlxSprite(150, 40);
			mouseSprite.loadGraphic(mousePNG, true, true, 36, 80, true);
			mouseSprite.addAnimation("click", [0, 1], 2, false);
			add(mouseSprite);
			
			var wadText:FlxText = new FlxText(50, 170, FlxG.width - 100, "Use these:              to move");
			wadText.size = 16;
			add(wadText);
			
			wadSprite = new FlxSprite(160, 150);
			wadSprite.loadGraphic(wadPNG, true, true, 64, 48, true);
			wadSprite.addAnimation("click", [0, 1], 2, false);
			add(wadSprite);
			
			var supplyText:FlxText = new FlxText(50, 260, FlxG.width - 100, "Collect these:");
			supplyText.size = 16;
			add(supplyText);
			
			var supplySprite:FlxSprite = new FlxSprite(200, 240);
			supplySprite.loadGraphic(supplyPNG, true, true, 48, 48, true);
			add(supplySprite);
			
			var startButton:FlxButton = new FlxButton(FlxG.width - 100, FlxG.height - 30, "Lets Go!", startGame);
			add(startButton);
		}
		
		override public function update():void 
		{
			super.update();
			
			mouseSprite.play("click");
			wadSprite.play("click");
		}
		
		override public function draw():void {
			Registry.darkness.fill(0xff333333);
			
			super.draw();
		}
		
		private function startGame():void 
		{
			var gameState:PlayState = new PlayState();
			
            FlxG.switchState(gameState);
		}
		
	}

}