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
import Controls.KeyboardScheme;
import openfl.Assets;
#if desktop
import Discord.DiscordClient;
#end

using StringTools;

class TitleState extends MusicBeatState
{
	public static var initialized:Bool = false;

	var blackScreen:FlxSprite;
	var credGroup:FlxGroup;
	var credTextShit:Alphabet;
	var textGroup:FlxGroup;
	var ngSpr:FlxSprite;

	var curWacky:Array<String> = [];

	var wackyImage:FlxSprite;

	var titleDude:FlxSprite;

	var altIdle:Bool = false;

	var fun:Int;

	var danced:Bool = false;

	override public function create():Void
	{
		// pissy deez
		/*fun = FlxG.random.int(0, 999);
			if(fun == 1)
			{
				LoadingState.loadAndSwitchState(new SusState());
		}*/

		curWacky = FlxG.random.getObject(getIntroTextShit());

		super.create();

		new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			startIntro();
		});
	}

	var logoBl:FlxSprite;
	var titleText:FlxSprite;

	function startIntro()
	{
		if (!initialized)
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);

			FlxG.sound.music.fadeIn(4, 0, 0.7);
		}

		Conductor.changeBPM(150);
		persistentUpdate = true;

		Controls.initControls();
		PlayerSettings.init();
		controls.setKeyboardScheme(KeyboardScheme.Solo, true);

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(bg);

		logoBl = new FlxSprite(-185, -430);
		logoBl.frames = Paths.getSparrowAtlas('logoBumpin');
		logoBl.antialiasing = true;
		logoBl.animation.addByIndices('bumpLeft', 'logo bumpin', [for (i in 0...14) i], '', 24, false);
		logoBl.animation.addByIndices('bumpRight', 'logo bumpin', [for (i in 15...29) i], '', 24, false);
		logoBl.animation.play('bumpLeft');
		logoBl.scale.set(0.75, 0.75);
		logoBl.updateHitbox();

		logoBl.screenCenter();
		logoBl.x += 335;
		logoBl.y -= 75;

		logoBl.x += 500;

		logoBl.scale.set(0.85, 0.85);

		titleDude = new FlxSprite(-150, 1000);
		titleDude.frames = Paths.getSparrowAtlas('golden_apple_title_guys');
		var fuckingStupid:Int = FlxG.random.int(0, 999);
		if (fuckingStupid == 0)
		{
			altIdle = true;
		}
		titleDude.animation.addByIndices('idle-alt-false', 'ALT-IDLE', [0, 1, 2, 3, 4, 5, 6], '', 24, false);
		titleDude.animation.addByIndices('idle-false', 'IDLE', [0, 1, 2, 3, 4, 5, 6], '', 24, false);

		titleDude.animation.addByIndices('idle-alt-true', 'ALT-IDLE', [6, 5, 4, 3, 2, 1, 0], '', 24, false);
		titleDude.animation.addByIndices('idle-true', 'IDLE', [6, 5, 4, 3, 2, 1, 0], '', 24, false);

		if (altIdle)
		{
			titleDude.animation.play('idle-alt-true');
		}
		else
		{
			titleDude.animation.play('idle-true');
		}
		add(titleDude);

		add(logoBl);

		titleText = new FlxSprite(100, FlxG.height * 0.8);
		titleText.frames = Paths.getSparrowAtlas('titleEnter');
		titleText.animation.addByPrefix('idle', "Press Enter to Begin", 24);
		titleText.animation.addByPrefix('press', "ENTER PRESSED", 24);
		titleText.antialiasing = true;
		titleText.animation.play('idle');
		titleText.updateHitbox();
		add(titleText);

		credGroup = new FlxGroup();
		add(credGroup);
		textGroup = new FlxGroup();

		blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		credGroup.add(blackScreen);

		credTextShit = new Alphabet(0, 0, "MoldyGH\nMissingTextureMan101\nRapparep\nKrisspo\nTheBuilder\nCyndaquilDAC\nT5mpler\nErizur", true);
		credTextShit.screenCenter();

		// credTextShit.alignment = CENTER;

		credTextShit.visible = false;

		ngSpr = new FlxSprite(0, FlxG.height * 0.52).loadGraphic(Paths.image('newgrounds_logo'));
		add(ngSpr);
		ngSpr.visible = false;
		ngSpr.setGraphicSize(Std.int(ngSpr.width * 0.8));
		ngSpr.updateHitbox();
		ngSpr.screenCenter(X);
		ngSpr.antialiasing = true;

		FlxTween.tween(credTextShit, {y: credTextShit.y + 20}, 2.9, {ease: FlxEase.quadInOut, type: PINGPONG});

		FlxG.mouse.visible = false;

		if (initialized)
			skipIntro();
		else
			initialized = true;

		createCoolText(['Created by people like:']);

		// credGroup.add(credTextShit);
	}

	function getIntroTextShit():Array<Array<String>>
	{
		var fullText:String = Assets.getText(Paths.txt('introText'));

		var firstArray:Array<String> = fullText.split('\n');
		var swagGoodArray:Array<Array<String>> = [];

		for (i in firstArray)
		{
			swagGoodArray.push(i.split('--'));
		}

		return swagGoodArray;
	}

	var transitioning:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;
		// FlxG.watch.addQuick('amp', FlxG.sound.music.amplitude);

		var pressedEnter:Bool = FlxG.keys.justPressed.ENTER;

		#if mobile
		for (touch in FlxG.touches.list)
		{
			if (touch.justPressed)
			{
				pressedEnter = true;
			}
		}
		#end

		var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

		if (gamepad != null)
		{
			if (gamepad.justPressed.START)
				pressedEnter = true;

			#if switch
			if (gamepad.justPressed.B)
				pressedEnter = true;
			#end
		}

		if (pressedEnter && !transitioning && skippedIntro)
		{
			titleText.animation.play('press');

			FlxG.camera.flash(FlxColor.WHITE, 1);
			FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);

			transitioning = true;
			// FlxG.sound.music.stop();

			new FlxTimer().start(2, function(tmr:FlxTimer)
			{
				FlxG.switchState(OutdatedSubState.leftState ? new MainMenuState() : new OutdatedSubState());
			});
			// FlxG.sound.play(Paths.music('titleShoot'), 0.7);
		}

		if (pressedEnter && !skippedIntro)
		{
			skipIntro();
		}

		super.update(elapsed);
	}

	function createCoolText(textArray:Array<String>)
	{
		for (i in 0...textArray.length)
		{
			var money:FlxText = new FlxText(0, 0, FlxG.width, textArray[i], 48);
			money.setFormat("Comic Sans MS Bold", 48, FlxColor.WHITE, CENTER);
			money.screenCenter(X);
			money.y += (i * 60) + 200;
			credGroup.add(money);
			textGroup.add(money);
		}
	}

	function addMoreText(text:String)
	{
		var coolText:FlxText = new FlxText(0, 0, FlxG.width, text, 48);
		coolText.setFormat("Comic Sans MS Bold", 48, FlxColor.WHITE, CENTER);
		coolText.screenCenter(X);
		coolText.y += (textGroup.length * 60) + 200;
		credGroup.add(coolText);
		textGroup.add(coolText);
	}

	function deleteCoolText()
	{
		while (textGroup.members.length > 0)
		{
			credGroup.remove(textGroup.members[0], true);
			textGroup.remove(textGroup.members[0], true);
		}
	}

	override function stepHit()
	{
		super.stepHit();
		if (curStep % 2 == 0)
		{
			stupid++;
			altIdle ? titleDude.animation.play('idle-alt-${stupid % 2 == 0}', true) : titleDude.animation.play('idle-${stupid % 2 == 0}', true);
		}
	}

	var stupid:Int = 0;

	override function beatHit()
	{
		super.beatHit();

		if (curBeat % 2 == 0)
		{
			if (danced)
			{
				logoBl.animation.play('bumpRight', true);
			}
			else
			{
				logoBl.animation.play('bumpLeft', true);
			}
		}

		danced = !danced;

		FlxG.log.add(curBeat);

		switch (curBeat)
		{
			case 2:
				addMoreText('Grantare\nLancey\nCynda\nRubysArt_');
			case 3:
				addMoreText('and the wonderful contributors!');
			case 4:
				deleteCoolText();
			case 5:
				createCoolText(['Special Thanks to:']);
			case 6:
				addMoreText('The VS. Dave and Bambi Team');
			case 7:
				addMoreText('and you, for playing our mod!');
			case 8:
				deleteCoolText();
				ngSpr.visible = false;
			case 9:
				createCoolText([curWacky[0]]);
			case 10:
				addMoreText(curWacky[1]);
			case 11:
				deleteCoolText();
			case 12:
				addMoreText("Friday Night Funkin'");
			case 13:
				addMoreText('VS. Dave and Bambi:');
			case 14:
				addMoreText('Golden Apple');
			case 15:
				deleteCoolText();
			case 16:
				skipIntro();
		}
	}

	var skippedIntro:Bool = false;

	function skipIntro():Void
	{
		if (!skippedIntro)
		{
			remove(ngSpr);

			FlxG.camera.flash(FlxColor.WHITE, 4);
			remove(credGroup);
			FlxTween.tween(titleDude, {y: -50}, 1, {ease: FlxEase.expoInOut});
			FlxTween.tween(logoBl, {x: logoBl.x - 500}, 1, {ease: FlxEase.expoInOut});
			skippedIntro = true;
		}
	}
}
