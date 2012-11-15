package fx
{
	/*
	 * Handles multiple splatters in the game, because there is more than one zombie to kill
	 * */
	import flash.display.InteractiveObject;
	import org.flixel.*;
	
	public class ExplosionManager extends FlxGroup
	{
		private var explosionCount:int = 0;
		
		public function ExplosionManager() 
		{
			super();
			
			for (var i:int = 0; i < Registry.zombieCount; i++)
			{
				add(new Explosion());
			}
		}
		
		public function explode(x:Number, y:Number, bullet:FlxPoint, gun:FlxPoint):void
		{	
			var explosion:Explosion = members[explosionCount];
			
			//explosion.setDirection(bullet, gun);
			explosion.x = x;
			explosion.y = y;
			explosion.setSize(16, 16);
			explosion.start(true, 3, 0.01);
			explosion.lifespan = 1;
			
			explosionCount++;
			if (explosionCount == Registry.zombieCount)
			{
				explosionCount = 0;
			}
		}
		
		
}

}