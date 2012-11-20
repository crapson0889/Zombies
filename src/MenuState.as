package
{
	import adobe.utils.CustomActions;
	import org.flixel.*;
	import player.*;
	import fx.*;
	import zombies.*;
	import levels.*;
	import org.flixel.FlxState;
    import org.flixel.FlxG;
	
	public class MenuState extends FlxState
	{
		
		private var soundButton:FlxButton;
		private var loggingButton:FlxButton;
		
		public function MenuState()
		{	
			super();
		}
		
		override public function create():void 
		{
			super.create();
			
			Registry.options = new OptionManager;
			
			var title:FlxText = new FlxText(100, 50, 300, "Zombie Game!");
			title.size = 24;
			add(title);
			
			var startButton:FlxButton = new FlxButton(100, 100, "Start Game", startGame);
			add(startButton);
			
			add(new FlxText(100, 130, 300, "'A' and 'D' to move left/right \n" + "Spacebar to Jump! \n" + "Mouse Click to shoot!\n" + 
			"Click the button to turn sound on/off \n Green = on, Red = off"));
			
			soundButton = new FlxButton(100, 200, "Sound: " + String(Registry.options.sound), Registry.options.soundSwitch);
			add(soundButton);
			
			loggingButton = new FlxButton(100, 230, "Logging: " + String(Registry.options.logging), Registry.options.loggingSwitch);
			add(loggingButton);
			
			FlxG.mouse.show();
		}
		
		private function startGame():void
        {
			var gameState:PlayState = new PlayState();
			
            FlxG.switchState(gameState);
        }
		
		override public function update():void
		{
			super.update();
			
			soundButton.label = new FlxText(soundButton.x - 2, soundButton.y + 4, soundButton.width, "Sound: " + String(Registry.options.sound));
			soundButton.label.setFormat(null, 8, 0x555555, "center");
			
			loggingButton.label = new FlxText(loggingButton.x - 2, loggingButton.y + 4, loggingButton.width, "Logging: " + String(Registry.options.logging));
			loggingButton.label.setFormat(null, 8, 0x555555, "center");
		}	
	}
}