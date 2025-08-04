package;

import flixel.FlxG;
import flixel.FlxSprite;

class GetBackState extends MusicBeatState
{
    override function create()
    {
        var what = new FlxSprite().loadGraphic(Paths.image('THE BEST EVER/deepfried_1643709576501'));
        what.antialiasing = false;
        what.setGraphicSize(1280);
        what.updateHitbox();
        what.screenCenter();
        add(what);
        super.create();
    }

    override function update(t:Float) {
        if(FlxG.keys.justPressed.ANY)
            FlxG.switchState(new PlayState());
        super.update(t);
    }
}