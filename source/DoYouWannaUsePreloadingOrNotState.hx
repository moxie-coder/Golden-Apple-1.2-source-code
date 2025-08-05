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

class DoYouWannaUsePreloadingOrNotState extends MusicBeatState
{
    var transitioning:Bool = false;

	override public function create():Void
	{
        super.create();
        var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(bg);
		var txt:FlxText = null;

		txt = new FlxText(0, 0, FlxG.width,
				"Hello!\nThis mod has a preloading system.\nPress Y to enable it, or press N to disable it.",
				32);
		txt.setFormat("Comic Sans MS Bold", 32, FlxColor.WHITE, CENTER);
		txt.screenCenter();
		txt.antialiasing = true;
		add(txt);
	}

	override function update(elapsed:Float)
	{
        if(FlxG.keys.justPressed.Y && !transitioning)
        {
            transitioning = true;
            FlxG.save.data.preloadAtStartup = true;
			FlxG.save.data.preloadAtAll = true;
			FlxG.save.flush();
            FlxG.switchState(new StartupState());
        }
        else if(FlxG.keys.justPressed.N && !transitioning)
        {
            transitioning = true;
			FlxG.save.data.preloadAtStartup = false;
			FlxG.save.data.preloadAtAll = false;
			FlxG.save.flush();
            FlxG.switchState(new StartupState());
        }

		super.update(elapsed);
	}
}
