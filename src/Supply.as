package  
{
	import org.flixel.FlxSprite;
	
	public class Supply extends FlxSprite
	{
		[Embed(source = '../assets/supply.png')] private var supplyPNG:Class;
		
		public function Supply() 
		{
			super (64, 186, supplyPNG);
			
			offset.x = 2;
			offset.y = 2;
		}
		
	}

}