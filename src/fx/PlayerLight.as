package fx 
{
	import org.flixel.*;
	
	public class PlayerLight extends Light
	{
		
		[Embed(source = "/../assets/playerLight.png")] private var PlayerLightImageClass:Class;
		
		public function PlayerLight(x:Number, y:Number, darkness:FlxSprite):void  
		{
			super(x, y, PlayerLightImageClass, darkness);
		}
		
		override public function update():void 
		{
			super.update();
			
			x = Registry.player.sprite.x + 5;
			y = Registry.player.sprite.y + 5;
		}
		
	}

}