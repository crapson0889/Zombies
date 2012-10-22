package  
{
	import org.flixel.*;

	public class Fx extends FlxGroup
	{
		private var pixels:FlxGroup;
		private var whitePixel:FlxParticle;
		
		public function Fx() 
		{
			super();
			
			pixels = new FlxGroup();
			
			//	Here we create an FlxGroup containing 40 FlxEmitters, all the same, used when the aliens are shot/explode
			for (var i:int = 0; i < 40; i++)
			{
				var tempPixel:FlxEmitter = new FlxEmitter();
				tempPixel.setSize(8, 8);
				tempPixel.gravity = 200;
				tempPixel.setXSpeed(-50, 50);
				tempPixel.setYSpeed( -30, -60);
				tempPixel.setRotation(0, 0);	// VITAL!!!
				//tempPixel.makeParticles(Blood, 10, 0, true, 0);
				
				for (var j: int = 0; j < 100; j++)
				{
					whitePixel = new FlxParticle();
					whitePixel.makeGraphic(2, 2, 0xFFFFFFFF);
					whitePixel.visible = false; //Make sure the particle doesn't show up at (0, 0)
					tempPixel.add(whitePixel);
				}
				
				pixels.add(tempPixel);
			}
			
			add(pixels);
		}
		
		public function explodeBlock(ax:int, ay:int):void
		{
			var pixel:FlxEmitter = FlxEmitter(pixels.getFirstAvailable());
			if (pixel)
			{
				pixel.x = ax;
				pixel.y = ay;
				pixel.start(false, 3, 0.1);
			}
		}
		
	}

}