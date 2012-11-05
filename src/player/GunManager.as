package player 
{
	
	/*
	 * This is a work in progress right now, but the idea is to use this class for fast swapping of the guns the player is using. 
	 * Basically all one would need to do is change currentGun and the gun will change, but the references for the gun would be
	 * able to stay the same.
	 * */
	
	import org.flixel.*;
	
	public class GunManager
	{
		
		private var gunHolder:Array;
		private var gunSpriteHolder:Array;
		private var currentGun:uint = 0;
		
		public function GunManager() 
		{
			gunHolder = new Array;
			gunSpriteHolder = new Array;
			
			gun = new PlayerWeapon("gun");
			gunHolder.push(gun.group);
			
			gunSprite = new GunSprite(Registry.player.sprite.x, Registry.player.sprite.y);
			gunSpriteHolder.push(gunSprite);
		}
		
		public function gun():PlayerWeapon
		{
			return gunHolder[currentGun];
		}
		
		public function sprite():GunSprite
		{
			return gunSpriteHolder[currentGun];
		}
		
	}

}