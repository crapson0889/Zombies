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
			
			if (Registry.player.sprite.facing == FlxObject.RIGHT)
			{
				facing = FlxObject.RIGHT;
				angle = 45;
				x = Registry.player.sprite.x + 108;
				y = Registry.player.sprite.y +8;
			}
			else {
				facing = FlxObject.LEFT;
				angle = 225;
				x = Registry.player.sprite.x - 92;
				y = Registry.player.sprite.y +8;
			}
			
			facing = Registry.player.sprite.facing;
		}
		
	}

}