package
{


import org.flixel.*;

public class soundManager
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