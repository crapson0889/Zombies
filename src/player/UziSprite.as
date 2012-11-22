package player 
{
	public class UziSprite extends GunSprite
	{
		[Embed(source = '../../assets/uzi.png')] private var uziSprite:Class;
		
		public function UziSprite(bx:int, by:int) 
		{
			super(bx, by);
			
			loadGraphic(uziSprite, true, true, 20, 10, true);
			addAnimation("fire", [1, 0], 10, false);
		}
		
	}

}