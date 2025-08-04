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
import io.newgrounds.NG;
import lime.app.Application;
import openfl.Assets;
#if desktop
import Discord.DiscordClient;
#end

using StringTools;

class StartupState extends MusicBeatState
{

    var spinHead:FlxSprite;

    var loadText:FlxSprite;

    var hasSuckedMyCock:Bool = false;

    //I'd say any song around 4:00+ goes here.
    var preloadSongs:Array<String> = ['Algebra', 'AppleCore', 'Deformation', 'RECOVERED-PROJECT', 'Ferocious'];

    var howManyItemsToPreload:Int = 0;

    var _percent:Float = 0;

    var transitioning:Bool = false;

    public static var initialized:Bool = false;

	override public function create():Void
	{
        FlxG.save.bind('gappleMain', 'Team Gapple');

        SaveDataHandler.initSave();

        //Main.toggleCounterVisible(FlxG.save.data.counterVis);

        PlayerSettings.init();
        if(!initialized)
        {
            #if desktop
            DiscordClient.initialize();
            #end
    
            var diamond:FlxGraphic = FlxGraphic.fromClass(GraphicTransTileDiamond);
            diamond.persist = true;
            diamond.destroyOnNoUse = false;
    
            FlxTransitionableState.defaultTransIn = new TransitionData(FADE, FlxColor.BLACK, 1, new FlxPoint(-1, 0), {asset: diamond, width: 32, height: 32},
                new FlxRect(-200, -200, FlxG.width * 1.42, FlxG.height * 4.2));
            FlxTransitionableState.defaultTransOut = new TransitionData(FADE, FlxColor.BLACK, 0.7, new FlxPoint(1, 0),
                {asset: diamond, width: 32, height: 32}, new FlxRect(-200, -200, FlxG.width * 1.42, FlxG.height * 4.2));
    
            transIn = FlxTransitionableState.defaultTransIn;
            transOut = FlxTransitionableState.defaultTransOut;

            initialized = true;
        }

        if(FlxG.save.data.hasPlayedPastV1 == null)
        {
            FlxG.save.erase();
            
            FlxG.save.bind('gappleMain', 'Team Gapple');

            FlxG.save.data.hasPlayedPastV1 = true;

            SaveDataHandler.initSave();
    
            //Main.toggleCounterVisible(FlxG.save.data.counterVis);
    
            PlayerSettings.init();
        }

        if(FlxG.save.data.preloadAtStartup == null)
        {
            FlxG.switchState(new DoYouWannaUsePreloadingOrNotState());
        }

        var pissBaby:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);
        add(pissBaby);

        spinHead = new FlxSprite().loadGraphic(Paths.image('PIE_EATER'));
        spinHead.screenCenter();
        add(spinHead);

        loadText = new FlxSprite().loadGraphic(Paths.image('ITSLOAD'));
        loadText.screenCenter();
        add(loadText);

        super.create();

        var doPreload:Bool = FlxG.save.data.preloadAtStartup;

        howManyItemsToPreload = (preloadSongs.length * 2);

        if(!doPreload)
        {
            _percent = 100;
        }
        else
        {
            new FlxTimer().start(1.5, function(skyFNF:FlxTimer) preload());
            
        }
	}

	override function update(elapsed:Float)
	{    
		if (FlxG.keys.justPressed.F)
		{
			FlxG.fullscreen = !FlxG.fullscreen;
		}

        if (_percent >= 99.99 && !transitioning) 
        {
            transitioning = true;
            trace('FINISHED PRELOADING! ! !');
            new FlxTimer().start(1.5, function(tmr:FlxTimer){
                FlxG.switchState(new IntroState());
            }); 
        }

        spinHead.angle += elapsed * 75;

		super.update(elapsed);
	}

    function preload():Void
    {
        for (song in preloadSongs)
        {
            trace('PRELOADING SONG ' + song.toUpperCase());
            FlxG.sound.cache(Paths.inst(song));
            FlxG.sound.cache(Paths.voices(song));
            //_percent += 100 / (preloadSongs.length * 2);
        }
        _percent = 100;
    }
}
