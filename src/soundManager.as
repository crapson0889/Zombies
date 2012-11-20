package
{


import org.flixel.*;

public class soundManager extends FlxGroup
{
	public var sound:Boolean;
	
	public function soundManager() {
		sound = true;
	}
	
	public function soundSwitch():void
	{
		sound = !sound;
	}
}



}