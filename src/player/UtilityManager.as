package player 
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxG;
	
	public class UtilityManager extends FlxGroup
	{
		
		public function UtilityManager() 
		{
			super();
			
			for (var i:int; i < 5; i++)
			{
				add(new Utility);
			}
		}
		
		public function drop():void 
		{
			if (getFirstAvailable())
			{
				Utility(getFirstAvailable()).drop(Registry.player.sprite.x, Registry.player.sprite.y);
			}
		}
		
		override public function  update():void 
		{
			super.update();
			
			if (FlxG.keys.justPressed("W"))
			{
				drop();
			}
		}
		
	}

}