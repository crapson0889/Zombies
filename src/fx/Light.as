package fx
{
	/*
	 *	The lit up area immediately surrounding the player.
	 * 
	 * The basic class for an image that is blended into the darkness
	 * leaving a hole in the darkness for the user to see through.
	 * */
	
	import flash.display.Graphics;
	import org.flixel.*;

	public class Light extends FlxSprite {

		private var darkness:FlxSprite;
    
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
		
	}
}