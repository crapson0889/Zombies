package  
{
	import org.flixel.*;
	
	public class GameOverMenu extends FlxGroup
	{
		private static var restartButton:FlxButton;
		private static var quitButton:FlxButton;
		private var gameOverText:FlxText;
		[Embed(source = "../assets/sounds/ZombiesGameOver.mp3")] public var MusicMode:Class;
		
		public function GameOverMenu() 
		{
			FlxG.mouse.load();
			
			FlxG.music.stop();
			if(Registry.options.sound)
				FlxG.play(MusicMode);
			
			restartButton = new FlxButton(FlxG.width/2 - 40, FlxG.height/2 - 10, "Restart", restartGame);
			add(restartButton);
			
			quitButton = new FlxButton(FlxG.width / 2 - 40, FlxG.height / 2 + 20, "Quit", quitGame);
			add(quitButton);
			
			gameOverText = new FlxText(FlxG.width / 2 - 80, FlxG.height / 2 - 60, 160, "Game Over\nScore: "+Registry.score, true);
			gameOverText.alignment = "center";
			gameOverText.size = 16;
			gameOverText.shadow = 0xff333333;
			add(gameOverText);
		}
		
		public static function restartGame():void 
		{
			Registry.erase();
			FlxG.switchState(new PlayState);
		}
		
		public static function quitGame():void 
		{
			Registry.erase();
			FlxG.switchState(new MenuMainState);
		}
		
	}

}