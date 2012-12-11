package
{
	import org.flixel.*;

	public class OptionManager
	{
		[Embed(source = "../assets/sounds/ZombiesTitle.mp3")] public var MusicMode:Class;
		
		public var sound:Boolean;
		public var logging:Boolean;
		
		public function OptionManager() {
			sound = true;
			logging = false;
		}
		
		public function soundSwitch():void
		{
			if (!Registry.musicIsOn)
			{
				if(Registry.options.sound)
					FlxG.playMusic(MusicMode);
				Registry.musicIsOn = true;
			}
			else
			{
				Registry.musicIsOn = false;
				FlxG.music.stop();
			}
			sound = !sound;
		}
		
		public function loggingSwitch():void 
		{
			logging = !logging;
		}
		
		public function soundString():String
		{
			if (sound)
				return "On";
			else
				return "Off";
		}
		
		public function loggingString():String
		{
			if (logging)
				return "On";
			else
				return "Off";
		}
	}
}