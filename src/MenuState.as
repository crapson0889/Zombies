package
{
	
	
	
	import org.flixel.*;
	import player.*;
	import fx.*;
	import zombies.*;
	import levels.*;
	import org.flixel.FlxState;
    import org.flixel.FlxG;
	
	public class MenuState extends FlxState
	{
		
		public var soundButton:FlxButton;
		public var isSound:Boolean = true;
		public function MenuState()
		{
		
		//Registry.sound = true;
		
		var title:FlxText = new FlxText(100, 50, 300, "Zombie Game!");
		title.size = 24;
		add(title);
		
		var startButton:FlxButton = new FlxButton(100, 100, "Start Game", startGame);
        add(startButton);
		
		
		
		add(new FlxText(100, 130, 300, "'A' and 'D' to move left/right \n" + "Spacebar to Jump! \n" + "Mouse Click to shoot!\n" + 
						"Double click the button to turn sound on/off"));
		
		FlxG.mouse.show();
		}
		
		override public function create():void {
			super.create();
			
			Registry.sound = new soundManager;
		}
		
		private function startGame():void
        {
            FlxG.switchState(new PlayState());
        }
		
		public function switchSound():void
		{
			
			if (Registry.sound.sound == false)
			{
				Registry.sound.soundSwitch();
				remove(soundButton, false);
				soundButton = new FlxButton(100, 200, "Sound: " + String(Registry.sound.sound), switchSound);
				add(soundButton);
				isSound = true;
			}
			
			else if (Registry.sound.sound == true) 
			{
				Registry.sound.soundSwitch();
				remove(soundButton, false);
				soundButton = new FlxButton(100, 200, "Sound: " + String(Registry.sound.sound), switchSound);
				add(soundButton);
				isSound = false
			}
		}
		
	}
	
	
}