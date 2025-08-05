package;

import sys.FileSystem;
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

class LoadingScreenState extends MusicBeatState
{
    var spinHead:FlxSprite;

    var loadText:FlxSprite;

	override public function create():Void
	{
        var pissBaby:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);
        add(pissBaby);

        spinHead = new FlxSprite().loadGraphic(Paths.image('PIE_EATER'));
        spinHead.screenCenter();
        add(spinHead);

        loadText = new FlxSprite().loadGraphic(Paths.image('ITSLOAD'));
        loadText.screenCenter();
        add(loadText);

        super.create();

        new FlxTimer().start(1.5, function(skyFNF:FlxTimer) go());
	}

	override function update(elapsed:Float)
	{    
        spinHead.angle += elapsed * 75;

		super.update(elapsed);
	}

    function go():Void
    {
        new FlxTimer().start(0.5, function(skyFNF:FlxTimer) LoadingState.loadAndSwitchState(new PlayState()));

    }
}
