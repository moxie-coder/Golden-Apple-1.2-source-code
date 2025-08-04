package;

import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.FlxG;

class ElfState extends MusicBeatState
{
    override function create()
    {
        var elf = new FlxSprite();
		elf.frames = Paths.getSparrowAtlas('THE BEST EVER/untitled');
		elf.animation.addByPrefix('idle', 'MY BALDI BASICS PLUS PRO GAMES', 24, true);
		elf.animation.play('idle');
		elf.scale.set(5, 5);
		elf.screenCenter();
		elf.antialiasing = false;
		elf.alpha = 0;
		add(elf);
		FlxTween.tween(elf, {alpha: 1}, 2.5, {startDelay: 0.5});
    }

    override function update(t:Float) {
        super.update(t);
        if (FlxG.keys.justPressed.ANY) FlxG.switchState(new MainMenuState());
    }
}