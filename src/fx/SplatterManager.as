package fx
{
	/*
	 * Handles multiple splatters in the game, because there is more than one zombie to kill
	 * */
	import flash.display.InteractiveObject;
	import org.flixel.*;
	
	public class SplatterManager extends FlxGroup
	{
		private var splatterCount:int = 0;
		
		public function SplatterManager() 
		{
			super();
			
			for (var i:int = 0; i < Registry.zombieCount; i++)
			{
				add(new Splatter());
			}
		}
		
		public function spurt(x:Number, y:Number, bullet:FlxPoint, gun:FlxPoint):void 
		{
			var splatter:Splatter = members[splatterCount];
			
			splatter.setDirection(bullet, gun);
			splatter.x = x + 8;
			splatter.y = y + 8;
			splatter.setSize(1, 1);
			splatter.start(true, 1, 0.01);
			
			splatterCount++;
			if (splatterCount == Registry.zombieCount)
			{
				splatterCount = 0;
			}
		}
		
		public function explode(x:Number, y:Number, bullet:FlxPoint, gun:FlxPoint):void
		{	
			var splatter:Splatter = members[splatterCount];
			
			splatter.setDirection(bullet, gun);
			splatter.x = x;
			splatter.y = y;
			splatter.setSize(16, 16);
			splatter.start(true, 3, 0.01);
			
			splatterCount++;
			if (splatterCount == Registry.zombieCount)
			{
				splatterCount = 0;
			}
		}
		
		public function playerDeath(x:Number, y:Number):void 
		{
			//Custom player emitter for when the player dies...
			
			var splatter:FlxEmitter = new FlxEmitter(x, y, 255);
			
			splatter.setXSpeed(-200, 200);
			splatter.setYSpeed(-10, -250);
			splatter.setSize(16, 16);
			splatter.maxRotation = 0;
			splatter.gravity = 400;
			splatter.bounce = 0.1;
			var particle:FlxParticle;
			for (var i:int = 0; i < 250; i++)
			{
				particle = new FlxParticle();
				particle.makeGraphic(2, 2, 0xffCC0000);
				splatter.add(particle);
				if (i % 50 == 0)
				{
					particle = new FlxParticle();
					particle.makeGraphic(4, 4, 0xffA60000);
					splatter.add(particle);
				}
			}
			add(splatter);
			splatter.start(true, 0, 0.01);
		}
	}
}