package player 
{
	public class RocketLauncherSprite extends GunSprite
	{
		[Embed(source = '../../assets/rocketLauncher.png')] private var rocketLauncherSprite:Class;
		
		public function RocketLauncherSprite(bx:int, by:int) 
		{
			super(bx, by);
			
			loadGraphic(rocketLauncherSprite, true, true, 20, 10, true);
			addAnimation("fire", [1, 0], 10, false);
		}
		
	}

}