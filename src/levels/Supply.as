package levels
{
	/*
	 * 	A single supply box instance
	 * */
	import org.flixel.FlxSprite;
	
	public class Supply extends FlxSprite
	{
		[Embed(source = '../../assets/supply.png')] private var supplyPNG:Class;
		
		public function Supply(bx:int, by:int) 
		{
			super (bx, by, supplyPNG);
		}
		
	}

}