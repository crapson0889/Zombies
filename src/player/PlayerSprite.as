package player
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	public class PlayerSprite extends FlxSprite
	{
		[Embed(source = '../../assets/rick.png')] private var playerPNG:Class;
		
		public var gun:FlxWeapon;
		
		public function PlayerSprite(bx:uint, by:uint)
		{
			//	As this extends FlxSprite we need to call super() to ensure all of the parent variables we need are created
			super(bx, by);
			
			//	Load the player.png into this sprite.
			//	The 2nd parameter tells Flixel it's a sprite sheet and it should chop it up into 16x18 sized frames.
			loadGraphic(playerPNG, true, true, 18, 21, true);
			
			//	The sprite is 16x18 in size, but that includes a little feather of hair on its head which we don't want to include in collision checks.
			//	We also shave 2 pixels off each side to make it slip through gaps easier. Changing the width/height does NOT change the visual sprite, just the bounding box used for physics.
			width = 14;
			height = 20;
			
			//	Because we've shaved a few pixels off, we need to offset the sprite to compensate
			offset.x = 2;
			offset.y = 2;
			
			//	The Animation sequences we need
			addAnimation("idle", [7], 0, false);
			addAnimation("walk", [0, 1, 2, 3, 4, 5], 10, true);
			addAnimation("jump", [1], 0, false);
			addAnimation("hurt", [4], 0, false);
			
			//	By default the sprite is facing to the right.
			//	Changing this tells Flixel to flip the sprite frames to show the left-facing ones instead.
			facing = FlxObject.RIGHT;
		}
		
		override public function update():void
		{
			super.update();
			
			if (touching == FlxObject.FLOOR)
			{
				if (velocity.x != 0)
				{
					play("walk");
				}
				else
				{
					play("idle");
				}
			}
			else if (velocity.y < 0)
			{
				play("jump");
			}
		}
	}
}