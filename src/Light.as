package 
{
	/*
	 *	The lit up area immediately surrounding the player.
	 * */
	import flash.display.Graphics;
	import org.flixel.*;

	public class Light extends FlxSprite {

		private var darkness:FlxSprite;
		public var turnable:Boolean = false;
    
		public function Light(x:Number, y:Number, imageClass:Class, darkness:FlxSprite):void {
			super(x, y, imageClass);
			
			this.darkness = darkness;
			this.blend = "screen"
			
			facing = FlxObject.RIGHT;
		}

		override public function draw():void {
			var screenXY:FlxPoint = getScreenXY();

			darkness.stamp(this,
					screenXY.x - this.width / 2,
					screenXY.y - this.height / 2);
		}
		
		override public function update():void {
			super.update();
			
			if (turnable == true)
			{
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
			}
			
			facing = Registry.player.facing;
		}
	}
}