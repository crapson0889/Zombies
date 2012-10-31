package 
{
	import org.flixel.*;
	import MenuState;
	
	
	/*
	 * This file just sets the screen size and starts the game... nothing to see here
	 * */
	[SWF(width="800", height="616", backgroundColor="#000000")]

	public class Main extends FlxGame
	{
		public function Main()
		{
			super(400, 308, MenuState, 2, 60, 60);
			
			forceDebugger = true;
		}
	}
}