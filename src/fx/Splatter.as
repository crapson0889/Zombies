package fx
{
	/*
	 * 	A single splatter of blood from a zombie
	 * */
	import org.flixel.*;
	
	public class Splatter extends FlxEmitter
	{
		private var particle:FlxParticle;
		
		public function Splatter(bx:Number = 170, by:Number = 128, s:Number = 25)
		{
			super(bx, by, s);
			
			maxRotation = 0;
			height = 16;
			width = 16;
			gravity = 400;
			bounce = 0.2;
			
			exists = false;
			
			for (var i:int = 0; i < 25; i++)
			{
				particle = new FlxParticle();
				particle.makeGraphic(2, 2, 0xffCC0000);
				add(particle);
				/*if (i % 5 == 0)
				{
					particle = new FlxParticle();
					particle.makeGraphic(3, 3, 0xff819969);
					add(particle);
					particle = new FlxParticle();
					particle.makeGraphic(3, 3, 0xffD4D7D8);
					add(particle);
				}*/
			}
		}
		
		public function setDirection(bullet:FlxPoint, gun:FlxPoint):void
		{
			var direction:Number = bullet.x - gun.x;
			if (direction < 0)
				direction = -1;
			else
				direction = 1;
			setXSpeed(100 * direction, 200 * direction);
			//setYSpeed(-100, -200);
			maxParticleSpeed = new FlxPoint(5, 5);
		}
	}
}