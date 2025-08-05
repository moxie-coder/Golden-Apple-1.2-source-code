package;

import flixel.math.FlxMath;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSubState;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.FlxSprite;
import flixel.tweens.FlxTween;

class GameOverSubstate extends MusicBeatSubstate
{
	var bf:Boyfriend;
	var camFollow:FlxObject;

	var stageSuffix:String = "";

	var volumese:Float = 1;

	var followy:Int = 12;

	var dave:FlxSprite;

	public function new(x:Float, y:Float, char:String)
	{
		var daStage = PlayState.curStage;
		var daBf:String = '';
		switch (char)
		{
			case 'bf-pixel':
				stageSuffix = '-pixel';
			default:
				daBf = 'bf-death';
		}
		if (char == "bf-pixel")
		{
			char = "bf-pixel-dead";
		}
		if (char == '3d-bf' || char == 'shoulder-3d-bf' || char == 'bf-pad')
		{
			if (daStage == 'sunshine' && FlxG.save.data.sensitiveContent)
			{
				char = 'hang-bf';
				volumese = 0;
				followy = 0;
			}
			else
			{
				char = '3d-bf-death';
			}
		}

		super();

		dave = new FlxSprite().loadGraphic(Paths.image('dave/dave'));
		dave.setPosition(1280 - dave.width, 720 - dave.height);
		dave.scrollFactor.set(0, 0);
		dave.alpha = 0;
		add(dave);

		Conductor.songPosition = 0;

		bf = new Boyfriend(x, y, char);
		if (bf.animation.getByName('firstDeath') == null)
		{
			bf = new Boyfriend(x, y, "bf");
		}
		add(bf);

		camFollow = new FlxObject(bf.getGraphicMidpoint().x, bf.getGraphicMidpoint().y, 1, 1);
		add(camFollow);

		if (char == 'hang-bf')
		{
			bf.scrollFactor.set();
			bf.screenCenter();
			FlxG.camera.follow(camFollow, LOCKON, 0.01);
		}

		FlxG.sound.play(Paths.sound('fnf_loss_sfx' + stageSuffix), volumese).onComplete = function baldiDick()
		{
			if (!isEnding)
			{
				FlxG.sound.playMusic(Paths.music('gameOver' + stageSuffix), volumese);
				canBop = true;
			}
		};

		Conductor.changeBPM(100);

		// FlxG.camera.followLerp = 1;
		// FlxG.camera.focusOn(FlxPoint.get(FlxG.width / 2, FlxG.height / 2));
		FlxG.camera.scroll.set();
		FlxG.camera.target = null;

		bf.playAnim('firstDeath');

		var canSelect = true;

		override function update(elapsed:Float)
		{
			FlxG.camera.zoom = FlxMath.lerp(1, FlxG.camera.zoom, 0.95);

			super.update(elapsed);

			if (controls.ACCEPT && canSelect)
			{
				endBullshit();
			}

			if (controls.BACK && canSelect)
			{
				FlxG.sound.music.stop();

				if (PlayState.SONG.song.toLowerCase() == 'disability')
				{
					trace("WUH OH!!!");

					SaveFileState.saveFile.data.foundRecoveredProject = true;

					PlayState.practicing = false;

					PlayState.fakedScore = false;

					PlayState.deathCounter = 0;

					var poop:String = Highscore.formatSong('recovered-project', 1);

					trace(poop);

					PlayState.SONG = Song.loadFromJson(poop, 'recovered-project');
					PlayState.isStoryMode = false;
					PlayState.storyDifficulty = 1;

					PlayState.storyWeek = 1;
					LoadingState.loadAndSwitchState(new PlayState());
				}
				else
					PlayState.practicing = false;

				PlayState.fakedScore = false;

				PlayState.deathCounter = 0;

				FlxG.switchState(new MainMenuState());
			}

			if (bf.animation.curAnim.name == 'firstDeath' && bf.animation.curAnim.curFrame == followy)
			{
				FlxG.camera.follow(camFollow, LOCKON, 0.01);
			}

			if (FlxG.sound.music.playing)
			{
				Conductor.songPosition = FlxG.sound.music.time;
			}
		}

		var canBop:Bool = false;

		override function beatHit()
		{
			super.beatHit();

			if (curBeat % 2 == 0 && canBop && !isEnding)
			{
				bf.playAnim('deathLoop', true);
			}

			FlxG.log.add('beat');
		}

		var isEnding:Bool = false;

		function endBullshit():Void
		{
			if (!isEnding)
			{
				isEnding = true;

				bf.playAnim('deathConfirm', true);
				FlxG.sound.music.stop();
				FlxG.sound.play(Paths.music('gameOverEnd' + stageSuffix), volumese);
				new FlxTimer().start(0.7, function(tmr:FlxTimer)
				{
					FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
					{
						LoadingState.loadAndSwitchState(new PlayState());
					});
				});
			}
		}
	}
