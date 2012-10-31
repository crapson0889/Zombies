package 
{
	import org.flixel.*;
	
	/*
	 * This file just sets the screen size and starts the game... nothing to see here
	 * */
	[SWF(width="800", height="608", backgroundColor="#000000")]

	public class Main extends FlxGame
	{
		public function Main()
		{
			super(400, 304, MenuState, 2, 60, 60);
			
			forceDebugger = true;
		}
	}
}