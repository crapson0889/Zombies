package  
{
	/*
	 * 	A single splatter of blood from a zombie
	 * */
	import org.flixel.*;
	
	public class Splatter extends FlxEmitter
	{
		private var particle:FlxParticle;
		
		public function Splatter(bx:Number = 170, by:Number = 128, s:Number = 100)
		{
			super(bx, by, s);
			
			maxRotation = 0;
			height = 16;
			width = 16;
			gravity = 400;
			bounce = 0.2;
			
			exists = false;
			
			for (var i:int = 0; i < 1000; i++)
			{
				particle = new FlxParticle();
				particle.makeGraphic(2, 2, 0xffCC0000);
				add(particle);
			}
		}
		
		public function setDirection(direction:int):void
		{
			setXSpeed(100 * direction, 200 * direction);
		}
	}
}