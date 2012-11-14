package player 
{
	public class PlayerWeaponUzi extends PlayerWeapon
	{
		
		public function PlayerWeaponUzi(name:String)
		{
			super(name);
			
			damage = 3;
			automatic = true;
			setFireRate(75);
		}
		
	}

}