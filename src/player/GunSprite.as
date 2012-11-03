package player 
{
	import org.flixel.*;
	
	public class GunSprite extends FlxSprite
	{
		[Embed(source = '../../assets/gun.png')] private var gunSpritePNG:Class;
		
		public function GunSprite(bx:Number, by:Number) 
		{
			super(bx, by);
			
			loadGraphic(gunSpritePNG, true, true, 18, 7, true);
			addAnimation("fire", [1, 0], 10, false);
		}
		
		public override function update():void
		{
			facing = Registry.player.sprite.facing;
			if (facing == FlxObject.RIGHT)
			{
				x = Registry.player.sprite.x + 9;
				y = Registry.player.sprite.y + 6;
				origin = new FlxPoint(0, 0);
				angle = FlxU.getAngle(new FlxPoint(Registry.player.sprite.x, Registry.player.sprite.y) , new FlxPoint(FlxG.mouse.x, FlxG.mouse.y)) + 270;
			}
			else {
				x = Registry.player.sprite.x - 13;
				y = Registry.player.sprite.y + 6;
				origin = new FlxPoint(18, 0);
				angle = FlxU.getAngle(new FlxPoint(Registry.player.sprite.x, Registry.player.sprite.y) , new FlxPoint(FlxG.mouse.x, FlxG.mouse.y)) + 90;
			}
		}
		
	}

}