package fx 
{
	/*
	 * This is just a simple class that creates a sprite the size of the screen and colors it black.
	 * It will be used as the darkness of the game
	 * */
	import org.flixel.*;
	
	public class Darkness extends FlxSprite
	{
		public function Darkness() 
		{
			super(0, 0);
			
			makeGraphic(FlxG.width, FlxG.height, 0xff000000);
			scrollFactor.x = scrollFactor.y = 0;
			blend = "multiply";	
		}
	}

}