package  
{
	/*
	 * The basic enemy of the game
	 * */
	import org.flixel.*;
	
	public class Zombie extends FlxSprite
	{
		[Embed(source = '../assets/zombie.png')] private var zombiePNG:Class;
		
		public var speed:int = 25;
		public var gravity:int = 400;
		private var lastDirection:int = 0;
		
		public function Zombie() 
		{
			super(0, 0, zombiePNG);
			exists = false;
		}
		
		public function drop(bx:int, by:int, direction:int):void
		{
			health = 3;
			x = bx;
			y = by;
			velocity.x = direction * speed;
			velocity.y = gravity;
			lastDirection = direction;
			exists = true;
		}
		
		override public function update():void 
		{
			super.update();
			
			velocity.y = gravity;
			
			if (velocity.x == 0)
			{
				lastDirection = lastDirection * -1;
				velocity.x = speed * lastDirection;
			}
			if (y > FlxG.height)
			{
				exists = false;
			}
		}
	}

}