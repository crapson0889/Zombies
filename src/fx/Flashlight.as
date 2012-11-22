package fx 
{
	import org.flixel.*;
	
	public class Flashlight extends Light
	{
		
		[Embed(source = "../../assets/flashlight.png")] private var FlashlightImageClass:Class;
		
		public var batteryLife:uint;
		private var batteryTimer: FlxTimer;
		
		public function Flashlight(x:Number, y:Number, darkness:FlxSprite):void  
		{
			super(x, y, FlashlightImageClass, darkness);
			
			//Decrements the battery life
			batteryTimer = new FlxTimer();
			batteryTimer.start(1, 0, batteryDecrement);
			batteryLife = 12;
		}
		
		override public function update():void {
			super.update();
			
			x = Registry.player.sprite.x + 72;
			y = Registry.player.sprite.y + 72;
			
			if (batteryLife == 0)
			{
				alpha = 0;
			}
			else
			{
				alpha = 1;
			}
			
			angle = FlxU.getAngle(new FlxPoint(Registry.player.sprite.x, Registry.player.sprite.y) , new FlxPoint(FlxG.mouse.x, FlxG.mouse.y)) + 225;
			
			if (batteryLife > 12)
			{
				batteryLife = 12;
			}
			
			//Old code for turning the flashlight. Might come back to limiting the rotation to just one side depending on which way the character is facing.
			/*
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
			*/
		}
		
		private function batteryDecrement(time:FlxTimer):void 
		{
			if (batteryLife != 0)
			{
				batteryLife--;
			}
		}
		
	}

}