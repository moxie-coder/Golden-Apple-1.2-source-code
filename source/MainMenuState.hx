package;

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

class MainMenuState extends MusicBeatState
{
	var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;

	var realMenuItems:Int = 4;

	var optionShit:Array<String> = ['play', 'options', 'credits', 'discord', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'dave x bambi shipping cute'];

	var newGaming:FlxText;
	var newGaming2:FlxText;
	var newInput:Bool;

	public static var firstStart:Bool = true;

	public static var finishedFunnyMove:Bool = false;

	public static var daRealEngineVer:String = 'Golden Apple';

	public static var engineVers:Array<String> = ['Golden Apple'];

	public static var kadeEngineVer:String = "Golden Apple";
	public static var gameVer:String = "1.2 ";

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
		
		var bg:FlxSprite = new FlxSprite().loadGraphic(randomizeBG());
		bg.scrollFactor.set();
		bg.screenCenter();
		bg.antialiasing = true;
		bg.color = 0xFFFDE871;
		add(bg);

		magenta = new FlxSprite().loadGraphic(bg.graphic);
		magenta.scrollFactor.set();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.antialiasing = true;
		magenta.color = 0xFFfd719b;
		add(magenta);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		FlxG.camera.follow(camFollow, null, 0.06);
		
		camFollow.setPosition(640, 150.5);
		for (i in 0...optionShit.length)
		{
			var menuItem:FlxSprite = new FlxSprite(0, FlxG.height * 1.6);
			var tex = Paths.getSparrowAtlas('buttons/' + optionShit[i]);
			menuItem.frames = tex;
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			if (optionShit[i] == '') menuItem.visible = false;
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


		Controls.initControls();
		controls.setKeyboardScheme(KeyboardScheme.Solo, true);

		changeItem();

		super.create();
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.screenCenter(X);
		});

		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		super.update(elapsed);

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

			if ((controls.BACK || FlxG.keys.justPressed.BACKSPACE) && !selectedSomethin)
			{
				FlxG.switchState(new SaveFileState());
			}

			if(FlxG.keys.justPressed.SEVEN)
			{
				#if debug
				FlxG.switchState(new FerociousEnding(100));
				#end
			}

			if (controls.ACCEPT || FlxG.keys.justPressed.ENTER)
			{
				if(optionShit[curSelected] == '')
				{
					return;
				}
				if(optionShit[curSelected] == 'discord')
				{
					fancyOpenURL('https://discord.gg/goldenapple');
					return;
				}
				if(optionShit[curSelected] == 'credits')
				{
					fancyOpenURL('https://docs.google.com/document/d/14XHPD53QQILlwTKla0aE5zvEqU9hiAqRw5D3g1QVKl0/edit?usp=sharing');
					return;
				}
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('confirmMenu'));

				FlxFlicker.flicker(magenta, 1.1, 0.15, false);

				menuItems.forEach(function(spr:FlxSprite)
				{
					if (curSelected != spr.ID)
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
						FlxFlicker.flicker(spr, 1, 0.32, false, false, function(flick:FlxFlicker)
						{
							var daChoice:String = optionShit[curSelected];
							switch (daChoice)
							{
								case 'options':
									FlxG.switchState(new OptionsMenu());
								case 'play':
									FlxG.switchState(new PlayMenuState());
								case 'dave x bambi shipping cute':
									var poop:String = Highscore.formatSong('dave-x-bambi-shipping-cute', 1);

									trace(poop);

									SaveFileState.saveFile.data.shipUnlocked = true;
						
									PlayState.SONG = Song.loadFromJson(poop, 'dave-x-bambi-shipping-cute');
									PlayState.isStoryMode = false;
									PlayState.storyDifficulty = 1;
									PlayState.xtraSong = false;
						
									PlayState.storyWeek = 1;
									LoadingState.loadAndSwitchState(new PlayState());
							}
						});
					}
				});
				
			}
		}
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
				curSelected = realMenuItems - 1;	
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
	}
	public static function randomizeBG():flixel.system.FlxAssets.FlxGraphicAsset
	{
		var chance:Int = FlxG.random.int(0, bgPaths.length - 1);
		return Paths.image(bgPaths[chance]);
	}
}
