package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;

class Player extends FlxSprite
{
	public var hitbox:FlxSprite;

	public function new(x:Int = 0, y:Int = 0)
	{
		super(x, y);
		loadGraphic(Paths.image('yunk/costume4'));
		scale.set(1.5, 1.5);
		centerOffsets();
		hitbox = new FlxSprite().loadGraphic(Paths.image('yunk/costume2'));
		hitbox.alpha = 0;
		hitbox.centerOffsets();
	}

	public function playerTick()
	{
		if (FlxG.keys.pressed.LEFT)
			angle -= 5;
		if (FlxG.keys.pressed.RIGHT)
			angle += 5;
		if (FlxG.keys.pressed.UP)
			// move(0.5);
			x += 10;
		if (FlxG.keys.pressed.DOWN)
			move(-0.5);
	}

	public function move(steps:Float)
	{
		tryMove(steps * Math.sin((angle + 90) % 360));
		tryMove(0, steps * Math.cos((angle + 90) % 360));
	}

	public function tryMove(dx:Float = 0, dy:Float = 0)
	{
		x += dx;
		y += dy;
	}
}
