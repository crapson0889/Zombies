package
{
	import org.flixel.*;

	public class OptionManager
	{
		public var sound:Boolean;
		public var logging:Boolean;
		
		public function OptionManager() {
			sound = true;
			logging = false;
		}
		
		public function soundSwitch():void
		{
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