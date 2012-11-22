package player 
{
	public class RifleSprite extends GunSprite
	{
		[Embed(source = '../../assets/rifle.png')] private var rifleSprite:Class;
		
		public function RifleSprite(bx:int, by:int) 
		{
			super(bx, by);
			
			loadGraphic(rifleSprite, true, true, 20, 10, true);
			addAnimation("fire", [1, 0], 10, false);
		}
		
	}

}