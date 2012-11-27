package player 
{
	import fx.Light;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;

	public class Utility extends FlxGroup
	{
		[Embed(source = '../../assets/supply.png')] private var utilityPNG:Class;
		[Embed(source = "../../assets/playerLight.png")] private var utilityLightPNG:Class;
		
		public var gravity:int = 200;
		
		public var utility:FlxSprite;
		public var utilityLight:Light;
		
		public function Utility() 
		{
			utility = new FlxSprite(0, 0, utilityPNG); //This will have to be moved somewhere else when we implement different types of utilities
			add(utility);
			
			utilityLight = new Light(0, 0, utilityLightPNG, Registry.darkness);
			add(utilityLight);
			
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
			utility.x = tempx;
			utility.y = by;
			exists = true;
			utility.velocity.y = gravity;
		}
		
		override public function update():void
		{
			super.update();
		}
		
	}

}