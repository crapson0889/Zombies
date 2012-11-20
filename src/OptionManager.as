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
	}
}