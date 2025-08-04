package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxTimer;

class StaringContestState extends MusicBeatState {

    var garrett:FlxSprite;
    var text1:FlxSprite;
    var text2:FlxSprite;

    var junksToLoad:Array<String> = ['garrett-animal', 'playtime-2', 'paloose-men', 'bf-pad', 'garrett-pad', 'wizard', 'do-you-accept', 'mr-music', 'car', 'garrett-piss'];

    override function create()
    {
        FlxG.sound.music.stop();

        SaveFileState.saveFile.data.ferociousFound = true;

        add(new FlxSprite().makeGraphic(1280, 720, 0xff2BFFA3));

        garrett = new FlxSprite().loadGraphic(Paths.image('funnyAnimal/fat_guy'));
        garrett.screenCenter();
        add(garrett);

        text1 = new FlxSprite().loadGraphic(Paths.image('funnyAnimal/staringContest'));
        text1.screenCenter(X);
        add(text1);

        text2 = new FlxSprite().loadGraphic(Paths.image('funnyAnimal/canYouBeat'));
        text2.y = FlxG.height - text2.height;
        text2.screenCenter(X);
        add(text2);

        super.create();

        new FlxTimer().start(1, function(tmr:FlxTimer){
            if (junksToLoad.length <= 0) {
                garrett.loadGraphic(Paths.image('funnyAnimal/obese_guy'));
                text1.loadGraphic(Paths.image('funnyAnimal/hooray'));
                text1.screenCenter(X);
                text1.y = text2.y + 100;
                text2.visible = false;

                FlxG.sound.play(Paths.sound('win'));
                new FlxTimer().start(1.5, function(tmr2:FlxTimer){
                    LoadingState.loadAndSwitchState(new PlayState(), false, false);
                });
            } else {
                add(new Character(1280, 1280, junksToLoad[0]));
                junksToLoad.remove(junksToLoad[0]);
                tmr.reset(1);
            }
        });
    }
}