package zombies
{
	/*
	 * The basic enemy of the game
	 * */
	import org.flixel.*;
	
	public class Zombie extends FlxSprite
	{
		[Embed(source = '../../assets/sounds/zombiespawn1.mp3')] protected var spawnSND:Class; //Embed Zombie Spawn Sound
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
		
		public function drop(bx:int, by:int, direction:int, type:int):void
		{
			switch (type) 
			{
				case 0:
					fastZombie();
					break;
				case 1:
					normalZombie();
					break;
				case 2:
					heavyZombie();
					break;
				default:
			}
			x = bx;
			y = by;
			velocity.x = direction * speed;
			velocity.y = gravity;
			lastDirection = direction;
			exists = true;
			FlxG.play(spawnSND); //Play Zombie Spawn Sound
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
		
		private function fastZombie():void
		{
			//Loading different graphics would change the appearance of the Zombie. They need to be different for each type
			speed = 50;
			loadGraphic(zombiePNG, true, true, 16, 19, true);
			addAnimation("walk", [0, 1, 2, 3, 4, 5], 20, true);
			health = 5;
		}
		
		private function normalZombie():void
		{
			loadGraphic(zombiePNG, true, true, 16, 19, true);
			addAnimation("walk", [0, 1, 2, 3, 4, 5], 10, true);
			health = 15;
		}
		
		private function heavyZombie():void
		{
			speed = 10;
			loadGraphic(zombiePNG, true, true, 16, 19, true);
			addAnimation("walk", [0, 1, 2, 3, 4, 5], 5, true);
			health = 50;
		}
	}

}