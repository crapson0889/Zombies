package zombies
{
	/*
	 * The basic enemy of the game
	 * */
	import org.flixel.*;
	
	public class Zombie extends FlxSprite
	{
		[Embed(source = '../../assets/zombie.png')] private var zombiePNG:Class;
		
		public var speed:int = 25;
		public var gravity:int = 200;
		private var lastDirection:int = 0;
		
		public function Zombie() 
		{
			super(0, 0);
			//loadGraphic(zombiePNG, true, true, 16, 19, true);
			//addAnimation("walk", [0, 1, 2, 3, 4, 5], 10, true);
			exists = false;
		}
		
		public function drop(bx:int, by:int, direction:int):void
		{
			loadGraphic(zombiePNG, true, true, 16, 19, true);
			addAnimation("walk", [0, 1, 2, 3, 4, 5], 10, true);
			health = 15;
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
			if (touching == FlxObject.FLOOR)
			{
				play("walk");
			}
			if (lastDirection < 0)
				facing = LEFT;
			else
				facing = RIGHT;
		}
	}

}