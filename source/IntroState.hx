package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.system.ui.FlxSoundTray;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;
import openfl.Assets;
#if desktop
import Discord.DiscordClient;
#end

using StringTools;

class IntroState extends MusicBeatState
{
    var logo:FlxSprite;

    var hasTimerStarted:Bool = false;

	override public function create():Void
	{
        logo = new FlxSprite();
        logo.frames = Paths.getSparrowAtlas('startup');
        logo.animation.addByPrefix('intro', 'startup yes', 30, false);
        logo.screenCenter();
        logo.alpha = 0;
        add(logo);
        logo.animation.play('intro');
        FlxTween.tween(logo, {alpha: 1}, 0.75);
        FlxG.sound.play(Paths.sound('junk'));
		super.create();
	}

	override function update(elapsed:Float)
	{    
		if (FlxG.keys.justPressed.F)
		{
			FlxG.fullscreen = !FlxG.fullscreen;
		}

        if(!hasTimerStarted)
        {
            new FlxTimer().start(5, function(tmr:FlxTimer){
                FlxG.switchState(new TitleState());
            }); 
        }

		super.update(elapsed);
	}
}
