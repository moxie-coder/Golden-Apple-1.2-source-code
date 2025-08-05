package;

import flixel.math.FlxMath;
import flixel.math.FlxRandom;
import flixel.math.FlxPoint;
import Controls.KeyboardScheme;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
#if desktop
import Discord.DiscordClient;
#end

using StringTools;

class PlayMenuState extends MusicBeatState
{
	var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;

	var baldisHotCock:Int = 1;

	var optionShit:Array<String> = ['disruption', 'applecore', 'disability', 'wireframe', 'algebra', 'deformation', 'ferocious', 'extras'];

	var newGaming:FlxText;
	var newGaming2:FlxText;
	var newInput:Bool;

	public static var firstStart:Bool = true;

	public static var finishedFunnyMove:Bool = false;

	public static var daRealEngineVer:String = 'Golden Apple';

	public static var engineVers:Array<String> = ['Golden Apple'];

	public static var kadeEngineVer:String = "Golden Apple";
	public static var gameVer:String = "1.2 ";

	var lerpScore:Int = 0;
	var intendedScore:Int = 0;

	var bg:FlxSprite;

	var magenta:FlxSprite;
	var camFollow:FlxObject;
	public static var bgPaths:Array<String> = 
	[
		'backgrounds/biorange',
		'backgrounds/cudroid',
		'backgrounds/dreambean',
		'backgrounds/roflcopter',
		'backgrounds/seth',
		'backgrounds/vio',
		'backgrounds/zevisly'
	];

	override function create()
	{
		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
			Conductor.changeBPM(150);
		}

		persistentUpdate = persistentDraw = true;
		
		if (FlxG.save.data.eyesores == null)
		{
			FlxG.save.data.eyesores = true;
		}

		#if desktop
		DiscordClient.changePresence("In the Menus", null);
		#end
		
		if (FlxG.save.data.unlockedcharacters == null)
		{
			FlxG.save.data.unlockedcharacters = [true,true,false,false,false,false];
		}

		daRealEngineVer = engineVers[FlxG.random.int(0, 0)];
		
		bg = new FlxSprite(-80).loadGraphic(Paths.image('menu/${optionShit[0]}'));
		bg.scrollFactor.set();
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		bg.color = 0xFFFDE871;
		add(bg);

		magenta = new FlxSprite(-80).loadGraphic(bg.graphic);
		magenta.scrollFactor.set();
		magenta.setGraphicSize(Std.int(magenta.width * 1.1));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.antialiasing = true;
		magenta.color = 0xFFfd719b;
		add(magenta);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		FlxG.camera.follow(camFollow, null, 0.32);
		
		camFollow.setPosition(640, 150.5);
		for (i in 0...optionShit.length)
		{
			var theFuckingOption:String = optionShit[i];
			if(theFuckingOption == 'spppoooookeeeeyyyy' && !SaveFileState.saveFile.data.elfDiscovered)
			{
				optionShit[i] = 'unknown';
				theFuckingOption = 'unknown';
			}
			var tex = Paths.getSparrowAtlas('buttons/' + optionShit[i]);
			var menuItem:FlxSprite = new FlxSprite(0, FlxG.height * 1.6);
			menuItem.frames = tex;
			menuItem.animation.addByPrefix('idle', theFuckingOption + " basic", 24);
			menuItem.animation.addByPrefix('selected', theFuckingOption + " white", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			menuItem.screenCenter(X);
			menuItems.add(menuItem);
			menuItem.scrollFactor.set(0, 1);
			menuItem.antialiasing = true;
			menuItem.y = 60 + (i * 160);
			if (firstStart)
			{
				menuItem.y += 2000;
				FlxTween.tween(menuItem,{y: 60 + (i * 160)},1 + (i * 0.25) ,{ease: FlxEase.expoInOut, onComplete: function(flxTween:FlxTween) 
					{
						finishedFunnyMove = true; 
						changeItem();
					}});
			}
		}

		firstStart = false;

		var versionShit:FlxText = new FlxText(5, (FlxG.height * 0.9) + 44, 0, gameVer + daRealEngineVer + " Engine", 16);
		versionShit.scrollFactor.set();
		versionShit.setFormat("Comic Sans MS Bold", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		// NG.core.calls.event.logEvent('swag').send();


		controls.setKeyboardScheme(KeyboardScheme.Solo, true);

		changeItem();

		updateDiffies();

		super.create();
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}
		Conductor.songPosition = FlxG.sound.music.time;

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.screenCenter(X);
		});

		if (!selectedSomethin)
		{
			if (controls.UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (controls.DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			if (controls.BACK || FlxG.keys.justPressed.BACKSPACE)
			{
				FlxG.switchState(new MainMenuState());
			}

			if (controls.ACCEPT || FlxG.keys.justPressed.ENTER)
			{
				selectedSomethin = true;

				var theFuckingOption:String = optionShit[curSelected];
				if(theFuckingOption == 'ferocious' && !SaveFileState.saveFile.data.ferociousFound)
				{
					//theFuckingOption = 'unknown';
				}

				if(theFuckingOption == 'unknown')
				{
					trace('my piss is blood');
					FlxG.camera.shake(0.05, Conductor.stepCrochet / 1000, null, true);
					selectedSomethin = false;
					return;
				}

				magenta.loadGraphic(bg.graphic);
				magenta.setGraphicSize(1280);
				magenta.updateHitbox();
				magenta.screenCenter();

				if(theFuckingOption != 'unknown')
				{
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxFlicker.flicker(magenta, 1.1, 0.15, false);
				}

				FlxTween.tween(difficultyImg, {alpha: 0}, 1.3, {
					ease: FlxEase.quadOut,
					onComplete: function(twn:FlxTween)
					{
						difficultyImg.kill();
					}
				});

				menuItems.forEach(function(spr:FlxSprite)
				{
					if (curSelected != spr.ID && theFuckingOption != 'unknown')
					{
						FlxTween.tween(spr, {alpha: 0}, 1.3, {
							ease: FlxEase.quadOut,
							onComplete: function(twn:FlxTween)
							{
								spr.kill();
							}
						});
					}
					else
					{
						FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
						{
							var daChoice:String = optionShit[curSelected];
							switch (daChoice)
							{
								case 'extras':
									FlxG.switchState(new ExtraCategorySelect());
								case 'ferocious':
									SaveFileState.saveFile.data.playedFerocious = true;
									
									var poop:String = Highscore.formatSong(daChoice, 1);

									trace(poop);
						
									PlayState.SONG = Song.loadFromJson(poop, daChoice);
									PlayState.isStoryMode = false;
									PlayState.storyDifficulty = 1;
									PlayState.xtraSong = false;
									PlayState.practicing = false;
			
									PlayState.fakedScore = false;
							
									PlayState.deathCounter = 0;
						
									PlayState.storyWeek = 1;
									PlayState.characteroverride = 'none';
									PlayState.formoverride = 'none';
									LoadingState.loadAndSwitchState(new StaringContestState());
								default:
									var poop:String = Highscore.formatSong(daChoice, 1);

									trace(poop);
						
									PlayState.SONG = Song.loadFromJson(poop, daChoice);
									PlayState.isStoryMode = false;
									PlayState.storyDifficulty = 1;
									PlayState.xtraSong = false;
									PlayState.practicing = false;
			
									PlayState.fakedScore = false;
							
									PlayState.deathCounter = 0;
						
									PlayState.storyWeek = 1;
									PlayState.characteroverride = 'none';
									PlayState.formoverride = 'none';
									LoadingState.loadAndSwitchState(new PlayState());
							}
						});
					}
				});
				
			}
		}

		super.update(elapsed);
	}

	override function beatHit()
	{
		super.beatHit();
		
	}

	function changeItem(huh:Int = 0)
	{
		if (finishedFunnyMove)
		{
			curSelected += huh;

			if (curSelected >= menuItems.length)
				curSelected = 0;
			if (curSelected < 0)
				curSelected = menuItems.length - 1;	
		}

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');

			if (spr.ID == curSelected && finishedFunnyMove)
			{
				spr.animation.play('selected');
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y);
			}

			spr.updateHitbox();
		});

		#if !switch
		intendedScore = Highscore.getScore(optionShit[curSelected], 1);
		#end

		var theFuckingOption:String = optionShit[curSelected];
		if(theFuckingOption == 'ferocious' && !SaveFileState.saveFile.data.ferociousFound)
		{
			theFuckingOption = 'unknown';
		}

		var fuckingCockDickPenis:Int = FlxG.random.int(0, baldisHotCock);
		if(SaveFileState.saveFile.data.elfMode)
		{
			bg.loadGraphic(Paths.image('backgrounds_elf/${fuckingCockDickPenis}'));
		}
		else 
		{
			if(optionShit[curSelected] == 'ferocious' && !SaveFileState.saveFile.data.playedFerocious)
			{
				bg.loadGraphic(Paths.image('menu/unknown'));
			}
			else
			{
				bg.loadGraphic(Paths.image('menu/${theFuckingOption}'));
			}
		}
		bg.setGraphicSize(1280);
		bg.updateHitbox();
		bg.screenCenter();

		updateDiffies();
	}

	var difficultyImg:FlxSprite;

	function updateDiffies() 
	{
		if(difficultyImg != null)
		{
			remove(difficultyImg);
		}
		difficultyImg = new FlxSprite();
		difficultyImg.loadGraphic(Paths.image('diff/' + CoolUtil.songDiffRating(optionShit[curSelected].toLowerCase())));
		difficultyImg.scale.set(0.5, 0.5);
		difficultyImg.setPosition(FlxG.width - ((546 / 1.4) + 5), FlxG.height - ((497 / 1.4) + 5));
		difficultyImg.scrollFactor.set(0, 0);
		if(optionShit[curSelected] == 'extras')
		{
			difficultyImg.alpha = 0;
		}
		add(difficultyImg);
	}
}
