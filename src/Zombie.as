package  
{
	/*
	 * The basic enemy of the game
	 * */
	import org.flixel.*;
	
	public class Zombie extends FlxSprite
	{
		[Embed(source = '../assets/zombie.png')] private var zombiePNG:Class;
		
		public var speed:int = 50;
		public var gravity:int = 100;
		
		public function Zombie() 
		{
			super(0, 0, zombiePNG);
			exists = false;
		}
		
		public function drop(bx:int, by:int, direction:int):void
		{
			x = bx;
			y = by;
			velocity.x = direction * speed;
			velocity.y = gravity;
			exists = true;
		}
		
		override public function update():void 
		{
			super.update();
			
			velocity.y = gravity;
			
			if (x < 0 || x > FlxG.width)
			{
				velocity.x = -1 * (velocity.x);
			}
			if (y > FlxG.height)
			{
				exists = false;
			}
		}
	}

}