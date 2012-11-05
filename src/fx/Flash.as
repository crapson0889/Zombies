package fx 
{
	import org.flixel.*;
	
	public class Flash extends Light
	{
		[Embed(source = "../../assets/flash.png")] private var flashPNG:Class;
		
		public function Flash(x:Number, y:Number, darkness:FlxSprite):void
		{
			super(x, y, flashPNG, darkness);
			
			loadGraphic(flashPNG, true, true, 128, 128, true);
			addAnimation("flash", [1, 0], 10, false);
		}
		
		public override function update():void 
		{
			super.update();
			
			x = Registry.player.sprite.x;
			y = Registry.player.sprite.y;
		}
		
	}

}