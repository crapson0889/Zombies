package fx 
{
	import org.flixel.*;
	
	public class Flashlight extends Light
	{
		
		[Embed(source = "../../assets/flashlight2.png")] private var FlashlightImageClass:Class;
		
		public function Flashlight(x:Number, y:Number, darkness:FlxSprite):void  
		{
			super(x, y, FlashlightImageClass, darkness);
		}
		
		override public function update():void {
			super.update();
			
			if (Registry.player.facing == FlxObject.RIGHT)
			{
				facing = FlxObject.RIGHT;
				angle = 45;
				x = Registry.player.x + 108;
				y = Registry.player.y +8;
			}
			else {
				facing = FlxObject.LEFT;
				angle = 225;
				x = Registry.player.x - 92;
				y = Registry.player.y +8;
			}
			
			facing = Registry.player.facing;
		}
		
	}

}