package player 
{
	import org.flixel.FlxSprite;

	public class Utility extends FlxSprite
	{
		[Embed(source = '../../assets/supply.png')] private var utilityPNG:Class;
		
		public var gravity:int = 200;
		
		public function Utility() 
		{
			super(0, 0, utilityPNG); //This will have to be moved somewhere else when we implement different types of utilities
			exists = false;
		}
		
		public function  drop(bx:int, by:int):void 
		{
			//My pathetic algorithm to ensure that the utility is snapped to the grid when dropped.
			var tempx:int = bx;
			trace(tempx);
			tempx = tempx / 16;
			trace(tempx);
			tempx = tempx * 16;
			trace(tempx);
			x = tempx;
			y = by;
			exists = true;
			velocity.y = gravity;
		}
		
	}

}