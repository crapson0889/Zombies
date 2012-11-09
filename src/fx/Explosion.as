package fx
{
	/*
	 * 	A single explosion
	 * */
	import org.flixel.*;
	
	public class Explosion extends FlxEmitter
	{
		private var particle:FlxParticle;
		
		public function Explosion(bx:Number = 170, by:Number = 128, s:Number = 25)
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
				particle.makeGraphic(2, 2, 0xffffffff);
				add(particle);
				
			}
		}
		
		public function setDirection(bullet:FlxPoint, gun:FlxPoint):void
		{
			var direction:int = FlxU.srand(.5);
			if (direction % 2 ==0)
				direction = -1;
			else
				direction = 1;
			setXSpeed(100 * direction, 200 * direction);
			//setYSpeed(-100, -200);
			maxParticleSpeed = new FlxPoint(5, 5);
		}
	}
}