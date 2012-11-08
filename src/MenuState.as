package
{
	
	
	
	import org.flixel.*;
	import player.*;
	import fx.*;
	import zombies.*;
	import levels.*;
	import org.flixel.FlxState;
    import org.flixel.FlxG;
	
	public class MenuState extends FlxState
	{
		public function MenuState()
		{
				
		var title:FlxText = new FlxText(100, 50, 300, "Zombie Game!");
		title.size = 24;
		add(title);
		
		var startButton:FlxButton = new FlxButton(100, 100, "Start Game", startGame);
        //startButton(new FlxText(20,3,100,"Start Game"));
        add(startButton);
		
		add(new FlxText(100, 130, 300, "'A' and 'D' to move left/right \n" + "Spacebar to Jump! \n" + "Mouse Click to shoot!"));
		
		FlxG.mouse.show();
		}
		
		
		private function startGame():void
        {
            FlxG.switchState(new PlayState());
        }
		
	}
	
	
}