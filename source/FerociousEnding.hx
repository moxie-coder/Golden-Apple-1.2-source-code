package;

import flixel.effects.FlxFlicker;
import flixel.math.FlxMath;
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

class FerociousEnding extends MusicBeatState
{
    var rankTextLol:FlxText;
    var accText:FlxText;

    var acc:Float = 100;
    var accLerp:Float = 0;

    var txtTween:FlxTween;

    var flixelBeLike:FlxSprite;

    var whatWasTextLastFrame:String = 'F';

    var accepted:Bool = false;

    override public function new(acc:Float) 
    {
        this.acc = acc;
        super();    
    }

	override public function create():Void
	{
        FlxG.sound.playMusic(Paths.music('ferociousDialogue', 'shared'));

        var penisDick:FlxSprite = new FlxSprite().loadGraphic(Paths.image('funnyAnimal/end', 'shared'));
        penisDick.scale.set(0.525, 0.525);
        penisDick.updateHitbox();
        penisDick.screenCenter();
        add(penisDick);

        rankTextLol = new FlxText(0, 0, FlxG.width, 'F', 300);
        rankTextLol.setFormat('Comic Sans MS Bold', 300, FlxColor.BLACK, CENTER);
        rankTextLol.screenCenter();
        rankTextLol.y -= 10;
        //add(rankTextLol);

        accText = new FlxText(0, rankTextLol.y + rankTextLol.height + 30, FlxG.width, '0% Accuracy', 22);
        accText.setFormat('Comic Sans MS Bold', 64, FlxColor.BLACK, CENTER);
        accText.screenCenter(X);
        //add(accText);

        super.create();
	}

	override function update(elapsed:Float)
	{    
		super.update(elapsed);

        accLerp = FlxMath.lerp(acc, accLerp, 0.975);

        accText.text = Std.string(FlxMath.roundDecimal(accLerp, 1)) + '% Accuracy';

        if(accLerp >= 90)
        {
            rankTextLol.text = 'S';
        }
        else if(accLerp >= 70)
        {
            rankTextLol.text = 'A';
        }
        else if(accLerp >= 50)
        {
            rankTextLol.text = 'B';
        }
        else if(accLerp >= 40)
        {
            rankTextLol.text = 'C';
        }
        else if(accLerp >= 25)
        {
            rankTextLol.text = 'D';
        }
        else
        {
            rankTextLol.text = 'F';
        }

        if(whatWasTextLastFrame != rankTextLol.text)
        {
            whatWasTextLastFrame = rankTextLol.text;

			if(txtTween != null) 
			{
				txtTween.cancel();
			}

			rankTextLol.scale.x = 1.1;
			rankTextLol.scale.y = 1.1;
			txtTween = FlxTween.tween(rankTextLol.scale, {x: 1, y: 1}, 0.2, {
				onComplete: function(twn:FlxTween) {
					txtTween = null;
				}
			});
        }

        if(controls.ACCEPT && !accepted)
        {
            accepted = true;
            FlxG.camera.flash();
            FlxG.sound.music.stop();
            FlxG.sound.play(Paths.sound('confirmMenu'));
            FlxG.switchState(new MainMenuState());
        }
	}
}
