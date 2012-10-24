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
		
		public function spurt(x:Number, y:Number, direction:int):void 
		{
			var splatter:Splatter = members[splatterCount];
			
			splatter.setDirection(direction);
			splatter.x = x;
			splatter.y = y;
			splatter.setSize(3, 3);
			splatter.start(true, 3, 0.01);
			
			splatterCount++;
			if (splatterCount == Registry.zombieCount)
			{
				splatterCount = 0;
			}
		}
		
		public function explode(x:Number, y:Number, direction:int):void
		{	
			var splatter:Splatter = members[splatterCount];
			
			splatter.setDirection(direction);
			splatter.x = x;
			splatter.y = y;
			splatter.setSize(16, 16);
			splatter.start(true, 3, 0.01);
			
			splatterCount++;
			if (splatterCount == Registry.zombieCount)
			{
				splatterCount = 0;
			}
		}
		
		public function playerDeath(x:Number, y:Number):void 
		{
			var splatter:Splatter = members[splatterCount];
			
			splatter.setXSpeed(-100, 100);
			splatter.setYSpeed(-100, -150);
			splatter.x = x;
			splatter.y = y;
			splatter.setSize(8, 8);
			splatter.start(false, 0, 0.01);
			
			splatterCount++;
			if (splatterCount == Registry.zombieCount)
			{
				splatterCount = 0;
			}
		}
	}
}