package 
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Chris Rapson
	 */
	[SWF(width="680", height="512", backgroundColor="#000000")]

	public class Main extends FlxGame
	{
		public function Main()
		{
			super(340, 256, PlayState, 2, 60, 60);
			
			forceDebugger = true;
		}
	}
}