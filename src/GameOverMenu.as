package  
{
	import org.flixel.*;
	
	public class GameOverMenu extends FlxGroup
	{
		private static var restartButton:FlxButton;
		private var gameOverText:FlxText;
		
		public function GameOverMenu() 
		{
			FlxG.mouse.show();
			restartButton = new FlxButton(FlxG.width/2 - 40, FlxG.height/2 - 10, "Restart", restartGame);
			add(restartButton);
			
			gameOverText = new FlxText(FlxG.width / 2 - 80, FlxG.height / 2 - 40, 160, "Game Over", true);
			gameOverText.alignment = "center";
			gameOverText.size = 20;
			add(gameOverText);
		}
		
		public static function restartGame():void 
		{
			Registry.erase();
			FlxG.switchState(new PlayState);
		}
		
	}

}