package fx 
{
	import org.flixel.*;
	
	public class Flashlight extends Light
	{
		
		[Embed(source = "../../assets/flashlight.png")] private var FlashlightImageClass:Class;
		
		public function Flashlight(x:Number, y:Number, darkness:FlxSprite):void  
		{
			super(x, y, FlashlightImageClass, darkness);
		}
		
		override public function update():void {
			super.update();
			
			if (Registry.player.facing == FlxObject.RIGHT)
			{
				facing = FlxObject.RIGHT;
				angle = 0;
				x = Registry.player.x + 64;
				y = Registry.player.y +12;
			}
			else {
				facing = FlxObject.LEFT;
				angle = 180;
				x = Registry.player.x - 52;
				y = Registry.player.y +8;
			}
			
			facing = Registry.player.facing;
		}
		
	}

}