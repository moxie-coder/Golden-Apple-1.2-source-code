package;

import flixel.FlxG;
import flixel.FlxSprite;

class PoopState extends MusicBeatState
{
    public static var FOV:Int;
    public static var res:Int;

    public var player:Player;

    override function create()
    {
        player = new Player();
        player.screenCenter();
        add(player);
        add(player.hitbox);
    }

    override function update(t:Float)
    {
        super.update(t);

        player.playerTick();

        FlxG.watch.addQuick("yunk", player.angle);
    }
}