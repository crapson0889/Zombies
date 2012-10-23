package  
{
	/*
	 * Handles multiple splatters in the game, because there is more than one zombie to kill
	 * */
	import flash.display.InteractiveObject;
	import org.flixel.*;
	
	public class SplatterManager extends FlxGroup
	{
		private var splatterCount:int = 0;
		
		public function SplatterManager() 
		{
			super();
			
			for (var i:int = 0; i < Registry.zombieCount; i++)
			{
				add(new Splatter());
			}
		}
		
		public function explode(x:Number, y:Number, direction:int):void
		{	
			var splatter:Splatter = members[splatterCount];
			
			splatter.setDirection(direction);
			splatter.x = x;
			splatter.y = y;
			splatter.start(true, 3, 0.01);
			
			splatterCount++;
			if (splatterCount == Registry.zombieCount)
			{
				splatterCount = 0;
			}
		}
	}
}