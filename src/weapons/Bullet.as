package  weapons
{
	/*
	 *	Handles basic functions of a single bullet
	 * */
	import org.flixel.*;

	public class Bullet extends FlxSprite
	{
		[Embed(source = '../../assets/bullet.png')] private var bulletPNG:Class;
		
		public var damage:int = 1;
		public var speed:int = 300;
		public var direction:int = 0;
		
		public function Bullet() 
		{
			super(0, 0, bulletPNG);
			
			//	We do this so it's ready for pool allocation straight away
			exists = false;
		}

		public function fire(bx:int, by:int):void
		{
			x = bx;
			y = by + 6;
			if (Registry.player.facing == 1)
			{
				velocity.x = -speed;
				direction = -1;
			}
			else
			{
				velocity.x = speed;
				direction = 1;
			}
			exists = true;
		}
		
		override public function update():void
		{
			super.update();
			
			if (overlaps(Registry.level1.midground))
			{
				exists = false;
				kill();
			}
			
			//	Bullet off the top of the screen?
			if (exists)
			{
				if(x < 0 || x > FlxG.width)
					exists = false;
			}
		}
		
	}

}