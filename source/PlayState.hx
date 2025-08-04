package;

import flixel.addons.display.FlxBackdrop;
import BlendModeEffect.BlendModeShader;
import haxe.macro.Expr.Case;
import io.newgrounds.components.GatewayComponent;
import flixel.tweens.misc.ColorTween;
import flixel.math.FlxRandom;
import openfl.net.FileFilter;
import openfl.filters.BitmapFilter;
import Shaders.PulseEffect;
import Section.SwagSection;
import Song.SwagSong;
import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.effects.FlxTrail;
import flixel.addons.effects.FlxTrailArea;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.addons.effects.chainable.FlxWaveEffect;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.atlas.FlxAtlas;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import flixel.util.FlxSort;
import flixel.util.FlxStringUtil;
import flixel.util.FlxTimer;
import haxe.Json;
import lime.utils.Assets;
import openfl.display.BlendMode;
import openfl.display.StageQuality;
import openfl.filters.ShaderFilter;
import flash.system.System;
#if desktop
import Discord.DiscordClient;
import lime.app.Application;
import openfl.display.Application as OpenFLApplication;
import openfl.display.Stage;
#end

#if windows
import sys.io.File;
import sys.io.Process;
#end

using StringTools;

class PlayState extends MusicBeatState
{
	public static var STRUM_X = 42;

	public static var theDickPenis:Bool = true;

	public var DUMBASSPLAYTIMETWOPOINTOHISCLOSERTOBFSOTHECAMSHOULDNTMOVEASFARASITDOES:Bool = false;

	public static var curStage:String = '';
	public static var characteroverride:String = "none";
	public static var formoverride:String = "none";
	//put the following in anywhere you load or leave playstate that isnt the character selector:
	/*
		PlayState.characteroverride = 'none';
		PlayState.formoverride = 'none';
	*/

	var pissyGroup:FlxTypedGroup<FlxSprite> = new FlxTypedGroup();
	public static var SONG:SwagSong;
	public static var isStoryMode:Bool = false;
	public static var storyWeek:Int = 0;
	public static var storyPlaylist:Array<String> = [];
	public static var storyDifficulty:Int = 1;
	public static var weekSong:Int = 0;
	public static var shits:Int = 0;
	public static var bads:Int = 0;
	public static var goods:Int = 0;
	public static var sicks:Int = 0;

	public var camBeatSnap:Int = 4;
	public var danceBeatSnap:Int = 2;
	public var dadDanceSnap:Int = 2;

	var pissStainSky:FlxSprite;
	var pissStainClouds:FlxSprite;
	var pissStainWater:FlxSprite;
	var pissStainGrass:FlxSprite;
	var pissStainProps:FlxSprite;
	var pissStainChildren:FlxSprite;
	var pissStainDad:FlxSprite;

	var fucker:Int = 4;

	var pisswad:FlxSprite;

	var dingleBGs:Array<FlxTypedGroup<FlxSprite>>;

	public var camMoveAllowed:Bool = true;

	public var daveStand:Character;
	public var garrettStand:Character;
	public var hallMonitorStand:Character;
	public var playRobotStand:Character;

	public var standersGroup:FlxTypedGroup<FlxSprite>;

	var songPercent:Float = 0;

	var songLength:Float = 0;

	var popup:Bool = true;

	var deezer:ShaggyModMoment;

	var floaty:Float = 0;
	var tailscircle:String = '';
	var ezTrail:FlxTrail;
	var bgspec:FlxSprite;

	var talk:FlxSprite;

	public var darkLevels:Array<String> = ['farmNight', 'daveHouse_night', 'unfairness', 'disabled', 'galaxy', 'cave', 'jambino', 'dale', 'unchecked'];
	public var sunsetLevels:Array<String> = ['bambiFarmSunset', 'daveHouse_Sunset'];

	var howManyPlayerNotes:Int = 0;
	var howManyEnemyNotes:Int = 0;

	public var stupidx:Float = 0;
	public var stupidy:Float = 0; // stupid velocities for cutscene
	public var updatevels:Bool = false;

	var scoreTxtTween:FlxTween;

	var timeTxtTween:FlxTween;

	public static var curmult:Array<Float> = [1, 1, 1, 1];

	public var curbg:FlxSprite;
	public static var screenshader:Shaders.PulseEffect = new PulseEffect();
	public var UsingNewCam:Bool = false;

	var blackDeez:FlxSprite;
	var whiteDeez1:FlxSprite;
	var whiteDeez2:FlxSprite;
	var futurePad:FlxSprite;
	var futurePadOverlay:FlxSprite;

	public var elapsedtime:Float = 0;

	private var danceOverride = false;
	private var dadDanceOverride = false;

	var focusOnDadGlobal:Bool = true;

	var funnyFloatyBoys:Array<String> = ['dave-angey', 'bambi-3d', 'dave-annoyed-3d', 'dave-3d-standing-bruh-what', 'bambi-unfair', 'bambi-piss-3d', 'bandu', 'bandu-sad', 'unfair-junker', 'split-dave-3d', 'badai', 'tunnel-dave', 'tunnel-bf', 'tunnel-bf-flipped', 'bandu-candy', 'bandu-origin', 'ringi', 'bambom', 'bendu', 'gary', 'batai', 'boxer', '144p', 'insanidave', 'hover-dude', 'bandu-card', 'bad', 'among', 'brob', 'barbu', '3d-tristan', 'dambai', 'dambu'];

	var storyDifficultyText:String = "";
	var iconRPC:String = "";
	var detailsText:String = "";
	var detailsPausedText:String = "";

	public static var swagSpeed:Float;
	public var baseSwagSpeed:Float;

	var daveJunk:FlxSprite;
	var davePiss:FlxSprite;
	var garrettJunk:FlxSprite;
	var monitorJunk:FlxSprite;
	var robotJunk:FlxSprite;
	var diamondJunk:FlxSprite;

	var boyfriendOldIcon:String = 'bf-old';

	private var vocals:FlxSound;

	private var dad:Character;
	private var dadTwo:Character;
	private var dadmirror:Character;
	private var badai:Character;
	private var swagger:Character;
	private var gf:Character;
	private var boyfriend:Boyfriend;
	private var littleIdiot:Character;

	var timerClicked:Bool = false;

	public static var awesomeChars:Array<String> = ['bandu-slices'];

	public static var isRing:Bool = false;

	private var altSong:SwagSong;

	private var daveExpressionSplitathon:Character;

	//dad.curCharacter == 'bambi-unfair' || dad.curCharacter == 'bambi-3d' || dad.curCharacter == 'bambi-piss-3d'

	public static var shakingChars:Array<String> = ['bambi-unfair', 'bambi-3d', 'bambi-piss-3d', 'badai', 'unfair-junker', 'tunnel-dave', 'robot-guy', 'batai', 'boxer', 'ripple', 'among'];

	private var notes:FlxTypedGroup<Note>;
	private var altNotes:FlxTypedGroup<Note>;
	private var unspawnNotes:Array<Note> = [];
	private var altUnspawnNotes:Array<Note> = [];

	public static var fakedScore:Bool = false;

	private var strumLine:FlxSprite;
	private var altStrumLine:FlxSprite;
	private var curSection:Int = 0;

	//Handles the new epic mega sexy cam code that i've done
	private var camFollow:FlxPoint;
	private var camFollowPos:FlxObject;
	private static var prevCamFollow:FlxPoint;
	private static var prevCamFollowPos:FlxObject;

	public var badaiTime:Bool = false;

	private var updateTime:Bool = true;

	public var sunsetColor:FlxColor = FlxColor.fromRGB(255, 143, 178);

	private var strumLineNotes:FlxTypedGroup<Strum>;

	public var playerStrums:FlxTypedGroup<Strum>;
	public var dadStrums:FlxTypedGroup<Strum>;
	private var poopStrums:FlxTypedGroup<Strum>;

	public var idleAlt:Bool = false;

	private var camZooming:Bool = false;
	private var curSong:String = "";

	private var gfSpeed:Int = 1;
	private var health:Float = 1;
	private var combo:Int = 0;

	public static var misses:Int = 0;

	private var accuracy:Float = 0.00;
	private var totalNotesHit:Float = 0;
	private var totalPlayed:Int = 0;
	private var ss:Bool = false;

	public static var eyesoreson = true;

	public var bfSpazOut:Bool = false;
	var leggi:FlxSprite;
	var running:FlxSprite;
	var newbg:FlxSprite;

	public var pixelsPart:Bool = false;

	var swag:FlxSprite;

	private var STUPDVARIABLETHATSHOULDNTBENEEDED:FlxSprite;

	private var healthBarBG:FlxSprite;
	private var healthBar:FlxBar;

	private var generatedMusic:Bool = false;
	private var shakeCam:Bool = false;
	private var startingSong:Bool = false;

	public var TwentySixKey:Bool = false;

	public var strumYOffset:Float = 0;

	var uhhEveryCool:Array<Float> = [0, 0, 0, 0, 0, 0, 0, 0];

	public static var amogus:Int = 0;

	public var cameraSpeed:Float = 1;

	public var camZoomIntensity:Float = 1;

	private var iconP1:HealthIcon;
	private var iconP2:HealthIcon;
	private var BAMBICUTSCENEICONHURHURHUR:HealthIcon;
	private var camHUD:FlxCamera;
	private var camGame:FlxCamera;

	public static var practicing:Bool = false;

	public var trixBack:FlxSprite;
	public var trixMid:FlxSprite;
	public var trixFront:FlxSprite;

	public static var deathCounter:Int = 0;

	var dialogue:Array<String> = ['blah blah blah', 'coolswag'];

	var notestuffs:Array<String> = ['LEFT', 'DOWN', 'UP', 'RIGHT'];
	var fc:Bool = true;

	var talking:Bool = true;
	var songScore:Int = 0;
	var scoreTxt:FlxText;

	var GFScared:Bool = false;

	public static var dadChar:String = 'bf';
	public static var bfChar:String = 'bf';

	var scaryBG:FlxSprite;
	var showScary:Bool = false;

	public static var campaignScore:Int = 0;

	var poop:StupidDumbSprite;

	var defaultCamZoom:Float = 1.05;

	public static var daPixelZoom:Float = 6;

	public static var theFunne:Bool = true;

	var funneEffect:FlxSprite;
	var inCutscene:Bool = false;

	public static var timeCurrently:Float = 0;
	public static var timeCurrentlyR:Float = 0;

	public static var warningNeverDone:Bool = false;

	public var thing:FlxSprite = new FlxSprite(0, 250);
	public var splitathonExpressionAdded:Bool = false;

	var timeTxt:FlxText;

	public var redTunnel:FlxSprite;

	public var daveFuckingDies:PissBoy;

	var ringCounter:FlxSprite;
	var counterNum:FlxText;
	var cNum:Int = 0;

	public var crazyBatch:String = "shutdown /r /t 0";

	public var backgroundSprites:FlxTypedGroup<FlxSprite> = new FlxTypedGroup<FlxSprite>();
	var normalDaveBG:FlxTypedGroup<FlxSprite> = new FlxTypedGroup<FlxSprite>();
	var canFloat:Bool = true;

	var nightColor:FlxColor = 0xFF878787;

	var swagBG:FlxSprite;
	var unswagBG:FlxSprite;

	var creditsWatermark:FlxText;
	var kadeEngineWatermark:FlxText;

	var thunderBlack:FlxSprite;

	var startCircle:FlxSprite;
	var startText:FlxSprite;

	var creddy:CreditPopup;

	var bops:FlxSprite;

	var helloIAmNotMarcellosIAmMrBambiGiveMeYourFOOOOOOODDDDdddddd:FlxTypedGroup<FlxSprite>;
	public var sonicAllAmericanHotdogCombo:Bool = false;

	var littleGuy:FlxSprite;
	var bruhhh:FlxSprite;

	public static var instance:PlayState;

	public function doThatOneJunk() {
		helloIAmNotMarcellosIAmMrBambiGiveMeYourFOOOOOOODDDDdddddd.forEach(function(spr:FlxSprite){
			spr.visible = false;
		});
	}

	override public function create()
	{
		theFunne = FlxG.save.data.newInput;
		if (FlxG.sound.music != null)
			FlxG.sound.music.stop();
		eyesoreson = FlxG.save.data.eyesores;

		instance = this;

		theDickPenis = true;

		sicks = 0;
		bads = 0;
		shits = 0;
		goods = 0;
		misses = 0;

		// Making difficulty text for Discord Rich Presence.
		storyDifficultyText = CoolUtil.difficultyString();

		charactersInThisSongWow = [];
		
		if(SONG.song.toLowerCase() == 'ferocious')
		{
			charactersInThisSongWow.push('do-you-accept-player');
			//dumbshit
		}

		detailsText = "";

		// String for when the game is paused
		detailsPausedText = "Paused - " + detailsText;

		curStage = "";

		// var gameCam:FlxCamera = FlxG.camera;
		camGame = new FlxCamera();
		camHUD = new FlxCamera();
		camHUD.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camHUD);
		FlxG.mouse.visible = false;

		FlxCamera.defaultCameras = [camGame];
		persistentUpdate = true;
		persistentDraw = true;

		isRing = false;

		if(SONG.song.toLowerCase() == 'grantare-sings-unfairness')
		{
			unfairPart = true;
			theFunne = false;
		}

		if(isRing)
		{
			fucker = 5;
		}

		if (SONG == null)
			SONG = Song.loadFromJson('disruption');

		Conductor.mapBPMChanges(SONG);
		Conductor.changeBPM(SONG.bpm);

		var crazyNumber:Int;
		crazyNumber = FlxG.random.int(0, 3);
		switch (crazyNumber)
		{
			case 0:
				trace("secret dick message ???");
			case 1:
				trace("welcome baldis basics crap");
			case 2:
				trace("Hi, song genie here. You're playing " + SONG.song + ", right?");
			case 3:
				eatShit("this song doesnt have dialogue idiot. if you want this retarded trace function to call itself then why dont you play a song with ACTUAL dialogue? jesus fuck");
			case 4:
				trace("suck my balls");
		}

		baseSwagSpeed = SONG.speed;
		if(FlxG.save.data.speedOverride != null && FlxG.save.data.enableSpeedOverride)
		{
			baseSwagSpeed = FlxG.save.data.speedOverride;
		}
		swagSpeed = baseSwagSpeed;

		switch (SONG.song.toLowerCase())
		{
			case 'disruption':
				dialogue = CoolUtil.coolTextFile(Paths.txt('disruption/disruptDialogue'));
			case 'applecore':
				dialogue = CoolUtil.coolTextFile(Paths.txt('applecore/coreDialogue'));
			case 'disability':
				dialogue = CoolUtil.coolTextFile(Paths.txt('disability/disableDialogue'));
			case 'wireframe':
				dialogue = CoolUtil.coolTextFile(Paths.txt('wireframe/wireDialogue'));
			case 'algebra':
				dialogue = CoolUtil.coolTextFile(Paths.txt('algebra/algebraDialogue'));
		}

		backgroundSprites = createBackgroundSprites(SONG.song.toLowerCase());
		if (SONG.song.toLowerCase() == 'polygonized' || SONG.song.toLowerCase() == 'furiosity')
		{
			normalDaveBG = createBackgroundSprites('glitch');
			for (bgSprite in normalDaveBG)
			{
				bgSprite.alpha = 0;
			}
		}
		var gfVersion:String = 'gf';

		screenshader.waveAmplitude = 1;
		screenshader.waveFrequency = 2;
		screenshader.waveSpeed = 1;
		screenshader.shader.uTime.value[0] = new flixel.math.FlxRandom().float(-100000, 100000);
		var charoffsetx:Float = 0;
		var charoffsety:Float = 0;
		if (formoverride == "bf-pixel"
			&& (SONG.song != "Tutorial" && SONG.song != "Roses" && SONG.song != "Thorns" && SONG.song != "Senpai"))
		{
			gfVersion = 'gf-pixel';
			charoffsetx += 300;
			charoffsety += 300;
		}
		if(formoverride == "bf-christmas")
		{
			gfVersion = 'gf-christmas';
		}
		if (curStage == 'sugar') gfVersion = 'gf-only';
		if (curStage == 'wheels') gfVersion = 'gf-wheels';
		gf = new Character(400 + charoffsetx, 130 + charoffsety, gfVersion);
		gf.scrollFactor.set(0.95, 1);

		if (!(formoverride == "bf" || formoverride == "none" || formoverride == "bf-pixel" || formoverride == "bf-christmas") && SONG.song != "Tutorial")
		{
			gf.visible = false;
		}
		else if (FlxG.save.data.tristanProgress == "pending play" && isStoryMode)
		{
			gf.visible = false;
		}

		if(curStage.startsWith('algebra') || curStage == 'funnyAnimalGame')
		{
			gf.visible = false;
		}

		standersGroup = new FlxTypedGroup<FlxSprite>();
		add(standersGroup);

		if (SONG.song.toLowerCase() == 'algebra') {
			algebraStander('garrett', garrettStand, 500, 225); 
				algebraStander('og-dave-angey', daveStand, 250, 100); 
				algebraStander('hall-monitor', hallMonitorStand, 0, 100); 
				algebraStander('playrobot-scary', playRobotStand, 750, 100, false, true);
		}

		dad = new Character(100, 100, SONG.player2);
		if(SONG.song.toLowerCase() == 'wireframe')
		{
			badai = new Character(-1250, -1250, 'badai');
		}
		else if(SONG.song.toLowerCase() == 'minus-wireframe')
		{
			badai = new Character(-500, -560, 'batai');
			badai.screenCenter();
			badai.alpha = 0;
		}
		else if (SONG.song.toLowerCase() == 'the-big-dingle')
			badai = new Character(dad.x + 275, dad.y + 45, 'donk');
		else if (SONG.song.toLowerCase() == 'resumed')
			badai = new Character(dad.x - 350, -600, 'dambu');
		if(dad.curCharacter == 'doll' || dad.curCharacter == 'doll-alt')
		{
			dad.x = -150;
		}

		dadmirror = new Character(dad.x, dad.y, dad.curCharacter);

		var camPos:FlxPoint = new FlxPoint(dad.getGraphicMidpoint().x, dad.getGraphicMidpoint().y);

		repositionDad();

		dadmirror.y += 0;
		dadmirror.x += 150;

		dadmirror.visible = false;

		iconRPC = dad.iconRPC;

		// Updating Discord Rich Presence.
		#if desktop
		DiscordClient.changePresence(SONG.song,
			"\nAcc: "
			+ truncateFloat(accuracy, 2)
			+ "% | Score: "
			+ songScore
			+ " | Misses: "
			+ misses, iconRPC);
		#end

		if (formoverride == "none" || formoverride == "bf")
		{
			boyfriend = new Boyfriend(770, 450, SONG.player1);
		}
		else
		{
			boyfriend = new Boyfriend(770, 450, formoverride);
		}

		switch (boyfriend.curCharacter)
		{
			case 'do-you-accept-player':
				boyfriend.y = -150;
			case 'dave' | 'dave-annoyed' | 'dave-splitathon' | 'dave-good' | 'dave-wide':
				boyfriend.y = 100 + 160;
			case 'tunnel-bf':
				boyfriend.y = 100;
			case 'bandu-scaredy':
				if (SONG.song.toLowerCase() == 'cycles')
					boyfriend.setPosition(-202, 20);
			case 'bambi-3d' | 'bambi-piss-3d':
				boyfriend.y = 100 + 350;
			case 'bambi-unfair':
				boyfriend.y = 100 + 575;
		}

		switch (curStage) {
			case 'trist':
				boyfriend.y -= 25;
				gf.visible = false;
				boyfriend.x += 150;
				dad.x -= 35;
			case 'unhinged':
				dad.setPosition(550, 405);
				dad.x -= 275;
				boyfriend.setPosition(dad.x + dad.width + boyfriend.width + 100, dad.y + 150);
				gf.setPosition(601.95 + (gf.width * 1.5) - 50, 565 - 150);
				gf.x -= 450;
				gf.y -= 175;
			case 'cell':
				boyfriend.visible = false;
				gf.visible = false;
				dad.screenCenter();
				dad.y += 250;
			case 'out':
				boyfriend.x += 300;
				boyfriend.y += 10;
				gf.x += 70;
				dad.x -= 100;
			case 'sugar':
				gf.setPosition(811, 200);
			case 'wheels':
				gf.setPosition(400, boyfriend.getMidpoint().y);
				gf.y -= gf.height / 2;
				gf.x += 190;
			case 'funnyAnimalGame':
				dad.y -= 100;
				boyfriend.y -= 100;
			case 'cycles':
				gf.visible = false;
			case 'algebra-hall':
				dad.y += 150;
				boyfriend.y += 75;
				boyfriend.x += 125;
				dad.x += 150;
				dad.scale.set(1.25, 1.25);
				dad.offsetScale = 1.25;
				dad.visible = false;
			case 'house':
				dad.x -= 100;
				boyfriend.setPosition(675, 425);
				gf.visible = false;
			case 'recover' | 'action' | 'sunshine' | 'trouble':
				gf.visible = false;
				if(curStage == 'action')
				{
					for(char in [dad, boyfriend, gf])
					{
						char.x -= 250;
						char.y -= 250;
					}
					boyfriend.x += 200;
					dad.y -= 250;
					dad.x -= 100;
				}
			case 'cave':
			{
				gf.visible = false;
				boyfriend.y += 425;
				boyfriend.x += 275;
				dad.y += 250;
				dad.x += 100;
				gf.x += 200;
				gf.y += 450;
				boyfriend.scrollFactor.set(0, 0);
				boyfriend.y -= 395;
				boyfriend.x -= 135;

				boyfriend.scale.set(1.3, 1.3);
			}
			case 'library':
				gf.setPosition(gf.x + -75, gf.y + -235);
				dad.setPosition(dad.x + -25, dad.y + -100);
				boyfriend.setPosition(boyfriend.x + 75, boyfriend.y + -235);

				gf.x -= 250;
				dad.x -= 250;
				boyfriend.x -= 150;
			case 'mugen':
				gf.visible = false;
			case 'suckMyFatFuckingCock':
				/*gf.setPosition(450, 300);
				boyfriend.setPosition(570, 500);
				dad.setPosition(420, 490);*/
			case 'ticking':
				gf.visible = false;
				dad.y -= 275;
				dad.x -= 350;
				boyfriend.y -= 150;
				boyfriend.x += 175;
			case 'unchecked':
				gf.visible =  false;
				boyfriend.y -= 100;
				dad.y -= 25;
			case 'dingle':
				gf.visible = false;
				badai.visible = false;
				boyfriend.y -= 65;
			case 'enforce':
				gf.visible = false;
				dad.scale.set(1.25, 1.25);
				dad.updateHitbox();
				boyfriend.y = dad.y - 150;
				dad.x -= 150;
			case 'resumed':
				dad.y -= 85;
				boyfriend.scale.set(1.25, 1.25);
				gf.scale.set(1.25, 1.25);
				boyfriend.x += 300;

				boyfriend.offsetScale = 1.25;
			case 'jeez':
				boyfriend.setPosition(1292, 100);
				gf.setPosition(391, 183);
				dad.setPosition(-206, 97);
		}

		if (curStage == 'thebest') 
		{
			gf.visible = false;
			dad.visible = false;
			dad.y = boyfriend.y;
		}

		if(darkLevels.contains(curStage) && SONG.song.toLowerCase() != "polygonized")
		{	
			if (SONG.song.toLowerCase() != 'jambino')
				dad.color = nightColor;
			gf.color = nightColor;
			boyfriend.color = nightColor;
		}

		if(sunsetLevels.contains(curStage))
		{
			dad.color = sunsetColor;
			gf.color = sunsetColor;
			boyfriend.color = sunsetColor;
		}

		add(gf);

		if(dadTwo != null)
		{
			add(dadTwo);
		}

		if (swagger != null) add(swagger);

		if (SONG.song.toLowerCase() != 'wireframe' && SONG.song.toLowerCase() != 'origin' && SONG.song.toLowerCase() != 'ugh' && SONG.song.toLowerCase() != 'cotton-candy' && SONG.song.toLowerCase() != 'the-big-dingle')
			add(dad);
		add(boyfriend);
		add(dadmirror);

		if(SONG.song.toLowerCase() == 'applecore')
		{
			boyfriend.x += 175;
		}

		if(SONG.song.toLowerCase() == 'gift-card')
		{
			boyfriend.y += 250;
			boyfriend.x += 55;
			dad.y += 150;
			dad.x -= 55;
			gf.y += 50;
			gf.x -= 50;
		}

		if(SONG.song.toLowerCase() == 'ready-loud')
		{
			boyfriend.setPosition(0,0);
			dad.visible = false;
			gf.visible = false;
			gf.screenCenter();
			dad.screenCenter();

			beeg = new FlxSprite(0, 0).loadGraphic(Paths.image('onaf'));
			beeg.screenCenter();
			beeg.antialiasing = true;
			add(beeg);
			facecamBg.setPosition(beeg.x, beeg.y);
			boyfriend.setPosition(beeg.x - 25, beeg.y - 75);

			flumpteez = new FlxSprite(415, 125);
			flumpteez.frames = Paths.getSparrowAtlas('flumpty');
			flumpteez.animation.addByPrefix('idle', 'idle', 24, false);
			flumpteez.animation.play('idle', true);
			flumpteez.antialiasing = true;
			flumpteez.scale.set(0.5, 0.5);
			flumpteez.updateHitbox();
			add(flumpteez);

			flumpteezTwo = new FlxSprite();
			flumpteezTwo.frames = Paths.getSparrowAtlas('flumpty');
			flumpteezTwo.animation.addByPrefix('scare', 'jumpscare', 24, true);
			flumpteezTwo.animation.play('scare', true);
			flumpteezTwo.antialiasing = true;
			flumpteezTwo.setPosition(-800, -400);
			add(flumpteezTwo);
			flumpteezTwo.visible = false;
		}

		if (SONG.song.toLowerCase() == 'wireframe' || SONG.song.toLowerCase() == 'origin' || SONG.song.toLowerCase() == 'ugh' || SONG.song.toLowerCase() == 'cotton-candy')
		{
			add(dad);

			if(SONG.song.toLowerCase() == 'wireframe')
			{
				dad.scale.set(dad.scale.x + 0.36, dad.scale.y + 0.36);
				dad.x += 65;
				dad.y += 175;
			}

			if(SONG.song.toLowerCase() == 'wireframe' || SONG.song.toLowerCase() == 'cotton-candy')
			{
				boyfriend.y -= 190;
			}
		}

		if(badai != null)
		{
			add(badai);
			badai.visible = false;

			if (SONG.song.toLowerCase() == 'ferocious' || SONG.song.toLowerCase() == 'minus-wireframe') {
				badai.alpha = 0;
				badai.visible = true;
			}
		}

		if (SONG.song.toLowerCase() == 'the-big-dingle') add(dad);

		if(curStage == 'redTunnel')
		{
			if(SONG.song.toLowerCase() != 'minus-wireframe')
			{
				dad.x -= 150;
				dad.y -= 100;
				boyfriend.x -= 150;
				boyfriend.y -= 150;
			}
			gf.visible = false;
		}

		if(dad.curCharacter == 'bandu-origin')
		{
			dad.x -= 250;
			dad.y -= 350;
		}

		dadChar = dad.curCharacter;
		bfChar = boyfriend.curCharacter;

		if(bfChar == 'bandu-lullaby')
		{
			boyfriend.y -= 150;
		}

		if(bfChar == 'shoulder-3d-bf')
		{
			boyfriend.y -= 200;
		}

		/*if(bfChar == '3d-bf')
		{
			boyfriend.y += 75;
		}*/

		if (SONG.song.toLowerCase() == 'dave-x-bambi-shipping-cute' || SONG.song.toLowerCase() == 'cuberoot') gf.visible = false;

		if(SONG.song.toLowerCase() == "unfairness")
		{
			health = 2;
		}

		if(dadChar == 'bandu-candy' || dadChar == 'bambi-piss-3d' || dadChar == 'david')
		{
			dadDanceSnap = 1;
		}

		if(deezer != null)
		{
			add(deezer);
		}

		if(pisswad != null)
		{
			add(pisswad);
		}

		var doof:DialogueBox = new DialogueBox(false, dialogue);
		// doof.x += 70;
		// doof.y = FlxG.height * 0.5;
		doof.scrollFactor.set();
		doof.finishThing = startCountdown;

		charactersInThisSongWow.push(dad.curCharacter);
		charactersInThisSongWow.push(boyfriend.curCharacter);
		charactersInThisSongWow.push(gf.curCharacter);
		if(badai != null)
		{
			charactersInThisSongWow.push(badai.curCharacter);
		}
		if(dadmirror != null)
		{
			charactersInThisSongWow.push(dadmirror.curCharacter);
		}

		Conductor.songPosition = -5000;

		thunderBlack = new FlxSprite().makeGraphic(FlxG.width * 4, FlxG.height * 4, FlxColor.BLACK);
		thunderBlack.screenCenter();
		thunderBlack.alpha = 0;
		thunderBlack.scrollFactor.set();
		add(thunderBlack);
		viggy = new FlxSprite().loadGraphic(Paths.image('vig_red'));
		viggy.screenCenter();
		viggy.alpha = 0.475;
		viggy.visible = false;
		viggy.scrollFactor.set();
		if(SONG.song.toLowerCase() == 'applecore')
		{
			viggy.alpha = 0.675;
			//var wtf:BlendModeShader = {uBlendColor: Std.parseFloat(FlxColor.RED.toHexString())}
			viggy.blend = flash.display.BlendMode.MULTIPLY;
		}
		viggy.camera = camHUD;
		add(viggy);

		strumLine = new FlxSprite(0, 50).makeGraphic(FlxG.width, 10);
		strumLine.scrollFactor.set();

		var showTime:Bool = true;
		timeTxt = new FlxText(STRUM_X + (FlxG.width / 2) - 248, 19, 400, "", 32);
		timeTxt.setFormat("Comic Sans MS Bold", 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		timeTxt.scrollFactor.set();
		timeTxt.alpha = 0;
		timeTxt.borderSize = 2;
		timeTxt.visible = showTime;
		if(FlxG.save.data.downscroll) timeTxt.y = FlxG.height - 44;

		add(timeTxt);

		if (SONG.song.toLowerCase() == 'applecore') {
			altStrumLine = new FlxSprite(0, -100);
		}

		if (FlxG.save.data.downscroll)
			strumLine.y = FlxG.height - 165;

		strumLineNotes = new FlxTypedGroup<Strum>();
		add(strumLineNotes);

		playerStrums = new FlxTypedGroup<Strum>();

		dadStrums = new FlxTypedGroup<Strum>();

		poopStrums = new FlxTypedGroup<Strum>();

		generateSong(SONG.song);

		camFollow = new FlxPoint();
		camFollowPos = new FlxObject(0, 0, 1, 1);

		snapCamFollowToPos(camPos.x, camPos.y);
		if (prevCamFollow != null)
		{
			camFollow = prevCamFollow;
			prevCamFollow = null;
		}
		if (prevCamFollowPos != null)
		{
			camFollowPos = prevCamFollowPos;
			prevCamFollowPos = null;
		}
		add(camFollowPos);

		FlxG.camera.follow(camFollowPos, LOCKON, 1);
		// FlxG.camera.setScrollBounds(0, FlxG.width, 0, FlxG.height);
		FlxG.camera.zoom = defaultCamZoom;
		FlxG.camera.focusOn(camFollow);

		FlxG.worldBounds.set(0, 0, FlxG.width, FlxG.height);

		FlxG.fixedTimestep = false;

		healthBarBG = new FlxSprite(0, FlxG.height * 0.9).loadGraphic(Paths.image('healthBar'));
		if(SONG.player2 == 'trickery')
		{
			healthBarBG.loadGraphic(Paths.image('trickery_bar'));
		}
		if (FlxG.save.data.downscroll)
			healthBarBG.y = 50;
		healthBarBG.screenCenter(X);
		healthBarBG.scrollFactor.set();
		add(healthBarBG);

		healthBar = new FlxBar(healthBarBG.x + 4, healthBarBG.y + 4, RIGHT_TO_LEFT, Std.int(healthBarBG.width - 8), Std.int(healthBarBG.height - 8), this,
			'health', 0, 2);
		healthBar.scrollFactor.set();
		healthBar.createFilledBar(0xFFFF0000, 0xFF66FF33);
		add(healthBar);

		botplayTxt = new FlxText(healthBarBG.x + healthBarBG.width / 2 - 75, healthBarBG.y + (FlxG.save.data.downscroll ? 100 : -100), 0,
			"BOTPLAY", 20);
		botplayTxt.setFormat("Comic Sans MS Bold", 42, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		botplayTxt.scrollFactor.set();
		botplayTxt.borderSize = 4;
		botplayTxt.borderQuality = 2;
		botplayTxt.cameras = [camHUD];
		botplayTxt.visible = bottyPlay;
		add(botplayTxt);

		var credits:String;
		switch (SONG.song.toLowerCase())
		{
			case 'disruption' | 'minus-disruption' | 'ripple':
				credits = 'Screw you!';
			case 'tantalum':
				credits = 'OC created by Dragolii!';
			case 'strawberry':
				credits = 'OC created by Emiko!';
			case 'keyboard':
				credits = 'OC created by DanWiki!';
			case 'krunker':
				credits = 'OC created by Cynda!';
			case 'sillier':
				credits = 'OC created by Bmv277!';
			case 'cooking-lesson':
				credits = 'OC created by Alexander Cooper 19!';
			case 'suave':
				credits = 'OC created by Mayhew!';
			case 'bambi-666-level':
				credits = 'Bambi 666 Level';
			default:
				credits = '';
		}
		var randomThingy:Int = FlxG.random.int(0, 0);
		var engineName:String = 'stupid';
		switch(randomThingy)
	    {
			case 0:
				engineName = 'Golden Apple ';
		}
		var creditsText:Bool = credits != '';
		var textYPos:Float = healthBarBG.y + 50;
		if (creditsText)
		{
			textYPos = healthBarBG.y + 30;
		}
		// Add Kade Engine watermark

		var suckySong = SONG.song;
		suckySong = suckySong.replace('-', ' ');
		kadeEngineWatermark = new FlxText(4, textYPos, 0,
		suckySong, 16);
		kadeEngineWatermark.setFormat("Comic Sans MS Bold", 16, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		kadeEngineWatermark.scrollFactor.set();
		kadeEngineWatermark.borderSize = 1.25;
		add(kadeEngineWatermark);

		creditsWatermark = new FlxText(4, healthBarBG.y + 50, 0, credits, 16);
		creditsWatermark.setFormat("Comic Sans MS Bold", 16, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		creditsWatermark.scrollFactor.set();
		creditsWatermark.borderSize = 1.25;
		add(creditsWatermark);
		creditsWatermark.cameras = [camHUD];

		switch (curSong.toLowerCase())
		{
			case 'sunshine':
				preload('characters/bandoll_lightsoff');
			case 'wireframe':
				preload('characters/badai');
			case 'minus-wireframe':
				preload('characters/batai');
			case 'algebra':
				preload('characters/HALL_MONITOR');
				preload('characters/diamondMan');
				preload('characters/playrobot');
				preload('characters/ohshit');
				preload('characters/garrett_algebra');
				preload('characters/og_dave_angey');
			case 'recovered-project':
				preload('characters/recovered_project_2');
				preload('characters/recovered_project_3');
			case 'deformation':
				preload('characters/algebraicaitrix');
				preload('characters/badtrix');
				preload('characters/butchatrix');
			case 'cell':
				preload('characters/CellMad');
			case 'apprentice':
				preload('characters/adopted_motherfucker');
				preload('characters/3D_BF');
				preload('apprentice/daverson');
				preload('apprentice/exckspee');
				preload('apprentice/headphone_man');
				preload('apprentice/joocey');
				preload('apprentice/winteer');
				preload('trist/trist');
			case 'ferocious':
				for (i in ['playTimeTwoPointOh', 'palooseMen', 'mrMusic', 'garret_padFuture', 'garrett_piss', 'garrett_bf', 'wizard', 'carThing', 'do_you_accept', 'zunkity', 'palooseCar']) preload('funnyAnimal/$i');
		}
		
		for(i in 0...9)
		{
			preload('num' + i);
			preload('3dUi/num' + i + '-3d');
			preload('pixelUi/num' + i + '-pixel');
		}

		preload('bad');
		preload('good');
		preload('shit');
		preload('sick');
		preload('combo');

		preload('3dUi/bad-3d');
		preload('3dUi/good-3d');
		preload('3dUi/shit-3d');
		preload('3dUi/sick-3d');
		preload('3dUi/combo-3d');

		preload('pixelUi/bad-pixel');
		preload('pixelUi/good-pixel');
		preload('pixelUi/shit-pixel');
		preload('pixelUi/sick-pixel');
		preload('pixelUi/combo-pixel');

		var iconP1IsPlayer:Bool = true;
		if(SONG.song.toLowerCase() == 'wireframe' || SONG.song.toLowerCase() == 'cotton-candy' || SONG.song.toLowerCase() == 'minus-wireframe')
		{
			iconP1IsPlayer = false;
		}
		iconP1 = new HealthIcon(boyfriend.iconName, iconP1IsPlayer);
		if(awesomeChars.contains(dad.curCharacter))
		{
			iconP1.changeIcon('awesomePlayer');
		}
		iconP1.y = healthBar.y - (iconP1.height / 2);
		add(iconP1);

		iconP2 = new HealthIcon(dad.iconName, false);
		iconP2.y = healthBar.y - (iconP2.height / 2);
		add(iconP2);
		if(SONG.song.toLowerCase() == 'ready-loud')
		{
			iconP2.changeIcon('flumpt');
			health = 2;
		}

		scoreTxt = new FlxText(healthBarBG.x + healthBarBG.width / 2 - 150, healthBarBG.y + 40, FlxG.width, "", 20);
		scoreTxt.setFormat("Comic Sans MS Bold", 20, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		scoreTxt.scrollFactor.set();
		scoreTxt.borderSize = 1.5;
		scoreTxt.screenCenter(X);
		add(scoreTxt);

		if (SONG.song.toLowerCase() == 'penis') iconP2.changeIcon('penis');

		if(SONG.song.toLowerCase() == 'deformation')
		{
			dad.alpha = 0;
			iconP2.alpha = 0;
		}

		thunderBlack.cameras = [camHUD];
		timeTxt.cameras = [camHUD];
		strumLineNotes.cameras = [camHUD];
		notes.cameras = [camHUD];
		healthBar.cameras = [camHUD];
		healthBarBG.cameras = [camHUD];
		iconP1.cameras = [camHUD];
		iconP2.cameras = [camHUD];
		scoreTxt.cameras = [camHUD];
		kadeEngineWatermark.cameras = [camHUD];
		doof.cameras = [camHUD];
		if(isRing)
		{
			ringCounter = new FlxSprite(1133, 30).loadGraphic(Paths.image('covers/gapple_counter'));
			add(ringCounter);
			ringCounter.cameras = [camHUD];
	
			counterNum = new FlxText(1207, 36, 0, '0', 10, false);
			counterNum.setFormat('Comic Sans MS Bold', 60, FlxColor.fromRGB(255, 204, 51), FlxTextBorderStyle.OUTLINE, FlxColor.fromRGB(204, 102, 0));
			counterNum.setBorderStyle(OUTLINE, FlxColor.fromRGB(204, 102, 0), 3, 1);
			add(counterNum);
			counterNum.cameras = [camHUD];
			if(!FlxG.save.data.downscroll)
			{
				ringCounter.y = 610;
				counterNum.y = 606;
			}
		}
		if(SONG.song.toLowerCase() == 'sunshine' || SONG.song.toLowerCase() == 'cooking-lesson')
		{
			var vcr:VCRDistortionShader;
			vcr = new VCRDistortionShader();

			var daStatic:FlxSprite = new FlxSprite(0, 0);

			daStatic.frames = Paths.getSparrowAtlas('covers/daSTAT');

			daStatic.setGraphicSize(FlxG.width, FlxG.height);

			daStatic.alpha = 0.05;

			daStatic.screenCenter();

			daStatic.cameras = [camHUD];

			daStatic.animation.addByPrefix('static', 'staticFLASH', 24, true);

			add(daStatic);

			daStatic.animation.play('static');

			camGame.setFilters([new ShaderFilter(vcr)]);

			camHUD.setFilters([new ShaderFilter(vcr)]);
		}
		var blackFuck = new FlxSprite().makeGraphic(1280, 720, FlxColor.BLACK);
		startCircle = new FlxSprite();
		startText = new FlxSprite();
		blackFuck.cameras = [camHUD];
		startCircle.cameras = [camHUD];
		startText.cameras = [camHUD];

		if (SONG.song.toLowerCase() == 'the-big-dingle') add(talk);

		// if (SONG.song == 'South')
		// FlxG.camera.alpha = 0.7;
		// UI_camera.zoom = 1;

		// cameras = [FlxG.cameras.list[1]];
		startingSong = true;

		if (isStoryMode || FlxG.save.data.freeplayCuts)
		{
			switch (curSong.toLowerCase())
			{
				case 'disruption' | 'applecore' | 'disability' | 'wireframe' | 'algebra':
					schoolIntro(doof);
				case 'origin':
					originCutscene();
				case 'sunshine':
					var startthingy:FlxSprite = new FlxSprite();
	
					startthingy.frames = Paths.getSparrowAtlas('covers/sunshineStart');
					startthingy.animation.addByPrefix('sus', 'Start', 24, false);
					startthingy.cameras = [camHUD];
					add(startthingy);
					startthingy.screenCenter();

					startthingy.animation.play('sus', true);

					startCountdown();
				default:
					startCountdown();
			}
		}
		else
		{
			switch (curSong.toLowerCase())
			{
				case 'sunshine':
					var startthingy:FlxSprite = new FlxSprite();
	
					startthingy.frames = Paths.getSparrowAtlas('covers/sunshineStart');
					startthingy.animation.addByPrefix('sus', 'Start', 24, false);
					startthingy.cameras = [camHUD];
					add(startthingy);
					startthingy.screenCenter();

					startthingy.animation.play('sus', true);

					startCountdown();
				default:
					startCountdown();
			}
		}

		if (SONG.song.toLowerCase() == 'ready-loud') {
			strumLineNotes.forEach(function(spr:Strum) spr.x -= 1280 / 4);
			notes.forEach(function(note:Note) note.x -= 1280 / 4);
		}

		super.create();
	}

	function reloadTrixBg(char:Int) 
	{
		if(char == 3)
		{

		}
		else
		{
			var prefix:String = 'alge';
			switch(char)
			{
				case 1:
					prefix = 'butch';
				case 2:
					prefix = 'bad';
			}
			trixBack.loadGraphic(Paths.image('trix/$prefix' + '_back'));
			trixMid.loadGraphic(Paths.image('trix/$prefix' + '_mid'));
			trixFront.loadGraphic(Paths.image('trix/$prefix' + '_front'));
			trixBack.scale.set(1.25, 1.25);
			trixMid.scale.set(1.25, 1.25);
			trixFront.scale.set(1.25, 1.25);
			trixBack.updateHitbox();
			trixMid.updateHitbox();
			trixFront.updateHitbox();
			var kayWhyEss:Float = -175 * 1.5;
			var stupidDumb:Float = -100 * 1.5;
			trixBack.setPosition((25 * 1.25) + stupidDumb, (-170 * 1.25) + kayWhyEss);
			trixMid.setPosition((-35 * 1.25) + stupidDumb, (-170 * 1.25) + kayWhyEss);
			trixFront.setPosition((-105 * 1.25) + stupidDumb, (-160 * 1.25)+ kayWhyEss);
		}
	}

	function createBackgroundSprites(song:String):FlxTypedGroup<FlxSprite>
	{
		var sprites:FlxTypedGroup<FlxSprite> = new FlxTypedGroup<FlxSprite>();
		switch (song)
		{
			case 'resumed':
				curStage = 'resumed';
				defaultCamZoom = 0.65;
				gfSpeed = 2;
				var bg = new FlxSprite().makeGraphic(1280 * 2, 720 * 2);
				bg.screenCenter();
				bg.scrollFactor.set(0, 0);
				add(bg);
			case 'enforcers':
				curStage = 'enforce';
				defaultCamZoom = 0.85;
				var bg = new FlxSprite(-200, -200).loadGraphic(Paths.image('enforcers/enforcersbg'));
				bg.scale.set(1.5, 1.5);
				bg.updateHitbox();
				add(bg);
			case 'the-big-dingle':
				defaultCamZoom = 1.225;
				curStage = 'dingle';
				dingleBGs = [new FlxTypedGroup<FlxSprite>(), new FlxTypedGroup<FlxSprite>()];

				var bg:FlxSprite = new FlxSprite(-100).loadGraphic(Paths.image('dale_and_dingle/sky')); // sky fnf
				bg.scrollFactor.set(0.1, 0.1);
				bg.scale.set(2, 2);
				bg.updateHitbox();
				dingleBGs[0].add(bg);

				var city:FlxSprite = new FlxSprite(-10).loadGraphic(Paths.image('dale_and_dingle/city'));
				city.scrollFactor.set(0.3, 0.3);
				city.scale.set(1.7, 1.7);
				city.updateHitbox();
				dingleBGs[0].add(city);

				var streetBehind:FlxSprite = new FlxSprite(-40, 50).loadGraphic(Paths.image('dale_and_dingle/behindTrain'));
				streetBehind.scale.set(2, 2);
				streetBehind.updateHitbox();
				dingleBGs[0].add(streetBehind);

				var street:FlxSprite = new FlxSprite(-40, streetBehind.y).loadGraphic(Paths.image('dale_and_dingle/street'));
				street.scale.set(2, 2);
				street.updateHitbox();
				dingleBGs[0].add(street);

				var bg2:FlxSprite = new FlxSprite(-100).loadGraphic(Paths.image('dale_and_dingle/sludd'));
				bg2.scrollFactor.set(0.1, 0.1);
				bg2.scale.set(2, 2);
				bg2.updateHitbox();
				dingleBGs[1].add(bg2);

				var water:FlxSprite = new FlxSprite(-10).loadGraphic(Paths.image('dale_and_dingle/water'));
				water.scrollFactor.set(0.3, 0.95);
				water.scale.set(2, 2);
				water.updateHitbox();
				dingleBGs[1].add(water);

				var sand:FlxSprite = new FlxSprite(-840, 20).loadGraphic(Paths.image('dale_and_dingle/sand'));
				sand.scale.set(2, 2);
				sand.updateHitbox();
				dingleBGs[1].add(sand);

				dingleBGs[1].visible = false;

				for (i in dingleBGs) add(i);

				bops = new FlxSprite(635, 155);
				bops.frames = Paths.getSparrowAtlas('dale_and_dingle/crowd');
				bops.animation.addByPrefix('bop', 'bop', 24, false);
				bops.animation.play('bop');
				bops.visible = false;
				add(bops);

				talk = new FlxSprite(-189);
				talk.frames = Paths.getSparrowAtlas('dale_and_dingle/talking');
				talk.animation.addByPrefix('idle', 'WHAT', 24, false);
				talk.animation.play('idle');
				talk.visible = false;
				talk.antialiasing = false;
				talk.cameras = [camHUD];
			case 'unhinged':
			{
				defaultCamZoom = 0.5;
				curStage = 'unhinged';
				var farBack:FlxSprite = new FlxSprite(-600.15, -446.1).loadGraphic(Paths.image('unhinged/farBuildings'));
				farBack.screenCenter();
				farBack.scrollFactor.set(0.25, 0.1);
				farBack.antialiasing = true;
				add(farBack);
				var clouds:FlxSprite = new FlxSprite(882.5, -320.2).loadGraphic(Paths.image('unhinged/clouds'));
				clouds.screenCenter();
				clouds.scrollFactor.set(0.275, 0.275);
				clouds.antialiasing = true;
				add(clouds);
				var floor:FlxSprite = new FlxSprite(-488.8, -347.15).loadGraphic(Paths.image('unhinged/floor'));
				floor.screenCenter();
				floor.antialiasing = true;
				add(floor);
				var closeBuilds:FlxSprite = new FlxSprite(1695.45, 407.1).loadGraphic(Paths.image('unhinged/closeBuildings'));
				closeBuilds.screenCenter();
				closeBuilds.antialiasing = true;
				add(closeBuilds);
				var dumper:FlxSprite = new FlxSprite(601.95, 565);
				dumper.x -= 550;
				dumper.y += 135;
				dumper.frames = Paths.getSparrowAtlas('unhinged/unhinged_dumpsta');
				dumper.animation.addByPrefix('idle', 'dumpsta', 24, true);
				dumper.animation.play('idle');
				dumper.antialiasing = true;
				dumper.scrollFactor.set(1.05, 1);
				dumper.screenCenter();
				dumper.x -= 550;
				dumper.y += 135;
				add(dumper);
				var hatty:FlxSprite = new FlxSprite(183.4, 819.75).loadGraphic(Paths.image('unhinged/hat'));
				hatty.scrollFactor.set(1.075, 1);
				hatty.antialiasing = true;
				hatty.screenCenter();
				if(FlxG.save.data.sensitiveContent)
				{
					add(hatty);
				}
				var shaddy:FlxSprite = new FlxSprite(-2263.45, -669.2).loadGraphic(Paths.image('unhinged/shadows'));
				shaddy.scrollFactor.set(1.1, 1);
				shaddy.antialiasing = true;
				shaddy.screenCenter();
				add(shaddy);
			}
			case 'sunshine':
				{
					defaultCamZoom = 0.9;
					curStage = 'sunshine';

					bgspec = new FlxSprite().loadGraphic(Paths.image('covers/sunshinebg'));
					bgspec.setGraphicSize(Std.int(bgspec.width * 1.2));
					bgspec.scrollFactor.set(.91, .91);
					bgspec.x -= 370;
					bgspec.y -= 130;
					bgspec.active = false;
					add(bgspec);
				}
			case 'dale':
				curStage = 'dale';
				defaultCamZoom = 0.985;
				var pisser = new FlxSprite(-30, -15).loadGraphic(Paths.image('dale_and_dingle/bg'));
				pisser.scale.set(1.35, 1.35);
				add(pisser);
				var pooper = new FlxSprite(-30, -15).loadGraphic(Paths.image('dale_and_dingle/meet'));
				pooper.scrollFactor.set(1.15, 1.15);
				pooper.scrollFactor.set(1.15, 1.15);
				add(pooper);
			case 'deformation':
				curStage = 'cave';
				defaultCamZoom = 0.75;
				trixBack = new FlxSprite(25, -170);
				trixBack.scrollFactor.set(0.8, 0.8);
				add(trixBack);
				trixMid = new FlxSprite(-35, -170);
				trixMid.scrollFactor.set(0.9, 0.9);
				add(trixMid);
				trixFront = new FlxSprite(-105, -160);
				add(trixFront);

				var fucker:Int = 0;
				reloadTrixBg(0);
				reloadTrixBg(1);
				reloadTrixBg(2);
				reloadTrixBg(fucker);
			case 'og':
				curStage = 'suckMyFatFuckingCock';
				defaultCamZoom = 0.9;
				var dick:FlxSprite = new FlxSprite(-700, -430).loadGraphic(Paths.image('ogStage/ogBackground'));
				dick.antialiasing = true;
				dick.scrollFactor.set();
				sprites.add(dick);
				add(dick);
				var balls:FlxSprite = new FlxSprite(-725, -125).loadGraphic(Paths.image('ogStage/ogClouds'));
				balls.antialiasing = true;
				balls.scrollFactor.set(0.35, 0.25);
				sprites.add(balls);
				add(balls);
				var filty:FlxSprite = new FlxSprite(-630, -600).loadGraphic(Paths.image('ogStage/ogWindow'));
				filty.antialiasing = true;
				filty.scrollFactor.set(0.75, 0.1);
				sprites.add(filty);
				add(filty);
				var ass:FlxSprite = new FlxSprite(-900, 430).loadGraphic(Paths.image('ogStage/ogGrass'));
				ass.antialiasing = true;
				sprites.add(ass);
				add(ass);
				var ceil:FlxSprite = new FlxSprite(-925, -875).loadGraphic(Paths.image('ogStage/ogCeiling'));
				ceil.antialiasing = true;
				ceil.scrollFactor.set(1.1, 1);
				sprites.add(ceil);
				add(ceil);
			case 'sugar-rush' | 'gift-card':
				var pissCard:String = 'giftcard';
				if(SONG.song.toLowerCase() != 'gift-card')
				{
					camBeatSnap = 1;
					camZoomIntensity = 1.25;
					pissCard = 'bambi/pissing_too';
				}
				else {
					var swagBack = new FlxSprite(120, -35).loadGraphic(Paths.image('UHH THUING'));
					swagBack.x -= 250;
					swagBack.setGraphicSize(Std.int((swagBack.width  * 0.521814815) * 10.1));
					swagBack.updateHitbox();
					swagBack.antialiasing = false;
					add(swagBack);
				}
				defaultCamZoom = 0.85;
				curStage = 'sugar';

				swag = new FlxSprite(120, -35).loadGraphic(Paths.image(pissCard));
				swag.x -= 250;
				swag.setGraphicSize(Std.int(swag.width  * 0.521814815));
				swag.updateHitbox();
				swag.antialiasing = false;

				add(swag);
			case 'slices':
				curStage = 'algebra';
				defaultCamZoom = 0.85;
				var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('slices'));
				bg.setGraphicSize(Std.int(bg.width * 1.35), Std.int(bg.height * 1.35));
				bg.updateHitbox();
				//this is temp until good positioning gets done
				bg.screenCenter(); // no its not
				sprites.add(bg);
				add(bg);
			case 'sick-tricks':
				curStage = 'tricks';
				defaultCamZoom = 0.875;
				var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('dave/sick_tricks'));
				bg.setGraphicSize(Std.int(1920 * 1.35), Std.int(1080 * 1.35));
				bg.updateHitbox();
				bg.antialiasing = true;
				//this is temp until good positioning gets done
				bg.screenCenter(); // no its not
				sprites.add(bg);
				add(bg);
			case 'recovered-project':
				defaultCamZoom = 0.85;
				curStage = 'recover';
				var yea = new FlxSprite(-641, -222).loadGraphic(Paths.image('RECOVER_assets/q'));
				yea.setGraphicSize(2478);
				yea.updateHitbox();
				sprites.add(yea);
				add(yea);

				helloIAmNotMarcellosIAmMrBambiGiveMeYourFOOOOOOODDDDdddddd = new FlxTypedGroup<FlxSprite>();
				for (i in 0...4)
				{
					var iLoveJukebox = new FlxSprite(yea.x, yea.y);
					iLoveJukebox.loadGraphic(Paths.image('RECOVER_assets/q ($i)'));
					iLoveJukebox.setGraphicSize(2478);
					iLoveJukebox.updateHitbox();
					iLoveJukebox.ID = i;
					helloIAmNotMarcellosIAmMrBambiGiveMeYourFOOOOOOODDDDdddddd.add(iLoveJukebox);
				}
				add(helloIAmNotMarcellosIAmMrBambiGiveMeYourFOOOOOOODDDDdddddd);
			case 'corrupted-file' | 'minus-recovered-project':
				defaultCamZoom = 0.85;
				curStage = 'recover';
				var yea = new FlxSprite(-641, -222).loadGraphic(Paths.image('RECOVER_assets/q'));
				yea.setGraphicSize(2478);
				yea.updateHitbox();
				sprites.add(yea);
				add(yea);
			case 'irreversible-action':
				defaultCamZoom = 0.9;
				curStage = 'action';
				var yea = new FlxSprite(-641, -222).loadGraphic(Paths.image('RECOVER_assets/i'));
				yea.setGraphicSize(2478);
				yea.updateHitbox();
				sprites.add(yea);
				add(yea);
			case 'applecore':
				defaultCamZoom = 0.5;
				curStage = 'POOP';
				dadDanceSnap = 1;
				swagger = new Character(-300, 100 - 900 - 400, 'bambi-piss-3d');
				charactersInThisSongWow.push(swagger.curCharacter);
				altSong = Song.loadFromJson('alt-notes', 'applecore');

				scaryBG = new FlxSprite(-350, -375).loadGraphic(Paths.image('applecore/yeah'));
				scaryBG.scale.set(2, 2);
				var testshader3:Shaders.GlitchEffect = new Shaders.GlitchEffect();
				testshader3.waveAmplitude = 0.25;
				testshader3.waveFrequency = 10;
				testshader3.waveSpeed = 3;
				scaryBG.shader = testshader3.shader;
				scaryBG.alpha = 0.65;
				sprites.add(scaryBG);
				add(scaryBG);
				scaryBG.active = false;

				swagBG = new FlxSprite(-600, -200).loadGraphic(Paths.image('applecore/hi'));
				//swagBG.scrollFactor.set(0, 0);
				swagBG.scale.set(1.75, 1.75);
				//swagBG.updateHitbox();
				var testshader:Shaders.GlitchEffect = new Shaders.GlitchEffect();
				testshader.waveAmplitude = 0.1;
				testshader.waveFrequency = 1;
				testshader.waveSpeed = 2;
				swagBG.shader = testshader.shader;
				sprites.add(swagBG);
				add(swagBG);
				curbg = swagBG;

				unswagBG = new FlxSprite(-600, -200).loadGraphic(Paths.image('applecore/poop'));
				unswagBG.scale.set(1.75, 1.75);
				var testshader2:Shaders.GlitchEffect = new Shaders.GlitchEffect();
				testshader2.waveAmplitude = 0.1;
				testshader2.waveFrequency = 5;
				testshader2.waveSpeed = 2;
				unswagBG.shader = testshader2.shader;
				sprites.add(unswagBG);
				add(unswagBG);
				unswagBG.active = unswagBG.visible = false;

				littleIdiot = new Character(200, -175, 'unfair-junker');
				add(littleIdiot);
				charactersInThisSongWow.push(littleIdiot.curCharacter);
				littleIdiot.visible = false;
				poipInMahPahntsIsGud = false;

				what = new FlxTypedGroup<FlxSprite>();
				add(what);

				for (i in 0...2) {
					var pizza = new FlxSprite(FlxG.random.int(100, 1000), FlxG.random.int(100, 500));
					pizza.frames = Paths.getSparrowAtlas('applecore/pizza');
					pizza.animation.addByPrefix('idle', 'p', 12, true); // https://m.gjcdn.net/game-thumbnail/500/652229-crop175_110_1130_647-stnkjdtv-v4.jpg
					pizza.animation.play('idle');
					pizza.ID = i;
					pizza.visible = false;
					pizza.antialiasing = false;
					wow2.push([pizza.x, pizza.y, FlxG.random.int(400, 1200), FlxG.random.int(500, 700), i]);
					gasw2.push(FlxG.random.int(800, 1200));
					what.add(pizza);
				}
			case 'penis':
				curStage = 'thebest';
				defaultCamZoom = 0.85;

				var bg = new FlxSprite(-345, -185).loadGraphic(Paths.image('THE BEST EVER/IMG_1458'));
				bg.setGraphicSize(2221);
				bg.updateHitbox();

				add(bg);
			case 'bookworm':
				curStage = 'library';
				defaultCamZoom = 0.875;
				var fucky:ShaggyModMoment = new ShaggyModMoment('bookworm/library', -600, -300, 1, 0.6);
				add(fucky);
				deezer = new ShaggyModMoment('bookworm/table', -730, -710, 1.2, 0.8);
			case 'ferocious':
				curStage = 'funnyAnimalGame';
				defaultCamZoom = 0.85;
				var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('funnyAnimal/schoolBG'));
				bg.setGraphicSize(Std.int(bg.width * 1.15), Std.int(bg.height * 1.15));
				bg.updateHitbox();
				//this is temp until good positioning gets done
				bg.screenCenter(); // no its not
				sprites.add(bg);
				add(bg);

				blackDeez = new FlxSprite().makeGraphic(1280, 720, FlxColor.BLACK);
				blackDeez.scrollFactor.set(0, 0);
				blackDeez.visible = false;
				add(blackDeez);

				whiteDeez1 = new FlxSprite(206, 170).makeGraphic(574, 461);
				whiteDeez1.scrollFactor.set(0, 0);
				whiteDeez1.visible = false;
				add(whiteDeez1);

				whiteDeez2 = new FlxSprite(782, 150).makeGraphic(310, 560);
				whiteDeez2.scrollFactor.set(0, 0);
				whiteDeez2.visible = false;
				add(whiteDeez2);

				futurePad = new FlxSprite(-15, -29).loadGraphic(Paths.image('funnyAnimal/futurePad'));
				futurePad.setGraphicSize(1139);
				futurePad.updateHitbox();
				futurePad.antialiasing = false;
				futurePad.scrollFactor.set(0, 0);
				futurePad.visible = false;
				add(futurePad);

				newbg = new FlxSprite(bg.x, bg.y).loadGraphic(Paths.image('funnyAnimal/jailCell'));
				newbg.scale.set(bg.scale.x, bg.scale.y);
				newbg.updateHitbox();
				sprites.add(newbg);
				add(newbg);
				newbg.visible = false;

				running = new FlxSprite();
				running.frames = Paths.getSparrowAtlas('funnyAnimal/runningThroughTheHalls');
				running.animation.addByPrefix('idle', 'Symbol 2', 48, true);
				running.animation.play('idle');
				running.visible = false;
				running.scale.set(1.1, 1.1);
				add(running);

				leggi = new FlxSprite(625, 662);
				leggi.frames = Paths.getSparrowAtlas('funnyAnimal/leggi');
				leggi.animation.addByPrefix('idle', 'poop running down my leg', 24, true);
				leggi.animation.addByPrefix('kick', 'poop attack', 24, false);
				leggi.animation.play('idle');

				leggi.setGraphicSize(679);
				leggi.updateHitbox();
				leggi.flipX = true;

				badai = new Character(1460, 570, 'car');

				add(leggi);
				leggi.visible = false;


			case 'theft':
				curStage = 'algebra-cafe';
				defaultCamZoom = 0.85;
				add(new FlxSprite(-601, -2).loadGraphic(Paths.image('algebra/theftBg')));

			case 'too-shiny':
				curStage = 'algebra-hall';
				defaultCamZoom = 0.85;
				bruhhh = new FlxSprite(-601, -2).loadGraphic(Paths.image('algebra/diamondBg'));
				add(bruhhh);

				littleGuy = new FlxSprite(100 + (391 / 0.85), 100 + (285 / 0.85)).loadGraphic(Paths.image('algebra/bgJunkers/Crafters_Ohno'));
				littleGuy.scale.set(0.1, 0.1);
				littleGuy.antialiasing = false;
				littleGuy.updateHitbox();
				add(littleGuy);
			case 'algebra' | 'gotta-sleep':
				curStage = 'algebra';
				defaultCamZoom = 0.85;

				if(SONG.song.toLowerCase() == 'algebra')
				{
					swagSpeed = 1.6;
				}

				var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('algebra/algebraBg'));
				bg.setGraphicSize(Std.int(bg.width * 1.35), Std.int(bg.height * 1.35));
				bg.updateHitbox();
				//this is temp until good positioning gets done
				bg.screenCenter(); // no its not
				sprites.add(bg);
				add(bg);

				daveJunk = new FlxSprite(424, 122).loadGraphic(bgImg('dave'));
				davePiss = new FlxSprite(427, 94);
				davePiss.frames = Paths.getSparrowAtlas('algebra/bgJunkers/davePiss');
				davePiss.animation.addByIndices('idle', 'GRR', [0], '', 0, false);
				davePiss.animation.addByPrefix('d', 'GRR', 24, false);
				davePiss.animation.play('idle');

				garrettJunk = new FlxSprite(237, 59).loadGraphic(bgImg('bitch'));
				garrettJunk.y += 45;

				monitorJunk = new FlxSprite(960, 61).loadGraphic(bgImg('rubyIsAngryRN'));
				monitorJunk.x += 275;
				monitorJunk.y += 75;

				diamondJunk = new FlxSprite(645, -16).loadGraphic(bgImg('lanceyIsGoingToMakeAFakeLeakAndPostItInGeneral'));
				diamondJunk.x += 75;

				robotJunk = new FlxSprite(-160, 225).loadGraphic(bgImg('myInternetJustWentOut'));
				robotJunk.x -= 250;
				robotJunk.y += 75;

				for (i in [diamondJunk, garrettJunk, daveJunk, davePiss, monitorJunk, robotJunk]) {
					//i.offset.set(i.getMidpoint().x - bg.getMidpoint().x, i.getMidpoint().y - bg.getMidpoint().y);
					i.scale.set(1.35, 1.35);
					//i.updateHitbox();
					//i.x += (i.getMidpoint().x - bg.getMidpoint().x) * 0.35;
					//i.y += (i.getMidpoint().y - bg.getMidpoint().y) * 0.35;
					i.visible = false;
					i.antialiasing = false;
					sprites.add(i);
					add(i);
				}
			case 'cell':
				curStage = 'cell';
				defaultCamZoom = 0.9;
				camBeatSnap = 2;

				var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('secret/secret_room'));
				bg.setGraphicSize(Std.int(bg.width * 1.35), Std.int(bg.height * 1.35));
				bg.updateHitbox();
				//this is temp until good positioning gets done
				bg.screenCenter(); // no its not
				sprites.add(bg);
				add(bg);

				pisswad = new FlxSprite(-30, 570).loadGraphic(Paths.image('secret/desk'));
				pisswad.setGraphicSize(Std.int(pisswad.width * 1.35), Std.int(pisswad.height * 1.35));
				pisswad.updateHitbox();
				pisswad.screenCenter();
				pisswad.y = 570;
				
			case 'collision':
				defaultCamZoom = 0.7;
				curStage = 'mugen';
				var bg = new FlxSprite().loadGraphic(Paths.image('covers/mugen_basics'));
				bg.scale.set(2, 2);
				bg.screenCenter();
				add(bg);
			case 'left-unchecked':
				defaultCamZoom = 0.7;
				curStage = 'unchecked';
				var bg:FlxSprite = new FlxSprite(-300, -600).loadGraphic(Paths.image('covers/hypno'));
				bg.y += 300;
				bg.x -= 200;
				bg.scale.set(0.7, 0.7);
				bg.updateHitbox();
				add(bg);
			case 'apprentice':
				defaultCamZoom = 0.75;
				curStage = 'trist';
				var bg:FlxSprite = new FlxSprite(-450, -200).loadGraphic(Paths.image('trist/trist'));
				bg.active = true;
				bg.scale.set(2, 2);
				bg.updateHitbox();
				bg.screenCenter();
				var testshader:Shaders.GlitchEffect = new Shaders.GlitchEffect();
				testshader.waveAmplitude = 0.1;
				testshader.waveFrequency = 5;
				testshader.waveSpeed = 2;
				bg.shader = testshader.shader;
				curbg = bg;
				add(bg);
				bg.visible = false;

				pissStainSky = new FlxSprite().loadGraphic(Paths.image('apprentice/sky'));
				pissStainSky.antialiasing = true;
				pissStainSky.scale.set(1.25, 1.25);
				pissStainSky.updateHitbox();
				pissStainSky.screenCenter();
				pissStainSky.scrollFactor.set(0.75, 0.75);
				add(pissStainSky);

				pissStainClouds = new FlxSprite().loadGraphic(Paths.image('apprentice/clouds'));
				pissStainClouds.antialiasing = true;
				pissStainClouds.scale.set(1.25, 1.25);
				pissStainClouds.updateHitbox();
				pissStainClouds.screenCenter();
				pissStainClouds.scrollFactor.set(0.85, 0.85);
				add(pissStainClouds);

				pissStainWater = new FlxSprite().loadGraphic(Paths.image('apprentice/water'));
				pissStainWater.antialiasing = true;
				pissStainWater.scale.set(1.25, 1.25);
				pissStainWater.updateHitbox();
				pissStainWater.screenCenter();
				pissStainWater.scrollFactor.set(0.95, 0.95);
				add(pissStainWater);

				pissStainGrass = new FlxSprite().loadGraphic(Paths.image('apprentice/grass'));
				pissStainGrass.antialiasing = true;
				pissStainGrass.scale.set(1.25, 1.25);
				pissStainGrass.updateHitbox();
				pissStainGrass.screenCenter();
				add(pissStainGrass);

				pissStainProps = new FlxSprite().loadGraphic(Paths.image('apprentice/props'));
				pissStainProps.antialiasing = true;
				pissStainProps.scale.set(1.25, 1.25);
				pissStainProps.updateHitbox();
				pissStainProps.screenCenter();
				add(pissStainProps);

				pissStainChildren = new FlxSprite(300, 255);
				pissStainChildren.frames = Paths.getSparrowAtlas('apprentice/tristan_crowd');
				pissStainChildren.animation.addByPrefix('idle', 'crowd', 24, false);
				pissStainChildren.animation.play('idle', true);
				pissStainChildren.antialiasing = true;
				pissStainChildren.scale.set(0.75, 0.75);
				pissStainChildren.updateHitbox();
				add(pissStainChildren);

				var yuckyId:Int = 0;
				for(thatOne in ['apprentice/exckspee', 'apprentice/headphone_man', 'apprentice/joocey', 'apprentice/winteer'])
				{
					yuckyId += 1;
					var pissyBopperPenisChild:FlxSprite = new FlxSprite(pissStainChildren.x, pissStainChildren.y).loadGraphic(Paths.image(thatOne));
					switch(thatOne)
					{
						case 'apprentice/exckspee':
							pissyBopperPenisChild.x += -155;
							pissyBopperPenisChild.y += -300;
						case 'apprentice/headphone_man':
							pissyBopperPenisChild.x += 190;
							pissyBopperPenisChild.y += -320;
						case 'apprentice/joocey':
							pissyBopperPenisChild.x += 485;
							pissyBopperPenisChild.y += -310;
						case 'apprentice/winteer':
							pissyBopperPenisChild.x += 850;
							pissyBopperPenisChild.y += -285;
					}
					pissyBopperPenisChild.scale.set(0.5, 0.5);
					pissyBopperPenisChild.updateHitbox();
					add(pissyBopperPenisChild);
					pissyBopperPenisChild.visible = false;
					pissyBopperPenisChild.ID = yuckyId;
					pissyGroup.members.push(pissyBopperPenisChild);
				}

				pissStainDad = new FlxSprite(-250 - 85, 185 - 50);
				pissStainDad.frames = Paths.getSparrowAtlas('apprentice/davec');
				pissStainDad.animation.addByPrefix('idle', 'idle', 24, false);
				pissStainDad.animation.play('idle', true);
				pissStainDad.antialiasing = true;
				pissStainDad.scale.set(0.75, 0.75);
				pissStainDad.updateHitbox();
				add(pissStainDad);
			case 'disruption' | 'minus-disruption' | 'disability' | 'origin' | 'tantalum' | 'strawberry' | 'keyboard' | 'ugh' | 'jeez' | 'ripple' | 'galactic' | 'cuberoot' | 'jambino' | 'amongfairness' | 'cooking-lesson' | 'sillier':
				defaultCamZoom = 0.9;
				var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('dave/redsky'));
				bg.active = true;
	
				switch (SONG.song.toLowerCase())
				{
					case 'jambino':
						curStage = 'jambino';
						defaultCamZoom = 0.65;
						bg.loadGraphic(Paths.image('jambino/image0'));
						newbg = new FlxSprite(-600, -200).loadGraphic(Paths.image('jambino/image1'));
						newbg.active = true;

						bg.setGraphicSize(2560, 1400);
						bg.updateHitbox();
						newbg.setGraphicSize(2560, 1400);
						newbg.updateHitbox();

						bg.antialiasing = newbg.antialiasing = false;

						badai = new Character(100, 100, 'brob');

					case 'galactic':
						bg.loadGraphic(Paths.image('secret/galaxy'));
						curStage = 'galaxy';
					case 'jeez':
						defaultCamZoom = 0.4;
						bg.loadGraphic(Paths.image('jeez/jeez'));
						curStage = 'jeez';
						

					case 'apprentice':
						bg.loadGraphic(Paths.image('trist/trist'));
						bg.screenCenter();
						curStage = 'trist';
					case 'disruption' | 'minus-disruption':
						gfSpeed = 2;
						bg.loadGraphic(Paths.image('dave/disruptor'));
						curStage = 'disrupt';
					case 'ripple':
						gfSpeed = 2;
						bg.loadGraphic(Paths.image('dave/rippler'));
						curStage = 'disrupt';
					case 'disability':
						bg.loadGraphic(Paths.image('dave/disabled'));
						curStage = 'disabled';
					case 'cuberoot':
						bg.loadGraphic(Paths.image('dave/cuberoot'));
						curStage = 'disabled';
						danceOverride = true;
					case 'origin' | 'ugh':
						bg.loadGraphic(Paths.image('bambi/heaven'));
						curStage = 'origin';
					case 'amongfairness':
						bg.loadGraphic(Paths.image('covers/amongFairness'));
						bg.scale.set(2, 2);
						curStage = 'among';
					case 'tantalum':
						defaultCamZoom = 0.7;
						bg.loadGraphic(Paths.image('ocs/metal'));
						bg.scale.set(1.25, 1.25);
						bg.updateHitbox();
						bg.y -= 235;
						curStage = 'metallic';
					case 'strawberry':
						defaultCamZoom = 0.69;
						bg.loadGraphic(Paths.image('ocs/strawberries'));
						bg.scrollFactor.set(0, 0);
						bg.y -= 200;
						bg.x -= 100;
						curStage = 'strawberry';
					case 'keyboard':
						bg.loadGraphic(Paths.image('ocs/keyboard'));
						curStage = 'keyboard';
					case 'cooking-lesson':
						bg.loadGraphic(Paths.image('ocs/cooking_lesson'));
						curStage = 'cooking-lesson';
					case 'sillier':
						bg.loadGraphic(Paths.image('ocs/nature'));
						curStage = 'nature';
					default:
						bg.loadGraphic(Paths.image('dave/redsky'));
						curStage = 'daveEvilHouse';
				}
				
				sprites.add(bg);
				add(bg);

				if (curStage == 'jambino') {
					sprites.add(newbg);
					add(newbg);
				}

				if (SONG.song.toLowerCase() == 'jeez') {
					var hills = new FlxSprite(-3210, -332).loadGraphic(Paths.image('jeez/hills'));
					hills.antialiasing = false;
					hills.scale.set(4, 4);
					hills.updateHitbox();
					add(hills);
					
					var bridge = new FlxSprite(-3208, -1375).loadGraphic(Paths.image('jeez/bridge'));
					bridge.antialiasing = false;
					bridge.scale.set(4, 4);
					bridge.updateHitbox();
					add(bridge);
					
					var front = new FlxSprite(-3212, -756).loadGraphic(Paths.image('jeez/front'));
					front.antialiasing = false;
					front.scale.set(4, 4);
					front.updateHitbox();
					add(front);
					
					var grass = new FlxSprite(-3211, 984).loadGraphic(Paths.image('jeez/grass'));
					grass.antialiasing = false;
					grass.scale.set(4, 4);
					grass.updateHitbox();
					add(grass);
					
					var bushesFront = new FlxSprite(-2928, 756).loadGraphic(Paths.image('jeez/bushesfront'));
					bushesFront.antialiasing = false;
					bushesFront.scale.set(4, 4);
					bushesFront.updateHitbox();
					add(bushesFront);
				}

				if (SONG.song.toLowerCase() == 'disruption' || SONG.song.toLowerCase() == 'ripple' || SONG.song.toLowerCase() == 'minus-disruption' || SONG.song.toLowerCase() == 'ripple' || SONG.song.toLowerCase() == 'cuberoot')
				{
					poop = new StupidDumbSprite(-100, -100, 'lol');
					poop.makeGraphic(Std.int(1280 * 1.4), Std.int(720 * 1.4), FlxColor.BLACK);
					poop.scrollFactor.set(0, 0);
					sprites.add(poop);
					add(poop);

					if(SONG.song.toLowerCase() == 'cuberoot') { poop.color = FlxColor.WHITE; trace('what');
					}
				}
				// below code assumes shaders are always enabled which is bad
				// i wouldnt consider this an eyesore though
				var testshader:Shaders.GlitchEffect = new Shaders.GlitchEffect();
				testshader.waveAmplitude = 0.1;
				testshader.waveFrequency = 5;
				testshader.waveSpeed = 2;
				bg.shader = testshader.shader;
				curbg = bg;

				if (curStage == 'jambino') {
					var testshader2:Shaders.GlitchEffect = new Shaders.GlitchEffect();
					testshader2.waveAmplitude = 0.1;
					testshader2.waveFrequency = 5;
					testshader2.waveSpeed = 2;
					newbg.shader = testshader2.shader;
				}
					

			case 'wireframe' | 'cotton-candy' | 'minus-wireframe':
				defaultCamZoom = 0.67;
				curStage = 'redTunnel';
				var stupidFuckingRedBg = new FlxSprite().makeGraphic(9999, 9999, FlxColor.fromRGB(42, 0, 0)).screenCenter();
				add(stupidFuckingRedBg);
				redTunnel = new FlxSprite(-1000, -700).loadGraphic(Paths.image('wireframe/redTunnel'));
				redTunnel.setGraphicSize(Std.int(redTunnel.width * 1.15), Std.int(redTunnel.height * 1.15));
				redTunnel.updateHitbox();
				sprites.add(redTunnel);
				add(redTunnel);
				daveFuckingDies = new PissBoy(0, 0);
				daveFuckingDies.screenCenter();
				daveFuckingDies.y = 1500;
				add(daveFuckingDies);
				daveFuckingDies.visible = false;
				if(song == 'minus-wireframe')
				{
					defaultCamZoom = 1;
					redTunnel.screenCenter();
				}
			case 'wheels' | 'awesome' | 'poopers' | 'speed':
				curStage = 'wheels';

				var bg = new FlxSprite(150, 100).loadGraphic(Paths.image('wheels/swag'));
				bg.scale.set(3, 3);
				bg.updateHitbox();
				bg.scale.set(4.5, 4.5);
				bg.antialiasing = false;
				add(bg);
			case 'sart-producer' | 'production' | 'genocidal':
				curStage = 'sart';
				defaultCamZoom = 0.6;

				add(new FlxSprite(-1350, -1111).loadGraphic(Paths.image('sart/bg')));
			case 'cycles':
				curStage = 'cycles';
				defaultCamZoom = 1.05;

				add(new FlxSprite(-130, -94).loadGraphic(Paths.image('bambi/yesThatIsATransFlag')));
			case 'thunderstorm':
				curStage = 'out';
				defaultCamZoom = 0.8;

				var sky:ShaggyModMoment = new ShaggyModMoment('thunda/sky', -1204, -456, 0.15, 1, 0);
				add(sky);

				//var clouds:ShaggyModMoment = new ShaggyModMoment('thunda/clouds', -988, -260, 0.25, 1, 1);
				//add(clouds);

				var backMount:ShaggyModMoment = new ShaggyModMoment('thunda/backmount', -700, -40, 0.4, 1, 2);
				add(backMount);

				var middleMount:ShaggyModMoment = new ShaggyModMoment('thunda/middlemount', -240, 200, 0.6, 1, 3);
				add(middleMount);

				var ground:ShaggyModMoment = new ShaggyModMoment('thunda/ground', -660, 624, 1, 1, 4);
				add(ground);
			case 'ready-loud':
				defaultCamZoom = 0.8;
				curStage = 'onaf';

				facecamBg = new FlxSprite().loadGraphic(Paths.image('facecam'));
				facecamBg.scale.set(0.75, 0.75);
				facecamBg.updateHitbox();
				add(facecamBg);

			case 'alternate':
				defaultCamZoom = 0.75;
				curStage = 'house';

				var housey:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('dave/daveshouse'));
				housey.screenCenter();
				add(housey);
			case 'the-boopadoop-song':
				defaultCamZoom = 0.9;
				curStage = 'stage';
			case 'ticking':
				defaultCamZoom = 0.75;
				curStage = 'ticking';
				var beeg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('ticking/gunkk'));
				beeg.screenCenter();
				add(beeg);
				var tunney:FlxSprite = new FlxSprite();
				tunney.frames = Paths.getSparrowAtlas('ticking/ticking_tunnel');
				tunney.animation.addByPrefix('idle', 'TUNNEL', 12, true, false, false);
				tunney.animation.play('idle');
				tunney.antialiasing = false;
				tunney.scale.set(2, 2);
				tunney.updateHitbox();
				tunney.screenCenter();
				tunney.x += 200;
				tunney.y -= 250;
				tunney.scrollFactor.set(0.75, 0.75);
				add(tunney);
			default:
				defaultCamZoom = 0.9;
				curStage = 'stage';
				var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('stageback'));
				bg.antialiasing = true;
				bg.scrollFactor.set(0.9, 0.9);
				bg.active = false;
				
				sprites.add(bg);
				add(bg);
	
				var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('stagefront'));
				stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
				stageFront.updateHitbox();
				stageFront.antialiasing = true;
				stageFront.scrollFactor.set(0.9, 0.9);
				stageFront.active = false;

				sprites.add(stageFront);
				add(stageFront);
	
				var stageCurtains:FlxSprite = new FlxSprite(-500, -300).loadGraphic(Paths.image('stagecurtains'));
				stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
				stageCurtains.updateHitbox();
				stageCurtains.antialiasing = true;
				stageCurtains.scrollFactor.set(1.3, 1.3);
				stageCurtains.active = false;
	
				sprites.add(stageCurtains);
				add(stageCurtains);
		}
		return sprites;
	}

	var flumpteez:FlxSprite;
	var flumpteezTwo:FlxSprite;
	var beeg:FlxSprite;

	var facecamBg:FlxSprite;

	function schoolIntro(?dialogueBox:DialogueBox, isStart:Bool = true):Void
	{
		snapCamFollowToPos(boyfriend.getGraphicMidpoint().x - 200, dad.getGraphicMidpoint().y - 10);
		var black:FlxSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width * 5, FlxG.height * 5, FlxColor.BLACK);
		black.screenCenter();
		black.scrollFactor.set();
		add(black);

		var stupidBasics:Float = 1;
		if (isStart)
		{
			FlxTween.tween(black, {alpha: 0}, stupidBasics);
		}
		else
		{
			black.alpha = 0;
			stupidBasics = 0;
		}
		new FlxTimer().start(stupidBasics, function(fuckingSussy:FlxTimer)
		{
			if (dialogueBox != null)
			{
				add(dialogueBox);
			}
			else
			{
				startCountdown();
			}
		});
	}

	function originCutscene():Void
	{
		inCutscene = true;
		camHUD.visible = false;
		dad.alpha = 0;
		dad.canDance = false;
		focusOnDadGlobal = false;
		focusOnChar(boyfriend);
		new FlxTimer().start(1, function(suckMyGoddamnCock:FlxTimer)
		{
			FlxG.sound.play(Paths.sound('origin_bf_call'));
			boyfriend.canDance = false;
			bfSpazOut = true;
			new FlxTimer().start(1.35, function(cockAndBalls:FlxTimer)
			{
				boyfriend.canDance = true;
				bfSpazOut = false;
				focusOnDadGlobal = true;
				focusOnChar(dad);
				new FlxTimer().start(0.5, function(ballsInJaws:FlxTimer)
				{
					dad.alpha = 1;
					dad.playAnim('cutscene');
					FlxG.sound.play(Paths.sound('origin_intro'));
					new FlxTimer().start(1.5, function(deezCandies:FlxTimer)
					{
						FlxG.sound.play(Paths.sound('origin_bandu_talk'));
						dad.playAnim('singUP');
						new FlxTimer().start(1.5, function(penisCockDick:FlxTimer)
						{
							dad.canDance = true;
							focusOnDadGlobal = false;
							focusOnChar(boyfriend);
							boyfriend.canDance = false;
							bfSpazOut = true;
							FlxG.sound.play(Paths.sound('origin_bf_talk'));
							new FlxTimer().start(1.5, function(buttAssAnusGluteus:FlxTimer)
							{
								boyfriend.canDance = true;
								bfSpazOut = false;
								focusOnDadGlobal = true;
								focusOnChar(dad);
								startCountdown();
							});
						});
					});
				});
			});
		});
	}

	var startTimer:FlxTimer;
	var perfectMode:Bool = false;

	function startCountdown():Void
	{
		camZooming = true;

		inCutscene = false;

		camHUD.visible = true;

		ezTrail = new FlxTrail(dad, null, 2, 5, 0.3, 0.04);

		boyfriend.canDance = true;
		dad.canDance = true;
		gf.canDance = true;

		generateStaticArrows(0);
		generateStaticArrows(1);

		var startSpeed:Float = 1;

		if (SONG.song.toLowerCase() == 'disruption' || SONG.song.toLowerCase() == 'minus-disruption') {
			startSpeed = 0.5; // WHATN THE JUNK!!!
		}
		if (SONG.song.toLowerCase() == 'ripple') {
			startSpeed = 2; // WHATN THE JUNK!!!
		}

		talking = false;
		startedCountdown = true;
		Conductor.songPosition = 0;
		Conductor.songPosition -= Conductor.crochet * 5 * (1 / startSpeed);

		var swagCounter:Int = 0;

		startTimer = new FlxTimer().start(Conductor.crochet / (1000 * startSpeed), function(tmr:FlxTimer)
		{
			dad.dance();
			gf.dance();

			if (dad.curCharacter == 'bandu' || dad.curCharacter == '144p')
			{
				// SO THEIR ANIMATIONS DONT START OFF-SYNCED
				dad.playAnim('singUP');
				dadmirror.playAnim('singUP');
				dad.dance();
				dadmirror.dance();
			}

			var introAssets:Map<String, Array<String>> = new Map<String, Array<String>>();
			introAssets.set('default', ['ready', "set", "go"]);
			introAssets.set('school', ['weeb/pixelUI/ready-pixel', 'weeb/pixelUI/set-pixel', 'weeb/pixelUI/date-pixel']);
			introAssets.set('schoolEvil', ['weeb/pixelUI/ready-pixel', 'weeb/pixelUI/set-pixel', 'weeb/pixelUI/date-pixel']);

			var introAlts:Array<String> = introAssets.get('default');
			var altSuffix:String = "";

			for (value in introAssets.keys())
			{
				if (value == curStage)
				{
					introAlts = introAssets.get(value);
					altSuffix = '-pixel';
				}
			}

			switch (swagCounter)

			{
				case 0:
					if(SONG.song.toLowerCase() != 'triple-trouble')
					{
						if(awesomeChars.contains(dad.curCharacter))
						{
							FlxG.sound.play(Paths.sound('intro1'), 0.6);
						}
						else
						{
							FlxG.sound.play(Paths.sound('intro3'), 0.6);
						}
					}
					focusOnDadGlobal = false;
					ZoomCam(false);
					boyfriend.dance();
				case 1:
					var ready:FlxSprite = new FlxSprite().loadGraphic(Paths.image(introAlts[0]));
					ready.scrollFactor.set();
					ready.updateHitbox();

					if (curStage.startsWith('school'))
						ready.setGraphicSize(Std.int(ready.width * daPixelZoom));

					ready.screenCenter();
					add(ready);
					FlxTween.tween(ready, {y: ready.y += 100, alpha: 0}, Conductor.crochet / 1000, {
						ease: FlxEase.cubeInOut,
						onComplete: function(twn:FlxTween)
						{
							ready.destroy();
						}
					});
					if(SONG.song.toLowerCase() != 'triple-trouble')
					{
						FlxG.sound.play(Paths.sound('intro2'), 0.6);
					}
					focusOnDadGlobal = true;
					ZoomCam(true);
					boyfriend.dance();
				case 2:
					var set:FlxSprite = new FlxSprite().loadGraphic(Paths.image(introAlts[1]));
					set.scrollFactor.set();

					if (curStage.startsWith('school'))
						set.setGraphicSize(Std.int(set.width * daPixelZoom));

					set.screenCenter();
					add(set);
					FlxTween.tween(set, {y: set.y += 100, alpha: 0}, Conductor.crochet / 1000, {
						ease: FlxEase.cubeInOut,
						onComplete: function(twn:FlxTween)
						{
							set.destroy();
						}
					});
					if(SONG.song.toLowerCase() != 'triple-trouble')
					{
						if(awesomeChars.contains(dad.curCharacter))
						{
							FlxG.sound.play(Paths.sound('intro3'), 0.6);
						}
						else
						{
							FlxG.sound.play(Paths.sound('intro1'), 0.6);
						}
					}
					focusOnDadGlobal = false;
					ZoomCam(false);
					boyfriend.dance();
				case 3:
					creddy = new CreditPopup(-350, 150, SONG.song.toLowerCase());
					creddy.camera = camHUD;
					creddy.x = creddy.width * -1;
					add(creddy);
					FlxTween.tween(creddy, {x: 0}, 0.5, {ease: FlxEase.backOut});
					var go:FlxSprite = new FlxSprite();
					go.frames = Paths.getSparrowAtlas('goAnim');
					go.animation.addByPrefix('go', 'GO!!', 24, false);
					go.scrollFactor.set();
					go.updateHitbox();

					go.screenCenter();
					add(go);

					go.animation.play('go');
					if(boyfriend.animation.getByName('hey') != null)
					{
						boyfriend.playAnim('hey', true);
					}
					else if(boyfriend.animation.getByName('stand') != null)
					{
						boyfriend.playAnim('stand', true);
					}
					else if(boyfriend.animation.getByName('cheer') != null)
					{
						boyfriend.playAnim('cheer', true);
					}

					if(gf.animation.getByName('cheer') != null)
					{
						gf.playAnim('cheer', true);
					}

					if(dad.animation.getByName('hey') != null)
					{
						dad.playAnim('hey', true);
					}
					else if(dad.animation.getByName('stand') != null)
					{
						dad.playAnim('stand', true);
					}
					else if(dad.animation.getByName('cheer') != null)
					{
						dad.playAnim('cheer', true);
					}
					
					FlxTween.tween(go, {y: go.y += 100, alpha: 0}, Conductor.crochet / 1000, {
						ease: FlxEase.cubeInOut,
						onComplete: function(twn:FlxTween)
						{
							go.destroy();
						}
					});
					if(SONG.song.toLowerCase() != 'triple-trouble')
					{
						FlxG.sound.play(Paths.sound('introGo'), 0.6);
					}
					focusOnDadGlobal = true;
					ZoomCam(true);
				case 4:
					dad.dance();
					boyfriend.dance();
					gf.dance();
			}

			swagCounter += 1;
			// generateSong('fresh');
		}, 5);
	}

	var previousFrameTime:Int = 0;
	var lastReportedPlayheadPosition:Int = 0;
	var songTime:Float = 0;

	var songsWithOldAudio:Array<String> = ['wireframe', 'origin'];

	function startSong():Void
	{
		startingSong = false;

		previousFrameTime = FlxG.game.ticks;
		lastReportedPlayheadPosition = 0;

		if (!paused)
			if(songsWithOldAudio.contains(SONG.song.toLowerCase()) && FlxG.save.data.oldAudio)
			{
				FlxG.sound.playMusic(Paths.instOld(PlayState.SONG.song), 1, false);
			}
			else
			{
				FlxG.sound.playMusic(Paths.inst(PlayState.SONG.song), 1, false);
			}
		vocals.play();
		if (FlxG.save.data.tristanProgress == "pending play" && isStoryMode && storyWeek != 10)
		{
			FlxG.sound.music.volume = 0;
		}
		
		FlxG.sound.music.volume = 1; // WEIRD BUG!!! WTF!!!

		songLength = FlxG.sound.music.length;

		FlxTween.tween(timeTxt, {alpha: 1}, 0.5, {ease: FlxEase.circOut});

		#if desktop
		DiscordClient.changePresence(SONG.song,
			"\nAcc: "
			+ truncateFloat(accuracy, 2)
			+ "% | Score: "
			+ songScore
			+ " | Misses: "
			+ misses, iconRPC);
		#end
		FlxG.sound.music.onComplete = endSong;

		if (SONG.song.toLowerCase() == 'jambino')
			FlxTween.num(defaultCamZoom, 1, (Conductor.crochet / 1000) * 64, {onComplete: function(twn:FlxTween) defaultCamZoom = 0.65}, function(v:Float) defaultCamZoom = v);
	}

	var debugNum:Int = 0;
	var isFunnySong = false;

	private function generateSong(dataPath:String):Void
	{
		// FlxG.log.add(ChartParser.parse());

		var songData = SONG;
		Conductor.changeBPM(songData.bpm);

		curSong = songData.song;

		if (SONG.needsVoices) {
			if (SONG.song.toLowerCase() == 'algebra' && SaveFileState.saveFile.data.elfMode) vocals = new FlxSound().loadEmbedded(Paths.elf(PlayState.SONG.song));
			else if (songsWithOldAudio.contains(SONG.song.toLowerCase()) && FlxG.save.data.oldAudio) vocals = new FlxSound().loadEmbedded(Paths.voicesOld(PlayState.SONG.song));
			else vocals = new FlxSound().loadEmbedded(Paths.voices(PlayState.SONG.song));
		}	
		else
			vocals = new FlxSound();

		FlxG.sound.list.add(vocals);

		notes = new FlxTypedGroup<Note>();
		add(notes);

		var noteData:Array<SwagSection>;

		// NEW SHIT
		noteData = songData.notes;

		var playerCounter:Int = 0;

		var daBeats:Int = 0; // Not exactly representative of 'daBeats' lol, just how much it has looped
		for (section in noteData)
		{
			var coolSection:Int = Std.int(section.lengthInSteps / 4);

			for (songNotes in section.sectionNotes)
			{
				var daStrumTime:Float = songNotes[0];
				var daNoteData:Int = Std.int(songNotes[1] % 4);
				var daNoteStyle:String = songNotes[3];
				var skyFNF = false;

				if (SONG.song.toLowerCase() == 'ferocious' && daBeats > 214 && daBeats < 300) {
					daNoteStyle = 'bevel';
					skyFNF = true;
				}

				if (SONG.song.toLowerCase() == 'apprentice' && daBeats > 41 && daBeats < 91)
					daNoteStyle = '3d';

				var gottaHitNote:Bool = section.mustHitSection;

				if (songNotes[1] > 3)
				{
					gottaHitNote = !section.mustHitSection;
				}

				var oldNote:Note;
				if (unspawnNotes.length > 0)
					oldNote = unspawnNotes[Std.int(unspawnNotes.length - 1)];
				else
					oldNote = null;

				var swagNote:Note = new Note(daStrumTime, daNoteData, oldNote, false, gottaHitNote, daNoteStyle);
				swagNote.sustainLength = songNotes[2];
				swagNote.scrollFactor.set(0, 0);

				if (SONG.song.toLowerCase() == 'the-big-dingle' && section.altAnim) swagNote.alt = true;

				var susLength:Float = swagNote.sustainLength;

				susLength = susLength / Conductor.stepCrochet;
				unspawnNotes.push(swagNote);

				for (susNote in 0...Math.floor(susLength))
				{
					oldNote = unspawnNotes[Std.int(unspawnNotes.length - 1)];

					var sustainNote:Note = new Note(daStrumTime + (Conductor.stepCrochet * susNote) + Conductor.stepCrochet, daNoteData, oldNote, true,
						gottaHitNote, daNoteStyle);
					sustainNote.scrollFactor.set();
					unspawnNotes.push(sustainNote);

					sustainNote.mustPress = gottaHitNote;

					if (sustainNote.mustPress)
					{
						sustainNote.x += FlxG.width / 2; // general offset
					}
				}

				swagNote.mustPress = gottaHitNote;

				if (swagNote.mustPress)
				{
					swagNote.x += FlxG.width / 2; // general offset
				}
				else
				{
				}
			}
			daBeats += 1;
		}

		if (altSong != null) {
			altNotes = new FlxTypedGroup<Note>();
			isFunnySong = true;
			daBeats = 0;
			for (section in altSong.notes) {
				for (noteJunk in section.sectionNotes) {
					var swagNote:Note = new Note(noteJunk[0], Std.int(noteJunk[1] % 4), null, false, false, noteJunk[3]);
					swagNote.isAlt = true;

					altUnspawnNotes.push(swagNote);

					swagNote.mustPress = false;
					swagNote.x -= 250;
				}
			}
			altUnspawnNotes.sort(sortByShit);
		}

		// trace(unspawnNotes.length);
		// playerCounter += 1;

		unspawnNotes.sort(sortByShit);

		generatedMusic = true;
	}

	function sortByShit(Obj1:Note, Obj2:Note):Int
	{
		return FlxSort.byValues(FlxSort.ASCENDING, Obj1.strumTime, Obj2.strumTime);
	}

	var arrowJunks:Array<Array<Float>> = [];

	private function generateStaticArrows(player:Int, force2d:Bool = false, pixel:Bool = false, tweened:Bool = true):Void
	{
		var realFucker:Int = fucker;
		if(player == 0)
		{
			realFucker = 4;
		}
		for (i in 0...realFucker)
		{
			// FlxG.log.add(i);
			var babyArrow:Strum = new Strum(0, strumLine.y);

			var lotsOfPoip = true;	

			if(awesomeChars.contains(dadChar) || (awesomeChars.contains(bfChar) && player == 1))
			{
				babyArrow.frames = Paths.getSparrowAtlas('awesome_notes');
				babyArrow.animation.addByPrefix('green', 'arrowUP');
				babyArrow.animation.addByPrefix('blue', 'arrowDOWN');
				babyArrow.animation.addByPrefix('purple', 'arrowLEFT');
				babyArrow.animation.addByPrefix('red', 'arrowRIGHT');

				babyArrow.antialiasing = true;

				switch (Math.abs(i))
				{
					case 0:
						babyArrow.x += Note.swagWidth * 0;
						babyArrow.animation.addByPrefix('static', 'arrowLEFT');
						babyArrow.animation.addByPrefix('pressed', 'left press', 24, false);
						babyArrow.animation.addByPrefix('confirm', 'left confirm', 24, false);
					case 1:
						babyArrow.x += Note.swagWidth * 1;
						babyArrow.animation.addByPrefix('static', 'arrowDOWN');
						babyArrow.animation.addByPrefix('pressed', 'down press', 24, false);
						babyArrow.animation.addByPrefix('confirm', 'down confirm', 24, false);
					case 2:
						babyArrow.x += Note.swagWidth * 2;
						babyArrow.animation.addByPrefix('static', 'arrowUP');
						babyArrow.animation.addByPrefix('pressed', 'up press', 24, false);
						babyArrow.animation.addByPrefix('confirm', 'up confirm', 24, false);
					case 3:
						babyArrow.x += Note.swagWidth * 3;
						babyArrow.animation.addByPrefix('static', 'arrowRIGHT');
						babyArrow.animation.addByPrefix('pressed', 'right press', 24, false);
						babyArrow.animation.addByPrefix('confirm', 'right confirm', 24, false);
				}
			}
			else if ((Note.CharactersWith3D.contains(dad.curCharacter) && player == 0 || Note.CharactersWith3D.contains(boyfriend.curCharacter) && player == 1) && !force2d)
			{
				babyArrow.frames = Paths.getSparrowAtlas('NOTE_assets_3D');
				babyArrow.animation.addByPrefix('green', 'arrowUP');
				babyArrow.animation.addByPrefix('blue', 'arrowDOWN');
				babyArrow.animation.addByPrefix('purple', 'arrowLEFT');
				babyArrow.animation.addByPrefix('red', 'arrowRIGHT');

				if(isRing && player == 1)
				{
					switch (Math.abs(i))
					{
						case 0:
							babyArrow.x += Note.swagWidth * 0;
							babyArrow.animation.addByPrefix('static', 'arrowLEFT');
							babyArrow.animation.addByPrefix('pressed', 'left press', 24, false);
							babyArrow.animation.addByPrefix('confirm', 'left confirm', 24, false);
						case 1:
							babyArrow.x += Note.swagWidth * 1;
							babyArrow.animation.addByPrefix('static', 'arrowDOWN');
							babyArrow.animation.addByPrefix('pressed', 'down press', 24, false);
							babyArrow.animation.addByPrefix('confirm', 'down confirm', 24, false);
						case 2:
							babyArrow.frames = Paths.getSparrowAtlas('covers/gapple_notes');
							babyArrow.x += Note.swagWidth * 2;
							babyArrow.animation.addByPrefix('static', 'apple strum');
							babyArrow.animation.addByPrefix('pressed', 'apple press', 24, false);
							babyArrow.animation.addByPrefix('confirm', 'apple confirm', 24, false);
						case 3:
							babyArrow.x += Note.swagWidth * 3;
							babyArrow.animation.addByPrefix('static', 'arrowUP');
							babyArrow.animation.addByPrefix('pressed', 'up press', 24, false);
							babyArrow.animation.addByPrefix('confirm', 'up confirm', 24, false);
						case 4:
							babyArrow.x += Note.swagWidth * 4;
							babyArrow.animation.addByPrefix('static', 'arrowRIGHT');
							babyArrow.animation.addByPrefix('pressed', 'right press', 24, false);
							babyArrow.animation.addByPrefix('confirm', 'right confirm', 24, false);
					}
				}
				else
				{
					switch (Math.abs(i))
					{
						case 0:
							babyArrow.x += Note.swagWidth * 0;
							babyArrow.animation.addByPrefix('static', 'arrowLEFT');
							babyArrow.animation.addByPrefix('pressed', 'left press', 24, false);
							babyArrow.animation.addByPrefix('confirm', 'left confirm', 24, false);
						case 1:
							babyArrow.x += Note.swagWidth * 1;
							babyArrow.animation.addByPrefix('static', 'arrowDOWN');
							babyArrow.animation.addByPrefix('pressed', 'down press', 24, false);
							babyArrow.animation.addByPrefix('confirm', 'down confirm', 24, false);
						case 2:
							babyArrow.x += Note.swagWidth * 2;
							babyArrow.animation.addByPrefix('static', 'arrowUP');
							babyArrow.animation.addByPrefix('pressed', 'up press', 24, false);
							babyArrow.animation.addByPrefix('confirm', 'up confirm', 24, false);
						case 3:
							babyArrow.x += Note.swagWidth * 3;
							babyArrow.animation.addByPrefix('static', 'arrowRIGHT');
							babyArrow.animation.addByPrefix('pressed', 'right press', 24, false);
							babyArrow.animation.addByPrefix('confirm', 'right confirm', 24, false);
					}
				}
			}
			else
			{
				switch (curStage)
				{
					case 'funnyAnimalGame':
						lotsOfPoip = false;
						babyArrow.loadGraphic(Paths.image('BEVEL_NOTES'), true, 17 * 2, 17 * 2);
						babyArrow.animation.add('green', [6]);
						babyArrow.animation.add('red', [7]);
						babyArrow.animation.add('blue', [5]);
						babyArrow.animation.add('purplel', [4]);

						babyArrow.setGraphicSize(Std.int(babyArrow.width * (daPixelZoom / 2)));
						babyArrow.updateHitbox();
						babyArrow.antialiasing = false;

						babyArrow.setPosition(788, 164);

						if(FlxG.save.data.downscroll)
						{babyArrow.y += 350;}

						if (player == 0) {
							babyArrow.setPosition(-1280, -720);
						}

						switch (Math.abs(i))
						{
							case 0:
								babyArrow.x += babyArrow.width * 0;
								babyArrow.animation.add('static', [0]);
								babyArrow.animation.add('pressed', [4, 8], 12, false);
								babyArrow.animation.add('confirm', [12, 16], 24, false);
							case 1:
								babyArrow.x += babyArrow.width * 0.7 * 1;
								babyArrow.animation.add('static', [1]);
								babyArrow.animation.add('pressed', [5, 9], 12, false);
								babyArrow.animation.add('confirm', [13, 17], 24, false);
							case 2:
								babyArrow.x += babyArrow.width * 0.7 * 2;
								babyArrow.animation.add('static', [2]);
								babyArrow.animation.add('pressed', [6, 10], 12, false);
								babyArrow.animation.add('confirm', [14, 18], 12, false);
							case 3:
								babyArrow.x += babyArrow.width * 0.7 * 3;
								babyArrow.animation.add('static', [3]);
								babyArrow.animation.add('pressed', [7, 11], 12, false);
								babyArrow.animation.add('confirm', [15, 19], 24, false);
						}
					default:
						babyArrow.frames = Paths.getSparrowAtlas('NOTE_assets');
						babyArrow.animation.addByPrefix('green', 'arrowUP');
						babyArrow.animation.addByPrefix('blue', 'arrowDOWN');
						babyArrow.animation.addByPrefix('purple', 'arrowLEFT');
						babyArrow.animation.addByPrefix('red', 'arrowRIGHT');

						babyArrow.antialiasing = true;

						switch (Math.abs(i))
						{
							case 0:
								babyArrow.x += Note.swagWidth * 0;
								babyArrow.animation.addByPrefix('static', 'arrowLEFT');
								babyArrow.animation.addByPrefix('pressed', 'left press', 24, false);
								babyArrow.animation.addByPrefix('confirm', 'left confirm', 24, false);
							case 1:
								babyArrow.x += Note.swagWidth * 1;
								babyArrow.animation.addByPrefix('static', 'arrowDOWN');
								babyArrow.animation.addByPrefix('pressed', 'down press', 24, false);
								babyArrow.animation.addByPrefix('confirm', 'down confirm', 24, false);
							case 2:
								babyArrow.x += Note.swagWidth * 2;
								babyArrow.animation.addByPrefix('static', 'arrowUP');
								babyArrow.animation.addByPrefix('pressed', 'up press', 24, false);
								babyArrow.animation.addByPrefix('confirm', 'up confirm', 24, false);
							case 3:
								babyArrow.x += Note.swagWidth * 3;
								babyArrow.animation.addByPrefix('static', 'arrowRIGHT');
								babyArrow.animation.addByPrefix('pressed', 'right press', 24, false);
								babyArrow.animation.addByPrefix('confirm', 'right confirm', 24, false);
						}
				}
			}
			babyArrow.setGraphicSize(Std.int(babyArrow.width * 0.7));
			babyArrow.updateHitbox();
			babyArrow.scrollFactor.set();

			if ((tweened && SONG.song.toLowerCase() != 'ready-loud') || player == 1 && tweened && SONG.song.toLowerCase() == 'ready-loud') {
				babyArrow.y -= 10;
				babyArrow.alpha = 0;
				FlxTween.tween(babyArrow, {y: babyArrow.y + 10, alpha: 1}, 1, {ease: FlxEase.circOut, startDelay: 0.5 + (0.2 * i)});
			}
			
			if(SONG.song.toLowerCase() == 'ready-loud' && player != 1)
			{
				babyArrow.alpha = 0;
			}
			
			babyArrow.ID = i;

			if (player == 1)
			{
				playerStrums.add(babyArrow);
			}
			else
			{
				dadStrums.add(babyArrow);
			}

			babyArrow.animation.play('static');
			if (lotsOfPoip) {
				babyArrow.x += 50;
				babyArrow.x += ((FlxG.width / 2) * player);
			}

			strumLineNotes.add(babyArrow);

			if (isFunnySong || SONG.song.toLowerCase() == 'disruption' || SONG.song.toLowerCase() == 'minus-disruption' || SONG.song.toLowerCase() == 'enchanted' || SONG.song.toLowerCase() == 'ripple')
			arrowJunks.push([babyArrow.x, babyArrow.y]);
			
			babyArrow.resetTrueCoords();
		}

		if (SONG.song.toLowerCase() == 'applecore') {
			swagThings = new FlxTypedGroup<FlxSprite>();

			for (i in 0...4)
			{
				// FlxG.log.add(i);
				var babyArrow:Strum = new Strum(0, altStrumLine.y);

				babyArrow.frames = Paths.getSparrowAtlas('NOTE_assets_3D');
				babyArrow.animation.addByPrefix('green', 'arrowUP');
				babyArrow.animation.addByPrefix('blue', 'arrowDOWN');
				babyArrow.animation.addByPrefix('purple', 'arrowLEFT');
				babyArrow.animation.addByPrefix('red', 'arrowRIGHT');

				babyArrow.setGraphicSize(Std.int(babyArrow.width * 0.7));

				switch (Math.abs(i))
				{
					case 0:
						babyArrow.x += Note.swagWidth * 0;
						babyArrow.animation.addByPrefix('static', 'arrowLEFT');
						babyArrow.animation.addByPrefix('pressed', 'left press', 24, false);
						babyArrow.animation.addByPrefix('confirm', 'left confirm', 24, false);
					case 1:
						babyArrow.x += Note.swagWidth * 1;
						babyArrow.animation.addByPrefix('static', 'arrowDOWN');
						babyArrow.animation.addByPrefix('pressed', 'down press', 24, false);
						babyArrow.animation.addByPrefix('confirm', 'down confirm', 24, false);
					case 2:
						babyArrow.x += Note.swagWidth * 2;
						babyArrow.animation.addByPrefix('static', 'arrowUP');
						babyArrow.animation.addByPrefix('pressed', 'up press', 24, false);
						babyArrow.animation.addByPrefix('confirm', 'up confirm', 24, false);
					case 3:
						babyArrow.x += Note.swagWidth * 3;
						babyArrow.animation.addByPrefix('static', 'arrowRIGHT');
						babyArrow.animation.addByPrefix('pressed', 'right press', 24, false);
						babyArrow.animation.addByPrefix('confirm', 'right confirm', 24, false);
				}
				babyArrow.updateHitbox();

				babyArrow.y -= 10;
				babyArrow.alpha = 0;
				babyArrow.y -= 1000;

				babyArrow.ID = i;

				poopStrums.add(babyArrow);

				babyArrow.animation.play('static');
				babyArrow.x += 50;
				babyArrow.x -= 250;

				arrowJunks.push([babyArrow.x, babyArrow.y + 1000]);
				var hi = new FlxSprite(0, babyArrow.y);
				hi.ID = i;
				swagThings.add(hi);
			}

			add(poopStrums);
			/*poopStrums.forEach(function(spr:FlxSprite){
				spr.alpha = 0;
			});*/

			add(altNotes);
		}
	}

	private var swagThings:FlxTypedGroup<FlxSprite>;

	function tweenCamIn():Void
	{
		FlxTween.tween(FlxG.camera, {zoom: 1.3}, (Conductor.stepCrochet * 4 / 1000), {ease: FlxEase.elasticInOut});
	}

	override function openSubState(SubState:FlxSubState)
	{
		if (paused)
		{
			if (FlxG.sound.music != null)
			{
				FlxG.sound.music.pause();
				vocals.pause();
			}

			#if desktop
			DiscordClient.changePresence("PAUSED on "
				+ SONG.song,
				"Acc: "
				+ truncateFloat(accuracy, 2)
				+ "% | Score: "
				+ songScore
				+ " | Misses: "
				+ misses, iconRPC);
			#end
			if (!startTimer.finished)
				startTimer.active = false;
		}

		super.openSubState(SubState);
	}

	override function closeSubState()
	{
		if (paused)
		{
			if (FlxG.sound.music != null && !startingSong)
			{
				resyncVocals();
			}

			if (!startTimer.finished)
				startTimer.active = true;
			paused = false;

			if (startTimer.finished)
				{
					#if desktop
					DiscordClient.changePresence(SONG.song,
						"\nAcc: "
						+ truncateFloat(accuracy, 2)
						+ "% | Score: "
						+ songScore
						+ " | Misses: "
						+ misses, iconRPC, true,
						FlxG.sound.music.length
						- Conductor.songPosition);
					#end
				}
				else
				{
					#if desktop
					DiscordClient.changePresence(detailsText, SONG.song + " (" + storyDifficultyText + ") ", iconRPC);
					#end
				}
		}

		super.closeSubState();
	}

	var flingyBeef:Bool = false;

	function flingBfToOblivionAndBeyond(e:FlxTimer = null):Void
	{
		stupidx = -5;
		stupidy = -5;
		updatevels = true;
		
	}

	function resyncVocals():Void
	{
		vocals.pause();

		FlxG.sound.music.play();
		Conductor.songPosition = FlxG.sound.music.time;
		vocals.time = Conductor.songPosition;
		vocals.play();

		#if desktop
		DiscordClient.changePresence(detailsText
			+ " "
			+ SONG.song,
			"\nAcc: "
			+ truncateFloat(accuracy, 2)
			+ "% | Score: "
			+ songScore
			+ " | Misses: "
			+ misses, iconRPC);
		#end
	}

	private var paused:Bool = false;
	var startedCountdown:Bool = false;
	var canPause:Bool = true;

	function truncateFloat(number:Float, precision:Int):Float
	{
		var num = number;
		num = num * Math.pow(10, precision);
		num = Math.round(num) / Math.pow(10, precision);
		return num;
	}

	private var banduJunk:Float = 0;
	private var dadFront:Bool = false;
	private var hasJunked:Bool = false;
	private var wtfThing:Bool = false;
	private var orbit:Bool = true;
	private var poipInMahPahntsIsGud:Bool = true;
	private var unfairPart:Bool = false;
	private var noteJunksPlayer:Array<Float> = [0, 0, 0, 0];
	private var noteJunksDad:Array<Float> = [0, 0, 0, 0];
	private var what:FlxTypedGroup<FlxSprite>;
	private var wow2:Array<Array<Float>> = [];
	private var gasw2:Array<Float> = [];
	private var poiping:Bool = true;
	private var canPoip:Bool = true;
	private var lanceyLovesWow2:Array<Bool> = [false, false];
	private var whatDidRubyJustSay:Int = 0;

	override public function update(elapsed:Float)
	{
		elapsedtime += elapsed;

		if(FlxG.keys.justPressed.FIVE)
		{
			trace('ALRIGHT HERES YA INFO DUMP: \n\nDAD X: ' + dad.x + ' \nDAD Y: ' + dad.y + ' \nBF X: ' + boyfriend.x + ' \nBF Y: ' + boyfriend.y + ' \nCAM X: ' + camFollow.x + ' \nCAM Y: ' + camFollow.y);
		}

		FlxG.camera.color = fucksSprite.color;

		if(!timerClicked && FlxG.mouse.overlaps(timeTxt, camHUD) && FlxG.mouse.justPressed && SONG.song.toLowerCase() != 'ticking' && !SaveFileState.saveFile.data.foundTicking)
		{
			timerClicked = true;

			SaveFileState.saveFile.data.foundTicking = true;

			var poop:String = Highscore.formatSong('ticking', 1);

			trace(poop);

			PlayState.SONG = Song.loadFromJson(poop, 'ticking');
			PlayState.isStoryMode = false;
			PlayState.storyDifficulty = 1;

			PlayState.storyWeek = 2;
			PlayState.characteroverride = 'none';
			PlayState.formoverride = 'none';
			LoadingState.loadAndSwitchState(new PlayState());
		}

		if(bfSpazOut)
		{
			boyfriend.playAnim('sing' + notestuffs[FlxG.random.int(0,3)]);
		}
		dadChar = dad.curCharacter;
		bfChar = boyfriend.curCharacter;
		if(dadChar == 'gotta-sleep')
		{
			dad.x += 30;
			if(dad.x == 2000)
			{
				dad.x = -1000;
			}
		}
		if(redTunnel != null)
		{
			redTunnel.angle += elapsed * 3.5;
		}
		banduJunk += elapsed * 2.5;
		if(badaiTime && SONG.song.toLowerCase() != 'minus-wireframe' && SONG.song.toLowerCase() != 'ferocious' && SONG.song.toLowerCase() != 'jambino' && SONG.song.toLowerCase() != 'the-big-dingle' && SONG.song.toLowerCase() != 'resumed')
		{
			dad.angle += elapsed * 50;
		}
		if (curbg != null)
		{
			if (curbg.active) // only the furiosity background is active
			{
				var shad = cast(curbg.shader, Shaders.GlitchShader);
				shad.uTime.value[0] += elapsed;
			}
		}

		if (curStage == 'jambino') {
			if (newbg != null)
				{
					if (newbg.active) // only the furiosity background is active
					{
						var shad = cast(newbg.shader, Shaders.GlitchShader);
						shad.uTime.value[0] += elapsed;
						newbg.alpha = Math.sin(elapsedtime) / 2.5 + 0.6;
						//shad.alpha = new openfl.display.ShaderParameter_Float(Math.sin(elapsedtime) / 2.5 + 0.6);
					}
				}
		}

		if(playerStrums.members[0] != null && dadStrums.members[0] != null)
		{
			for(note in notes)
				{
					if(note.mustPress)
					{
						note.alpha = playerStrums.members[0].alpha;
					}
					else
					{
						note.alpha = dadStrums.members[0].alpha;
					}
		
					if(note.isSustainNote)
					{
						note.alpha -= 0.4;
					}
				}
			for(note in unspawnNotes)
				{
					if(note.mustPress)
					{
						note.alpha = playerStrums.members[0].alpha;
					}
					else
					{
						note.alpha = dadStrums.members[0].alpha;
					}
		
					if(note.isSustainNote)
					{
						note.alpha -= 0.4;
					}
				}
		}

		/*if (ihmp) {
			newbg.x = 295 + FlxG.random.int(-10, 10);
		}*/

		if (isRing)
			counterNum.text = Std.string(cNum);

		//dvd screensaver lookin ass
		if(daveFuckingDies != null && redTunnel != null && !daveFuckingDies.inCutscene)
		{
			FlxG.watch.addQuick("DAVE JUNK!!?!?!", [daveFuckingDies.x, daveFuckingDies.y]);
			if(daveFuckingDies.x >= (redTunnel.width - 1000) || daveFuckingDies.y >= (redTunnel.height - 1000))
			{
				daveFuckingDies.bounceAnimState = 1;
				daveFuckingDies.bounceMultiplier = FlxG.random.float(-0.75, -1.15);
				daveFuckingDies.yBullshit = FlxG.random.float(0.95, 1.05);
				daveFuckingDies.dance();
			}
			else if(daveFuckingDies.x <= (redTunnel.x + 100) || daveFuckingDies.y <= (redTunnel.y + 100))
			{
				daveFuckingDies.bounceAnimState = 2;
				daveFuckingDies.bounceMultiplier = FlxG.random.float(0.75, 1.15);
				daveFuckingDies.yBullshit = FlxG.random.float(0.95, 1.05);
				daveFuckingDies.dance();
			}
			else if(daveFuckingDies.x >= (redTunnel.width - 1150) || daveFuckingDies.y >= (redTunnel.height - 1150))
			{
				daveFuckingDies.bounceAnimState = 1;
			}
			else if(daveFuckingDies.x <= (redTunnel.x + 250) || daveFuckingDies.y <= (redTunnel.y + 250))
			{
				daveFuckingDies.bounceAnimState = 2;
			}
			else
			{
				daveFuckingDies.bounceAnimState = 0;
			}
		}

		playerStrums.forEach(function(spr:Strum){
			noteJunksPlayer[spr.ID] = spr.y;
		});
		dadStrums.forEach(function(spr:Strum){
			noteJunksDad[spr.ID] = spr.y;
		});
		if (unfairPart) {
			playerStrums.forEach(function(spr:Strum)
			{
				spr.x = ((FlxG.width / 2) - (spr.width / 2)) + (Math.sin(elapsedtime + (spr.ID)) * 300);
				spr.y = ((FlxG.height / 2) - (spr.height / 2)) + (Math.cos(elapsedtime + (spr.ID)) * 300);
			});
			dadStrums.forEach(function(spr:Strum)
			{
				spr.x = ((FlxG.width / 2) - (spr.width / 2)) + (Math.sin((elapsedtime + (spr.ID )) * 2) * 300);
				spr.y = ((FlxG.height / 2) - (spr.height / 2)) + (Math.cos((elapsedtime + (spr.ID)) * 2) * 300);
			});
		}

		if (SONG.song.toLowerCase() == 'grantare-sings-cheating') // fuck you
		{
			playerStrums.forEach(function(spr:FlxSprite)
			{
				spr.x += Math.sin(elapsedtime) * ((spr.ID % 2) == 0 ? 1 : -1);
				spr.x -= Math.sin(elapsedtime) * 1.5;
			});
			dadStrums.forEach(function(spr:FlxSprite)
			{
				spr.x -= Math.sin(elapsedtime) * ((spr.ID % 2) == 0 ? 1 : -1);
				spr.x += Math.sin(elapsedtime) * 1.5;
			});
		}

		if (SONG.song.toLowerCase() == 'applecore') {

			if (poiping) {
				what.forEach(function(spr:FlxSprite){
					spr.x += Math.abs(Math.sin(elapsed)) * gasw2[spr.ID];
					if (spr.x > 3000 && !lanceyLovesWow2[spr.ID]) {
						lanceyLovesWow2[spr.ID] = true;
						trace('whattttt ${spr.ID}');
						whatDidRubyJustSay++;
					}
				});
				if (whatDidRubyJustSay >= 2) poiping = false;
			}
			else if (canPoip) {
				trace("ON TO THE POIPIGN!!!");
				canPoip = false;
				lanceyLovesWow2 = [false, false];
				whatDidRubyJustSay = 0;
				new FlxTimer().start(FlxG.random.float(3, 6.3), function(tmr:FlxTimer){
					what.forEach(function(spr:FlxSprite){
						spr.visible = true;
						spr.x = FlxG.random.int(-2000, -3000);
						gasw2[spr.ID] = FlxG.random.int(600, 1200);
						if (spr.ID == 1) {
							trace("POIPING...");
							poiping = true;
							canPoip = true;
						}
					});
				});
			}

			what.forEach(function(spr:FlxSprite){
				var daCoords = wow2[spr.ID];

				daCoords[4] == 1 ? 
				spr.y = Math.cos(elapsedtime + spr.ID) * daCoords[3] + daCoords[1]: 
				spr.y = Math.sin(elapsedtime) * daCoords[3] + daCoords[1];

				spr.y += 45;

				var dontLookAtAmongUs:Float = Math.sin(elapsedtime * 1.5) * 0.05 + 0.95;

				spr.scale.set(dontLookAtAmongUs - 0.15, dontLookAtAmongUs - 0.15);

				if (dad.POOP) spr.angle += (Math.sin(elapsed * 2) * 0.5 + 0.5) * spr.ID == 1 ? 0.65 : -0.65;

				if(spr.animation.name == 'cartwheel')
				{
					spr.angle = 0;
				}
			});

			if (SONG.notes[Math.floor(curStep / 16)] != null) {
				if (SONG.notes[Math.floor(curStep / 16)].altAnim && !unfairPart) {
					var krunkThing = 60;
					playerStrums.forEach(function(spr:Strum)
					{
						spr.x = arrowJunks[spr.ID + 8][0] + (Math.sin(elapsedtime) * ((spr.ID % 2) == 0 ? 1 : -1)) * krunkThing;
						spr.y = arrowJunks[spr.ID + 8][1] + Math.sin(elapsedtime - 5) * ((spr.ID % 2) == 0 ? 1 : -1) * krunkThing;

						spr.scale.x = Math.abs(Math.sin(elapsedtime - 5) * ((spr.ID % 2) == 0 ? 1 : -1)) / 4;

						spr.scale.y = Math.abs((Math.sin(elapsedtime) * ((spr.ID % 2) == 0 ? 1 : -1)) / 2);

						spr.scale.x += 0.2;
						spr.scale.y += 0.2;

						spr.scale.x *= 1.5;
						spr.scale.y *= 1.5;
					});

					poopStrums.forEach(function(spr:Strum)
					{
						spr.x = arrowJunks[spr.ID + 4][0] + (Math.sin(elapsedtime) * ((spr.ID % 2) == 0 ? 1 : -1)) * krunkThing;
						spr.y = swagThings.members[spr.ID].y + Math.sin(elapsedtime - 5) * ((spr.ID % 2) == 0 ? 1 : -1) * krunkThing;

						spr.scale.x = Math.abs(Math.sin(elapsedtime - 5) * ((spr.ID % 2) == 0 ? 1 : -1)) / 4;

						spr.scale.y = Math.abs((Math.sin(elapsedtime) * ((spr.ID % 2) == 0 ? 1 : -1)) / 2);

						spr.scale.x += 0.2;
						spr.scale.y += 0.2;

						spr.scale.x *= 1.5;
						spr.scale.y *= 1.5;
					});

					notes.forEachAlive(function(spr:Note){
							spr.x = arrowJunks[spr.noteData + 8][0] + (Math.sin(elapsedtime) * ((spr.noteData % 2) == 0 ? 1 : -1)) * krunkThing;

							if (!spr.isSustainNote) {
		
								spr.scale.x = Math.abs(Math.sin(elapsedtime - 5) * ((spr.noteData % 2) == 0 ? 1 : -1)) / 4;
			
								spr.scale.y = Math.abs((Math.sin(elapsedtime) * ((spr.noteData % 2) == 0 ? 1 : -1)) / 2);
			
								spr.scale.x += 0.2;
								spr.scale.y += 0.2;
			
								spr.scale.x *= 1.5;
								spr.scale.y *= 1.5;
							}
					});
					altNotes.forEachAlive(function(spr:Note){
						spr.x = arrowJunks[(spr.noteData % 4) + 4][0] + (Math.sin(elapsedtime) * ((spr.noteData % 2) == 0 ? 1 : -1)) * krunkThing;
						#if debug
						if (FlxG.keys.justPressed.SPACE) {
							trace(arrowJunks[(spr.noteData % 4) + 4][0]);
							trace(spr.noteData);
							trace(spr.x == arrowJunks[(spr.noteData % 4) + 4][0] + (Math.sin(elapsedtime) * ((spr.noteData % 2) == 0 ? 1 : -1)) * krunkThing);
						}
						#end

						if (!spr.isSustainNote) {
		
							spr.scale.x = Math.abs(Math.sin(elapsedtime - 5) * ((spr.noteData % 2) == 0 ? 1 : -1)) / 4;
			
							spr.scale.y = Math.abs((Math.sin(elapsedtime) * ((spr.noteData % 2) == 0 ? 1 : -1)) / 2);
			
							spr.scale.x += 0.2;
							spr.scale.y += 0.2;
			
							spr.scale.x *= 1.5;
							spr.scale.y *= 1.5;
						}
					});
				}
				if (!SONG.notes[Math.floor(curStep / 16)].altAnim && wtfThing) {
					
					
				}
			}

			
		}

		if (updatevels)
		{
			stupidx *= 0.75;
			stupidy += elapsed * 2;
			boyfriend.x += stupidx;
			//boyfriend.y += stupidy;
		}

		//welcome to 3d sinning avenue
		if(funnyFloatyBoys.contains(dad.curCharacter.toLowerCase()) && canFloat && orbit)
		{
			switch(dad.curCharacter) 
			{
				case 'brob':
					if(SONG.song.toLowerCase() == 'fresh-and-toasted')
					{
						dad.y += (Math.sin(elapsedtime) * 0.6);
					}
				case 'bandu-candy':
					dad.x += Math.sin(elapsedtime * 50) / 9;
					dad.y += Math.sin(elapsedtime * 50) / 9;
				case 'bandu' |'bandu-sad' | '144p':
					dad.x = boyfriend.getMidpoint().x + Math.sin(banduJunk) * 500 - (dad.width / 2);
					dad.y += (Math.sin(elapsedtime) * 0.2);
					dadmirror.setPosition(dad.x, dad.y);

					//cool bandu scaleshit lets see how it works
					//it sucks
					/*
					var deezScale =	(
						!dadFront ?
						Math.sqrt(
					boyfriend.getMidpoint().distanceTo(dad.getMidpoint()) / 500 * 0.5):
					Math.sqrt(
					(500 - boyfriend.getMidpoint().distanceTo(dad.getMidpoint())) / 500 * 0.5 + 0.5));
					dad.scale.set(deezScale, deezScale);
					dadmirror.scale.set(deezScale, deezScale);*/

					//lets try again!!
					/*var dickScale = Math.sqrt(boyfriend.getMidpoint().distanceTo(dad.getMidpoint()));
					if(dadFront)
					{
						dickScale = (Math.sqrt((boyfriend.getMidpoint().distanceTo(dadmirror.getMidpoint())) + 0.5));
					}
					dickScale /= 25;
					dad.scale.set(dickScale, dickScale);
					dadmirror.scale.set(dickScale, dickScale);*/
					//it sucked again

					if ((Math.sin(banduJunk) >= 0.95 || Math.sin(banduJunk) <= -0.95) && !hasJunked){
						dadFront = !dadFront;
						hasJunked = true;
					}
					if (hasJunked && !(Math.sin(banduJunk) >= 0.95 || Math.sin(banduJunk) <= -0.95)) hasJunked = false;

					dadmirror.visible = dadFront;
					dad.visible = !dadFront;
				case 'badai' | 'batai':
					dad.angle = Math.sin(elapsedtime) * 15;
					dad.x += Math.sin(elapsedtime) * 0.6;
					dad.y += (Math.sin(elapsedtime) * 0.6);
				case 'ringi':
					dad.y += (Math.sin(elapsedtime) * 0.6);
					dad.x += (Math.sin(elapsedtime) * 0.6);
				case 'bambom' | 'dambai':
					dad.y += (Math.sin(elapsedtime) * 0.75);
					if (!badaiTime)
						dad.x = -700 + Math.sin(elapsedtime) * 425;
				case 'tunnel-dave':
					dad.y -= (Math.sin(elapsedtime) * 0.6);
				case 'gary':
					dad.y -= Math.cos(elapsedtime * 2)* 0.6;
					dad.x += Math.sin(elapsedtime)* 0.6;
				case 'barbu':
					if(SONG.song.toLowerCase() == 'fresh-and-toasted')
					{
						dad.x += Math.sin(elapsedtime) * 0.6;
					} 					
				default:
					dad.y += (Math.sin(elapsedtime) * 0.6);
			}
		}
		if(badai != null)
		{
			switch(badai.curCharacter) 
			{
				case 'brob':
					if(SONG.song.toLowerCase() == 'fresh-and-toasted')
					{
						badai.y += (Math.sin(elapsedtime) * 0.6);
					}
				case 'barbu':
					if(SONG.song.toLowerCase() == 'fresh-and-toasted')
					{
						badai.x += Math.sin(elapsedtime) * 0.6;
					}
				case 'badai' | 'batai':
					badai.angle = Math.sin(elapsedtime) * 15;
					badai.x += Math.sin(elapsedtime) * 0.6;
					badai.y += (Math.sin(elapsedtime) * 0.6);
				case 'car' | 'donk':
					
				case 'dambu':
					badai.y -= (Math.sin(elapsedtime) * 0.6);
				default:
					badai.y += (Math.sin(elapsedtime) * 0.6);
			}
		}
		if (littleIdiot != null) {
			if(funnyFloatyBoys.contains(littleIdiot.curCharacter.toLowerCase()) && canFloat && poipInMahPahntsIsGud)
			{
				littleIdiot.y += (Math.sin(elapsedtime) * 0.75);
				littleIdiot.x = 200 + Math.sin(elapsedtime) * 425;
			}
		}
		if (swagger != null) {
			if(funnyFloatyBoys.contains(swagger.curCharacter.toLowerCase()) && canFloat)
			{
				swagger.y += (Math.sin(elapsedtime) * 0.6);
			}
		}
		if(funnyFloatyBoys.contains(boyfriend.curCharacter.toLowerCase()) && canFloat)
		{
			switch(boyfriend.curCharacter)
			{
				
				case 'ringi':
					boyfriend.y += (Math.sin(elapsedtime) * 0.6);
					boyfriend.x += (Math.sin(elapsedtime) * 0.6);
				case 'bambom':
					boyfriend.y += (Math.sin(elapsedtime) * 0.75);
					boyfriend.x = 200 + Math.sin(elapsedtime) * 425;
				default:
					boyfriend.y += (Math.sin(elapsedtime) * 0.6);
			}
		}

		if (SONG.song.toLowerCase() == 'cheating') // fuck you
		{
			playerStrums.forEach(function(spr:Strum)
			{
				spr.x += Math.sin(elapsedtime) * ((spr.ID % 2) == 0 ? 1 : -1);
				spr.x -= Math.sin(elapsedtime) * 1.5;
			});
			dadStrums.forEach(function(spr:Strum)
			{
				spr.x -= Math.sin(elapsedtime) * ((spr.ID % 2) == 0 ? 1 : -1);
				spr.x += Math.sin(elapsedtime) * 1.5;
			});
		}

		if(SONG.song.toLowerCase() == 'cuberoot' && playerStrums.members[0] != null)
		{
			var multiPliers = 1;
			if(FlxG.save.data.downscroll)
			{multiPliers = -1;}
			strumLineNotes.forEachAlive(function(spr:Strum){
				spr.y = (Math.sin(elapsedtime + spr.ID) * (45 * multiPliers)) + 140/*sparta bpm!!*/;
				uhhEveryCool[spr.ID] = spr.y - strumLine.y;
			});

			
		}

		if(SONG.song.toLowerCase() == 'disability')
		{
			playerStrums.forEach(function(spr:Strum)
			{
				spr.angle += (Math.sin(elapsedtime * 2.5) + 1) * 5;
			});
			dadStrums.forEach(function(spr:Strum)
			{
				spr.angle += (Math.sin(elapsedtime * 2.5) + 1) * 5;
			});
			for(note in notes)
			{
				if(note.mustPress)
				{
					if (!note.isSustainNote)
						note.angle = playerStrums.members[note.noteData].angle;
				}
				else
				{
					if (!note.isSustainNote)
						note.angle = dadStrums.members[note.noteData].angle;
				}
			}
		}

		if(poop != null)
		{
			poop.alpha = Math.sin(elapsedtime) / 2.5 + 0.4;
		}

		if (SONG.song.toLowerCase() == 'disruption' || SONG.song.toLowerCase() == 'minus-disruption' || SONG.song.toLowerCase() == 'enchanted' || SONG.song.toLowerCase() == 'ripple') // deez all day
		{
			var krunkThing = 60;

			playerStrums.forEach(function(spr:FlxSprite)
			{
				spr.x = arrowJunks[spr.ID + 4][0] + (Math.sin(elapsedtime) * ((spr.ID % 2) == 0 ? 1 : -1)) * krunkThing;
				spr.y = arrowJunks[spr.ID + 4][1] + Math.sin(elapsedtime - 5) * ((spr.ID % 2) == 0 ? 1 : -1) * krunkThing;

				spr.scale.x = Math.abs(Math.sin(elapsedtime - 5) * ((spr.ID % 2) == 0 ? 1 : -1)) / 4;

				spr.scale.y = Math.abs((Math.sin(elapsedtime) * ((spr.ID % 2) == 0 ? 1 : -1)) / 2);

				spr.scale.x += 0.2;
				spr.scale.y += 0.2;

				spr.scale.x *= 1.5;
				spr.scale.y *= 1.5;
			});
			dadStrums.forEach(function(spr:Strum)
			{
				spr.x = arrowJunks[spr.ID][0] + (Math.sin(elapsedtime) * ((spr.ID % 2) == 0 ? 1 : -1)) * krunkThing;
				spr.y = arrowJunks[spr.ID][1] + Math.sin(elapsedtime - 5) * ((spr.ID % 2) == 0 ? 1 : -1) * krunkThing;
				
				spr.scale.x = Math.abs(Math.sin(elapsedtime - 5) * ((spr.ID % 2) == 0 ? 1 : -1)) / 4;

				spr.scale.y = Math.abs((Math.sin(elapsedtime) * ((spr.ID % 2) == 0 ? 1 : -1)) / 2);

				spr.scale.x += 0.2;
				spr.scale.y += 0.2;

				spr.scale.x *= 1.5;
				spr.scale.y *= 1.5;
			});

			notes.forEachAlive(function(spr:Note){
				if (spr.mustPress) {
					spr.x = arrowJunks[spr.noteData + 4][0] + (Math.sin(elapsedtime) * ((spr.noteData % 2) == 0 ? 1 : -1)) * krunkThing;
					spr.y = arrowJunks[spr.noteData + 4][1] + Math.sin(elapsedtime - 5) * ((spr.noteData % 2) == 0 ? 1 : -1) * krunkThing;

					spr.scale.x = Math.abs(Math.sin(elapsedtime - 5) * ((spr.noteData % 2) == 0 ? 1 : -1)) / 4;

					spr.scale.y = Math.abs((Math.sin(elapsedtime) * ((spr.noteData % 2) == 0 ? 1 : -1)) / 2);

					spr.scale.x += 0.2;
					spr.scale.y += 0.2;

					spr.scale.x *= 1.5;
					spr.scale.y *= 1.5;
				}
				else {
					spr.x = arrowJunks[spr.noteData][0] + (Math.sin(elapsedtime) * ((spr.noteData % 2) == 0 ? 1 : -1)) * krunkThing;
					spr.y = arrowJunks[spr.noteData][1] + Math.sin(elapsedtime - 5) * ((spr.noteData % 2) == 0 ? 1 : -1) * krunkThing;

					spr.scale.x = Math.abs(Math.sin(elapsedtime - 5) * ((spr.noteData % 2) == 0 ? 1 : -1)) / 4;

					spr.scale.y = Math.abs((Math.sin(elapsedtime) * ((spr.noteData % 2) == 0 ? 1 : -1)) / 2);

					spr.scale.x += 0.2;
					spr.scale.y += 0.2;

					spr.scale.x *= 1.5;
					spr.scale.y *= 1.5;
				}
			});
		}

		FlxG.watch.addQuick("WHAT", Conductor.songPosition);
			
		FlxG.camera.setFilters([new ShaderFilter(screenshader.shader)]); // this is very stupid but doesn't effect memory all that much so
		if (shakeCam && eyesoreson)
		{
			// var shad = cast(FlxG.camera.screen.shader,Shaders.PulseShader);
			FlxG.camera.shake(0.015, 0.015);
		}
		screenshader.shader.uTime.value[0] += elapsed;
		if (shakeCam && eyesoreson)
		{
			screenshader.shader.uampmul.value[0] = 1;
		}
		else
		{
			screenshader.shader.uampmul.value[0] -= (elapsed / 2);
		}
		screenshader.Enabled = shakeCam && eyesoreson;

		if (FlxG.keys.justPressed.NINE && !awesomeChars.contains(dad.curCharacter))
		{
			if (iconP1.animation.curAnim.name == boyfriendOldIcon)
			{
				iconP1.changeIcon(boyfriend.iconName);
			}
			else
			{
				iconP1.changeIcon(boyfriendOldIcon);
			}
		}

		for(i in pissyGroup.members)
		{
			if(i.ID % 2 == 0)
			{
				i.y += (Math.cos(elapsedtime) * -0.5);
				i.angle = Math.sin(elapsedtime + 2) * 15;
			}
			else
			{
				i.y += (Math.cos(elapsedtime) * 0.5);
				i.angle = Math.sin(elapsedtime + 2) * -15;
			}
		}

		if (pissStainDad != null) {
			if (zooBah) pissStainDad.y += (Math.cos(elapsedtime + 10) * -0.5);
			else pissStainDad.y = 185 + 50;
		}
		
		floaty += 0.03;

		var lerpVal:Float = CoolUtil.boundTo(elapsed * 2.4 * cameraSpeed, 0, 1);
		if(!inCutscene && camMoveAllowed)
			camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));

		super.update(elapsed);

		if (SONG.song.toLowerCase() == 'sunshine')
		{
			if (tailscircle == 'hovering' || tailscircle == 'circling')
				dad.y += Math.sin(floaty) * 1.3;
			if (tailscircle == 'circling')
				dad.x += Math.cos(floaty) * 1.3; // math B)
		}

		if(botplayTxt.visible) {
			botplaySine += 180 * elapsed;
			botplayTxt.alpha = 1 - Math.sin((Math.PI * botplaySine) / 180);
		}

		scoreTxt.text = "Score:" + songScore + " | Misses:" + misses + " | Accuracy:" + truncateFloat(accuracy, 2) + "% ";

		if (FlxG.keys.justPressed.ENTER && startedCountdown && canPause)
		{
			persistentUpdate = false;
			persistentDraw = true;
			paused = true;

			openSubState(new PauseSubState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
		}

		if (FlxG.keys.justPressed.SEVEN)
		{
			#if !debug
			if(CoolUtil.isSecretSong(SONG.song.toLowerCase()))
			{
				switch (SONG.song.toLowerCase()) {
					case 'penis':
						#if desktop
						DiscordClient.changePresence("Get back here. You aren't done.", null, null, true);
						#end
						FlxG.switchState(new GetBackState());
					default:
						CoolUtil.cheatersNeverProsper();
				}			
			}
			else
			{#end
				switch(SONG.song.toLowerCase())
				{
					case 'algebra':
						SaveFileState.saveFile.data.foundCell = true;

						PlayState.practicing = false;
					
						PlayState.fakedScore = false;
				
						PlayState.deathCounter = 0;
		
						var poop:String = Highscore.formatSong('cell', 1);
		
						trace(poop);
		
						PlayState.SONG = Song.loadFromJson(poop, 'cell');
						PlayState.isStoryMode = false;
						PlayState.storyDifficulty = 1;
		
						PlayState.storyWeek = 4;
						LoadingState.loadAndSwitchState(new PlayState());
					case 'disruption':
						SaveFileState.saveFile.data.elfMode ? {
							FlxG.switchState(new ElfState());
							#if desktop
							DiscordClient.changePresence("The elf watches.", null, null, true);
							#end
						}:
						{
							PlayState.characteroverride = 'none';
							PlayState.formoverride = 'none';
							FlxG.switchState(new ChartingState());
							#if desktop
							DiscordClient.changePresence("Chart Editor", null, null, true);
							#end
						}
					default:
						PlayState.characteroverride = 'none';
						PlayState.formoverride = 'none';
						FlxG.switchState(new ChartingState());
						#if desktop
						DiscordClient.changePresence("Chart Editor", null, null, true);
						#end
				}
			#if !debug } #end
		}

		// FlxG.watch.addQuick('VOL', vocals.amplitudeLeft);
		// FlxG.watch.addQuick('VOLRight', vocals.amplitudeRight);

		iconP1.centerOffsets();
		iconP2.centerOffsets();

		iconP1.updateHitbox();
		iconP2.updateHitbox();

		var iconOffset:Int = 26;

		iconP1.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01) - iconOffset);
		iconP2.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01)) - (iconP2.width - iconOffset);

		if (health > 2)
			health = 2;
		
		if(healthBar.percent > 80)
		{
			if(iconP2.charPublic != 'bandu-origin' && iconP2.charPublic != 'dave-unchecked')
			{
				iconP2.animation.curAnim.curFrame = 1;
			}
			if((iconP1.charPublic == 'awesomePlayer' || iconP1.charPublic == 'awesomeEnemy'))
			{
				iconP1.animation.curAnim.curFrame = 2;
			}
		}
		else if(healthBar.percent < 20)
		{
			if(iconP1.charPublic != 'bandu-origin' && iconP1.charPublic != 'dave-unchecked')
			{
				iconP1.animation.curAnim.curFrame = 1;
			}
			if((iconP2.charPublic == 'awesomePlayer' || iconP2.charPublic == 'awesomeEnemy'))
			{
				iconP2.animation.curAnim.curFrame = 2;
			}
		}
		else
		{
			if(iconP1.charPublic != 'bandu-origin' && iconP1.charPublic != 'dave-unchecked')
			{
				iconP1.animation.curAnim.curFrame = 0;
			}
			if(iconP2.charPublic != 'bandu-origin' && iconP2.charPublic != 'dave-unchecked')
			{
				iconP2.animation.curAnim.curFrame = 0;
			}
		}

		if (PlayState.SONG.song.toLowerCase() == 'penis') {
			if (FlxG.keys.justPressed.EIGHT || FlxG.keys.justPressed.SIX || FlxG.keys.justPressed.ZERO)
				FlxG.switchState(new GetBackState());
		}	
		else {
			if (FlxG.keys.justPressed.EIGHT)
			{
				PlayState.characteroverride = 'none';
				PlayState.formoverride = 'none';
				FlxG.switchState(new AnimationDebug(dad.curCharacter));
			}
			if (FlxG.keys.justPressed.SIX)
			{
				PlayState.characteroverride = 'none';
				PlayState.formoverride = 'none';
				FlxG.switchState(new AnimationDebug(boyfriend.curCharacter));
			}
			if (FlxG.keys.justPressed.ZERO)
			{
				PlayState.characteroverride = 'none';
				PlayState.formoverride = 'none';
				FlxG.switchState(new AnimationDebug(gf.curCharacter));
			}
		}
		
		if (startingSong)
		{
			if (startedCountdown)
			{
				Conductor.songPosition += FlxG.elapsed * 1000;
				if (Conductor.songPosition >= 0)
					startSong();
			}
		}
		else
		{
			// Conductor.songPosition = FlxG.sound.music.time;
			Conductor.songPosition += FlxG.elapsed * 1000;

			if (!paused)
			{
				songTime += FlxG.game.ticks - previousFrameTime;
				previousFrameTime = FlxG.game.ticks;

				// Interpolation type beat
				if (Conductor.lastSongPos != Conductor.songPosition)
				{
					songTime = (songTime + Conductor.songPosition) / 2;
					Conductor.lastSongPos = Conductor.songPosition;
					// Conductor.songPosition += FlxG.elapsed * 1000;
					// trace('MISSED FRAME');
				}

				if(updateTime) 
				{
					var curTime:Float = Conductor.songPosition;
					if(curTime < 0) curTime = 0;
					songPercent = (curTime / songLength);

					var songCalc:Float = (songLength - curTime);

					var secondsTotal:Int = Math.floor(songCalc / 1000);
					if(secondsTotal < 0) secondsTotal = 0;
					
					timeTxt.text = FlxStringUtil.formatTime(secondsTotal, false);
				}
			}

			// Conductor.lastSongPos = FlxG.sound.music.time;
		}

		FlxG.camera.zoom = FlxMath.lerp(defaultCamZoom, FlxG.camera.zoom, 0.95);
		camHUD.zoom = FlxMath.lerp(1, camHUD.zoom, 0.95);

		FlxG.watch.addQuick("beatShit", curBeat);
		FlxG.watch.addQuick("stepShit", curStep);

		if (curSong.toLowerCase() == 'furiosity')
		{
			switch (curBeat)
			{
				case 127:
					camZooming = true;
				case 159:
					camZooming = false;
				case 191:
					camZooming = true;
				case 223:
					camZooming = false;
			}
		}

		if (health <= 0 && !practicing && !perfectMode && !endingSong)
		{

			boyfriend.stunned = true;

			persistentUpdate = false;
			persistentDraw = false;
			paused = true;
	
			vocals.stop();
			FlxG.sound.music.stop();
	
			screenshader.shader.uampmul.value[0] = 0;
			screenshader.Enabled = false;

			if(shakeCam)
			{
				FlxG.save.data.unlockedcharacters[7] = true;
			}
			
			if(!perfectMode && !practicing && !endingSong)
			{
					deathCounter++;
					openSubState(new GameOverSubstate(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition()
						.y, formoverride == "bf" || formoverride == "none" ? SONG.player1 : formoverride));

						#if desktop
						DiscordClient.changePresence("GAME OVER -- "
						+ SONG.song
						+ " ("
						+ storyDifficultyText
						+ ") ",
						"\nAcc: "
						+ truncateFloat(accuracy, 2)
						+ "% | Score: "
						+ songScore
						+ " | Misses: "
						+ misses, iconRPC);
						#end
			}

			// FlxG.switchState(new GameOverState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
		}

		if (unspawnNotes[0] != null)
		{
			if (unspawnNotes[0].strumTime - Conductor.songPosition < (SONG.song.toLowerCase() == 'unfairness' ? 15000 : 1500))
			{
				var dunceNote:Note = unspawnNotes[0];
				notes.add(dunceNote);
				dunceNote.finishedGenerating = true;

				var index:Int = unspawnNotes.indexOf(dunceNote);
				unspawnNotes.splice(index, 1);
			}
		}

		if (altUnspawnNotes[0] != null)
		{
			if (altUnspawnNotes[0].strumTime - Conductor.songPosition < (SONG.song.toLowerCase() == 'unfairness' ? 15000 : 1500))
			{
				var dunceNote:Note = altUnspawnNotes[0];
				altNotes.add(dunceNote);
				dunceNote.finishedGenerating = true;

				var index:Int = altUnspawnNotes.indexOf(dunceNote);
				altUnspawnNotes.splice(index, 1);
			}
		}

		if (generatedMusic)
		{
			if (isFunnySong) {
				altNotes.forEachAlive(function(daNote:Note)
				{
					daNote.y = (altStrumLine.y - (Conductor.songPosition - daNote.strumTime) * (0.45 * FlxMath.roundDecimal((SONG.speed + 1) * 1, 2)));

					if (daNote.wasGoodHit)
					{
						swagger.playAnim('sing' + notestuffs[Math.round(Math.abs(daNote.noteData)) % 4], true);
						swagger.holdTimer = 0;
						
						FlxG.camera.shake(0.0075, 0.1);
						camHUD.shake(0.0045, 0.1);

						health -=  0.02 / 2.65;

						poopStrums.forEach(function(sprite:Strum)
						{
							if (Math.abs(Math.round(Math.abs(daNote.noteData)) % 4) == sprite.ID)
							{
								sprite.animation.play('confirm', true);
								if (sprite.animation.curAnim.name == 'confirm' && !curStage.startsWith('school') && !funnyPart)
									{
									sprite.centerOffsets();
									sprite.offset.x -= 13;
									sprite.offset.y -= 13;
								}
								else
								{
									sprite.centerOffsets();
								}
								sprite.animation.finishCallback = function(name:String)
								{
									sprite.animation.play('static',true);
									sprite.centerOffsets();
								}
								
							}
						});

						if (SONG.needsVoices)
							vocals.volume = 1;

						daNote.kill();
						altNotes.remove(daNote, true);
						daNote.destroy();
					}
				});
			}
			notes.forEachAlive(function(daNote:Note)
			{

				if (!daNote.mustPress && daNote.wasGoodHit)
				{
					if (tailscircle == 'circling' && SONG.song.toLowerCase() == 'sunshine')
					{
						add(ezTrail);
					}
					if (SONG.song.toLowerCase() == 'sunshine' && curStep > 588 && curStep < 860 && !daNote.isSustainNote)
					{
						dadStrums.forEach(function(spr:FlxSprite)
						{
							spr.alpha = 0.7;
							if (spr.alpha != 0)
							{
								new FlxTimer().start(0.01, function(trol:FlxTimer)
								{
									spr.alpha -= 0.03;
									if (spr.alpha != 0)
										trol.reset();
								});
							}
						});
						playerStrums.forEach(function(spr:FlxSprite)
						{
							spr.alpha = 0.7;
							if (spr.alpha != 0)
							{
								new FlxTimer().start(0.01, function(trol:FlxTimer)
								{
									spr.alpha -= 0.03;
									if (spr.alpha != 0)
										trol.reset();
								});
							}
						});
					}
					if (SONG.song != 'Tutorial')
						camZooming = true;

					var altAnim:String = "";
					var healthtolower:Float = 0.02;

					if (SONG.notes[Math.floor(curStep / 16)] != null)
					{
						if (SONG.notes[Math.floor(curStep / 16)].altAnim)
						{
							altAnim = '-alt';
						}
					}

					//'LEFT', 'DOWN', 'UP', 'RIGHT'
					var fuckingDumbassBullshitFuckYou:String;
					fuckingDumbassBullshitFuckYou = notestuffs[Math.round(Math.abs(daNote.noteData)) % 4];
					if(dad.nativelyPlayable)
					{
						switch(notestuffs[Math.round(Math.abs(daNote.noteData)) % 4])
						{
							case 'LEFT':
								fuckingDumbassBullshitFuckYou = 'RIGHT';
							case 'RIGHT':
								fuckingDumbassBullshitFuckYou = 'LEFT';
						}
					}
					if(shakingChars.contains(dad.curCharacter))
					{
						FlxG.camera.shake(0.0075, 0.1);
						camHUD.shake(0.0045, 0.1);
					}
					(SONG.song.toLowerCase() == 'applecore' && !SONG.notes[Math.floor(curStep / 16)].altAnim && !wtfThing && dad.POOP) ? { // hi
						if (littleIdiot != null) littleIdiot.playAnim('sing' + fuckingDumbassBullshitFuckYou + altAnim, true); 
						littleIdiot.holdTimer = 0;}: {
							if(badaiTime)
							{
								if (SONG.song.toLowerCase() == 'the-big-dingle') {

									dad.holdTimer = 0;
									dad.playAnim('sing' + fuckingDumbassBullshitFuckYou + altAnim, true);

									badai.holdTimer = 0;
									badai.playAnim('sing' + fuckingDumbassBullshitFuckYou + altAnim, true);
								}
								else {
									badai.holdTimer = 0;
									badai.playAnim('sing' + fuckingDumbassBullshitFuckYou + altAnim, true);
								}
							}
							else {
								if(daNote.isSustainNote)
								{
									if(dad.animation.getByName('sing' + fuckingDumbassBullshitFuckYou + '-hold') != null)
									{
										dad.playAnim('sing' + fuckingDumbassBullshitFuckYou + '-hold' + altAnim, true);
										dadmirror.playAnim('sing' + fuckingDumbassBullshitFuckYou + '-hold' + altAnim, true);
									}
									else
									{
										dad.playAnim('sing' + fuckingDumbassBullshitFuckYou + altAnim, true);
										dadmirror.playAnim('sing' + fuckingDumbassBullshitFuckYou + altAnim, true);
									}
								}
								else
								{
									dad.playAnim('sing' + fuckingDumbassBullshitFuckYou + altAnim, true);
									dadmirror.playAnim('sing' + fuckingDumbassBullshitFuckYou + altAnim, true);
									if (SONG.song.toLowerCase() == 'recovered-project' && sonicAllAmericanHotdogCombo && eyesoreson) {
										helloIAmNotMarcellosIAmMrBambiGiveMeYourFOOOOOOODDDDdddddd.forEach(function(spr:FlxSprite){
											spr.visible = spr.ID == daNote.noteData;
										});
									}
								}
								dad.holdTimer = 0;
								dadmirror.holdTimer = 0;
							}
						}

					if (SONG.song.toLowerCase() != 'senpai' && SONG.song.toLowerCase() != 'roses' && SONG.song.toLowerCase() != 'thorns')
					{
						dadStrums.forEach(function(sprite:Strum)
							{
								if (Math.abs(Math.round(Math.abs(daNote.noteData)) % 4) == sprite.ID)
								{
									sprite.animation.play('confirm', true);
									if (sprite.animation.curAnim.name == 'confirm' && !curStage.startsWith('school') && !funnyPart && (SONG.song.toLowerCase() != 'disability'))
									{
										if(!awesomeChars.contains(dad.curCharacter))
										{
											sprite.centerOffsets();
											sprite.offset.x -= 13;
											sprite.offset.y -= 13;
										}
									}
									else if (SONG.song.toLowerCase() != 'disability')
									{
										sprite.centerOffsets();
									}
									sprite.animation.finishCallback = function(name:String)
									{
										sprite.animation.play('static',true);
										if (SONG.song.toLowerCase() != 'disability')
											sprite.centerOffsets();
									}
		
								}
							});
					}

					if (UsingNewCam)
					{
						focusOnDadGlobal = true;
						if(camMoveAllowed)
							ZoomCam(true);
					}

					switch (SONG.song.toLowerCase())
					{
						case 'applecore':
							if (unfairPart) health -= (healthtolower / 12);
						case 'disruption' | 'ripple' | 'minus-disruption':
							health -= healthtolower / 2.65;
					}

					if (SONG.needsVoices)
						vocals.volume = 1;

					daNote.kill();
					notes.remove(daNote, true);
					daNote.destroy();
				}
				switch (SONG.song.toLowerCase())
				{
					case 'applecore':
						if (unfairPart)
						{
							daNote.y = ((daNote.mustPress ? noteJunksPlayer[daNote.noteData] : noteJunksDad[daNote.noteData])- (Conductor.songPosition - daNote.strumTime) * (-0.45 * FlxMath.roundDecimal(1 * daNote.LocalScrollSpeed, 2))) + strumYOffset; // couldnt figure out this stupid mystrum thing
						}
						else
						{
							if (FlxG.save.data.downscroll)
								daNote.y = (strumLine.y - (Conductor.songPosition - daNote.strumTime) * (-0.45 * FlxMath.roundDecimal(swagSpeed * 1, 2)))  + strumYOffset;
							else
								daNote.y = (strumLine.y - (Conductor.songPosition - daNote.strumTime) * (0.45 * FlxMath.roundDecimal(swagSpeed * 1, 2)))  + strumYOffset;
						}
					case 'ferocious':
						if (futurePad.visible) {
							daNote.x = 788 + (102 * 0.7) * daNote.noteData;
							if (!daNote.mustPress || ((!FlxG.save.data.downscroll && daNote.y < 90) || (FlxG.save.data.downscroll && daNote.y > 1280))) daNote.x = 243879;
							if (FlxG.save.data.downscroll)
								daNote.y = ((164 + 350) - (Conductor.songPosition - daNote.strumTime) * (-0.45 * FlxMath.roundDecimal((swagSpeed - 0.25) * daNote.LocalScrollSpeed, 2)))  + strumYOffset;
							else
								daNote.y = (164 - (Conductor.songPosition - daNote.strumTime) * (0.45 * FlxMath.roundDecimal((swagSpeed - 0.25) * daNote.LocalScrollSpeed, 2)))  + strumYOffset;
						}
						else {
							if (FlxG.save.data.downscroll)
								daNote.y = (strumLine.y - (Conductor.songPosition - daNote.strumTime) * (-0.45 * FlxMath.roundDecimal(swagSpeed * daNote.LocalScrollSpeed, 2))) + strumYOffset;
							else
								daNote.y = (strumLine.y - (Conductor.songPosition - daNote.strumTime) * (0.45 * FlxMath.roundDecimal(swagSpeed * daNote.LocalScrollSpeed, 2))) + strumYOffset;
						}
					case 'cuberoot':
						if (FlxG.save.data.downscroll)
							daNote.y = (strumLine.y - (Conductor.songPosition - daNote.strumTime) * (-0.45 * FlxMath.roundDecimal(swagSpeed * daNote.LocalScrollSpeed, 2)))  + uhhEveryCool[daNote.noteData];
						else
							daNote.y = (strumLine.y - (Conductor.songPosition - daNote.strumTime) * (0.45 * FlxMath.roundDecimal(swagSpeed * daNote.LocalScrollSpeed, 2))) + uhhEveryCool[daNote.noteData];
					default:
						if (unfairPart)
						{
							daNote.y = ((daNote.mustPress ? noteJunksPlayer[daNote.noteData] : noteJunksDad[daNote.noteData])- (Conductor.songPosition - daNote.strumTime) * (-0.45 * FlxMath.roundDecimal(1 * daNote.LocalScrollSpeed, 2))) + strumYOffset; // couldnt figure out this stupid mystrum thing
						}
						else if (FlxG.save.data.downscroll)
							daNote.y = (strumLine.y - (Conductor.songPosition - daNote.strumTime) * (-0.45 * FlxMath.roundDecimal(swagSpeed * daNote.LocalScrollSpeed, 2)))  + strumYOffset;
						else
							daNote.y = (strumLine.y - (Conductor.songPosition - daNote.strumTime) * (0.45 * FlxMath.roundDecimal(swagSpeed * daNote.LocalScrollSpeed, 2))) + strumYOffset;
				}
				// trace(daNote.y);
				// WIP interpolation shit? Need to fix the pause issue
				// daNote.y = (strumLine.y - (songTime - daNote.strumTime) * (0.45 * PlayState.SONG.speed));

				var strumliney = daNote.MyStrum != null ? daNote.MyStrum.y : strumLine.y;

				if (SONG.song.toLowerCase() == 'applecore') {
					if (unfairPart) strumliney = daNote.MyStrum != null ? daNote.MyStrum.y : strumLine.y;
					else strumliney = strumLine.y;
				}

				if (((daNote.y < -daNote.height && !FlxG.save.data.downscroll || daNote.y >= strumliney + 106 && FlxG.save.data.downscroll) && !unfairPart && SONG.song.toLowerCase() != 'applecore') 
					|| (unfairPart && daNote.y >= strumliney + 106) 
					|| (SONG.song.toLowerCase() == 'applecore' && !unfairPart && (daNote.y < -daNote.height && !FlxG.save.data.downscroll || daNote.y >= strumliney + 106 && FlxG.save.data.downscroll)))
				{
					/*
					trace((SONG.song.toLowerCase() == 'applecore' && unfairPart && daNote.y >= strumliney + 106) );
					trace(daNote.y);
					*/
					if (daNote.isSustainNote && daNote.wasGoodHit || daNote.isSustainNote && bottyPlay)
					{
						daNote.kill();
						notes.remove(daNote, true);
						daNote.destroy();
					}
					else
					{
						if(daNote.mustPress && daNote.finishedGenerating && !daNote.wasGoodHit && !bottyPlay)
							noteMiss(daNote.noteData, daNote.palooseNote, daNote.wizNote);
							if(!daNote.palooseNote && !daNote.wizNote)
							{
								if(!isRing || (isRing && daNote.noteData != 2))
								{
									health -= 0.075;
									vocals.volume = 0;
								}
							}
					}

					daNote.active = false;
					daNote.visible = false;

					daNote.kill();
					notes.remove(daNote, true);
					daNote.destroy();
				}
			});
		}

		if(camMoveAllowed && !inCutscene)
			ZoomCam(focusOnDadGlobal);

		if (!inCutscene)
			keyShit();

		#if debug
		if (FlxG.keys.justPressed.ONE)
			endSong();
		#end
	}

	public static var bottyPlay:Bool = false;

	function ZoomCam(focusondad:Bool):Void
	{
		if(SONG.song.toLowerCase() == 'ready-loud')
		{
			var dickBalls:FlxObject = new FlxObject(0, 0, 1, 1);
			dickBalls.screenCenter();
			camFollow.set(dickBalls.x, dickBalls.y);
			return;
		}
		var bfplaying:Bool = false;
		if (focusondad)
		{
			notes.forEachAlive(function(daNote:Note)
			{
				if (!bfplaying)
				{
					if (daNote.mustPress)
					{
						bfplaying = true;
					}
				}
			});
			if (UsingNewCam && bfplaying)
			{
				return;
			}
		}
		if (focusondad)
		{
			if (lookOverThere) focusondad = false;
			focusOnChar(badaiTime ? badai : dad);

			if (SONG.song.toLowerCase() == 'tutorial')
			{
				tweenCamIn();
			}
		}

		if (!focusondad)
		{
			camFollow.set(boyfriend.getMidpoint().x - 100, boyfriend.getMidpoint().y - 100);

			if (boyfriend.curCharacter == 'bandu-scaredy') camFollow.x += 350;

			if (curStage == 'algebra-cafe') camFollow.y -= 75;
			if (curStage == 'unhinged') camFollow.x -= 150;

			if (curStage == 'algebra-hall') camFollow.y = dad.getMidpoint().y - 100;

			if (boyfriend.curCharacter == 'bambi-piss-3d') camFollow.set(boyfriend.getMidpoint().x - 350, boyfriend.getMidpoint().y - 350);

			if (krunkity) {
				camFollow.y = brobgonal[1];
			}
			if (ihmp) {
				camFollow.y += 65;
				camFollow.x += 85;
			}

			if (SONG.song.toLowerCase() == 'deformation') focusOnChar(dad);

			if (chasePart2) camFollow.x -= 100;
			else {
				if (lookOverThere) camFollow.x -= 325;
				if (whatAmIDoing) camFollow.y -= 100;
				if(palooseMyDeez){camFollow.set(boyfriend.getMidpoint().x + 150, dad.getMidpoint().y - 60);}
			}

			

			if (dad.curCharacter == 'wizard') {
				camFollow.y -= 100;
			}
			if (boyfriend.curCharacter == 'eww-bf') camFollow.x -= 200;

			if (boyfriend.curCharacter == 'froing') camFollow.y += 30;

			if(SONG.song.toLowerCase() == 'minus-wireframe')
			{
				defaultCamZoom = 1.1;
			}

			if (SONG.song.toLowerCase() == 'tutorial')
			{
				FlxTween.tween(FlxG.camera, {zoom: 1}, (Conductor.stepCrochet * 4 / 1000), {ease: FlxEase.elasticInOut});
			}

			if(theDickPenis)
			{
				camFollow.x += boyfriend.curCamOffsetX;
				camFollow.y += boyfriend.curCamOffsetY;
			}

			if(curStage == 'cell')
			{
				focusOnChar(dad);
			}
		}
		
	}

	public static var xtraSong:Bool = false;

	private var krunkity:Bool = false;

	private var brobgonal:Array<Float> = [0, 0];

	function focusOnChar(char:Character) {
		camFollow.set(char.getMidpoint().x + 150, char.getMidpoint().y - 100);
		// camFollow.setPosition(lucky.getMidpoint().x - 120, lucky.getMidpoint().y + 210);

		switch (char.curCharacter)
		{
			case 'chipper':
				camFollow.y -= 150;
				camFollow.x -= 150;
			case 'blogblez':
				camFollow.y += 200;
			case 'wtf-lmao' | 'cock-cream':
				camFollow.y += 100;
			case 'brob':
				camFollow.y += 75;
			case 'badrum':
				camFollow.y -= 265;
				camFollow.x -= 50;
			case 'cell' | 'cell-mad':
				camFollow.set(650, 310);
			case 'bandu' | '144p':
				char.POOP ? {
				!SONG.notes[Math.floor(curStep / 16)].altAnim ? {
				camFollow.set(littleIdiot.getMidpoint().x, littleIdiot.getMidpoint().y - 300);
				} : {
					camFollow.set(swagger.getMidpoint().x + 150, swagger.getMidpoint().y - 100);
				}
			} : {
				camFollow.set(boyfriend.getMidpoint().x - 100, boyfriend.getMidpoint().y - 100);
			}
			case 'gotta-sleep':
				var dickBalls:FlxObject = new FlxObject(0, 0, 1, 1);
				dickBalls.screenCenter();
				dickBalls.y += 50;
				camFollow.set(dickBalls.x, dickBalls.y);
			case 'bandu-candy':
				camFollow.set(char.getMidpoint().x + 175, char.getMidpoint().y - 85);

			case 'playtime-2':
				camFollow.y += 54;

			case 'bambom':
				camFollow.y += 100;

			case 'dave-unchecked':
				camFollow.y += 100;
				camFollow.x -= 60;

			case 'alge':
				camFollow.y += 125;
				camFollow.x += 275;
			
			case 'butch':
				camFollow.y += 175;

			case 'sart-producer':
				camFollow.x -= 100;
			case 'sart-producer-night':
				camFollow.y += 250;
				camFollow.x -= 425;
			case 'bormp':
				camFollow.y += 75;
			case 'dave-wheels':
				camFollow.y -= 150;
			case 'hall-monitor':
				camFollow.x -= 200;
				camFollow.y -= 180;
			case 'playrobot' | 'playrobot-crazy':
				camFollow.x += 160;
				camFollow.y = boyfriend.getMidpoint().y - 100;
			case 'RECOVERED_PROJECT_2' | 'RECOVERED_PROJECT_3':
				camFollow.y += 400;
				camFollow.x += 125;
			case 'garrett-animal':
				camFollow.y += 45;
				if (!krunkity) {
					brobgonal = [camFollow.x, camFollow.y];
					krunkity = true;
				}
			case 'paloose-men':
				camFollow.x -= 150;
				camFollow.y += 100;
				if (inJail) {
					camFollow.set(char.getMidpoint().x + 150, char.getMidpoint().y + 100);
				}
			case 'wizard':
				camFollow.y += 85;
			case 'mr-music':
				camFollow.y -= 275;
				/*
			case 'car':
				camFollow.y -= 125;*/
			case 'do-you-accept':
				camFollow.x -= 435;
				camFollow.y += 65;
			case 'robot-guy' | 'batai':
				camFollow.x = 640;
				camFollow.y = 280;
				defaultCamZoom = 1;
			case 'crazed':
				camFollow.y += 150;
			case 'diamond-man-mugen':
				camFollow.y = boyfriend.getMidpoint().y - 80;
			case 'jambi':
				camFollow.y += 175;
			case 'ticking':
				camFollow.y += 75;
			case 'dingle':
				camFollow.y += 50;
			case 'donk':
				camFollow.y += 50;
				camFollow.x -= 50;
		}

		var cammyFuck:Bool = DUMBASSPLAYTIMETWOPOINTOHISCLOSERTOBFSOTHECAMSHOULDNTMOVEASFARASITDOES;

		if(theDickPenis)
		{
			if(cammyFuck)
			{
				camFollow.x += 75;
			}
			badaiTime ? {
				camFollow.x += badai.curCamOffsetX;
				camFollow.y += badai.curCamOffsetY;
			} : {
				camFollow.x += dad.curCamOffsetX;
				camFollow.y += dad.curCamOffsetY;
			}
			
		}
	}

	var ihmp:Bool = false;

	var charactersInThisSongWow:Array<String>;

	function endSong():Void
	{
		inCutscene = false;
		canPause = false;
		updateTime = false;

		FlxG.sound.music.volume = 0;
		vocals.volume = 0;

		if(!fakedScore)
		{
			for(i in charactersInThisSongWow)
			{
				SaveFileState.saveFile.data.charUnlock.set(i, true);
			}
		}

		if (SONG.validScore && !fakedScore)
		{
			trace("score is valid");
			#if !switch
			Highscore.saveScore(SONG.song, songScore, storyDifficulty, characteroverride == "none"
				|| characteroverride == "bf" ? "bf" : characteroverride);
			#end
		}

		endingSong = true;

		practicing = false;

		bottyPlay = false;

		fakedScore = false;

		deathCounter = 0;

		FlxG.save.flush();

		if(SONG.song.toLowerCase() == 'ferocious')
		{
			FlxG.switchState(new FerociousEnding(accuracy));
		}
		else
		{
			FlxG.switchState(new WinScreen(accuracy));
		}
	}

	function ughWhyDoesThisHaveToFuckingExist() 
	{
		FlxG.switchState(new PlayMenuState());
	}

	public static function ohMyFuckingFuckingFuckingGod(cat:String)
	{
		FlxG.switchState(new ExtraSongState(cat));
	}

	var endingSong:Bool = false;

	function nextSong()
	{
		var difficulty:String = "";

		if (storyDifficulty == 0)
			difficulty = '-easy';

		if (storyDifficulty == 2)
			difficulty = '-hard';

		if (storyDifficulty == 3)
			difficulty = '-unnerf';

		trace(PlayState.storyPlaylist[0].toLowerCase() + difficulty);

		FlxTransitionableState.skipNextTransIn = true;
		FlxTransitionableState.skipNextTransOut = true;
		
		prevCamFollow = camFollow;
		prevCamFollowPos = camFollowPos;

		endingSong = true;

		practicing = false;

		fakedScore = false;

		deathCounter = 0;

		PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + difficulty, PlayState.storyPlaylist[0]);
		FlxG.sound.music.stop();
		
		switch (curSong.toLowerCase())
		{
			default:
				LoadingState.loadAndSwitchState(new PlayState());
		}
	}

	/**
		STOLEN FROM SONIC.EXE ! ! ! LOL
	**/
	function removeStatics()
	{
		playerStrums.forEach(function(todel:Strum)
			{
				playerStrums.remove(todel);
				todel.destroy();
			});
		dadStrums.forEach(function(todel:Strum)
		{
			dadStrums.remove(todel);
			todel.destroy();
		});
		strumLineNotes.forEach(function(todel:Strum)
		{
			strumLineNotes.remove(todel);
			todel.destroy();
		});
	}


	var funnyPart:Bool = false;

	private function popUpScore(strumtime:Float, notedata:Int, pixelNote:Bool = false, threeDeeNote:Bool = false):Void
	{
		var noteDiff:Float = Math.abs(strumtime - Conductor.songPosition);
		// boyfriend.playAnim('hey');
		vocals.volume = 1;

		var placement:String = Std.string(combo);

		var coolText:FlxText = new FlxText(0, 0, 0, placement, 32);
		coolText.screenCenter();
		coolText.x = FlxG.width * 0.55;
		//

		var rating:FlxSprite = new FlxSprite();
		var score:Int = 350;

		var daRating:String = "sick";

		if (noteDiff > Conductor.safeZoneOffset * 2)
		{
			daRating = 'shit';
			totalNotesHit -= 2;
			score = -3000;
			ss = false;
			shits++;
		}
		else if (noteDiff < Conductor.safeZoneOffset * -2)
		{
			daRating = 'shit';
			totalNotesHit -= 2;
			score = -3000;
			ss = false;
			shits++;
		}
		else if (noteDiff > Conductor.safeZoneOffset * 0.45)
		{
			daRating = 'bad';
			score = -1000;
			totalNotesHit += 0.2;
			ss = false;
			bads++;
		}
		else if (noteDiff > Conductor.safeZoneOffset * 0.25)
		{
			daRating = 'good';
			totalNotesHit += 0.65;
			score = 200;
			ss = false;
			goods++;
		}
		if (daRating == 'sick')
		{
			totalNotesHit += 1;
			sicks++;
		}
		switch (notedata)
		{
			case 2:
				score = cast(FlxMath.roundDecimal(cast(score, Float) * curmult[2], 0), Int);
			case 3:
				score = cast(FlxMath.roundDecimal(cast(score, Float) * curmult[1], 0), Int);
			case 1:
				score = cast(FlxMath.roundDecimal(cast(score, Float) * curmult[3], 0), Int);
			case 0:
				score = cast(FlxMath.roundDecimal(cast(score, Float) * curmult[0], 0), Int);
		}

		if (daRating != 'shit' || daRating != 'bad')
		{
			songScore += score;

			/* if (combo > 60)
					daRating = 'sick';
				else if (combo > 12)
					daRating = 'good'
				else if (combo > 4)
					daRating = 'bad';
			*/

			if(scoreTxtTween != null) 
			{
				scoreTxtTween.cancel();
			}

			scoreTxt.scale.x = 1.1;
			scoreTxt.scale.y = 1.1;
			scoreTxtTween = FlxTween.tween(scoreTxt.scale, {x: 1, y: 1}, 0.2, {
				onComplete: function(twn:FlxTween) {
					scoreTxtTween = null;
				}
			});

			var pixelShitPart1:String = "";
			var pixelShitPart2:String = '';

			if(pixelNote)
			{
				pixelShitPart1 = 'pixelUi/';
				pixelShitPart2 = '-pixel';
			}
			else if(threeDeeNote)
			{
				pixelShitPart1 = '3dUi/';
				pixelShitPart2 = '-3d';
			}

			rating.loadGraphic(Paths.image(pixelShitPart1 + daRating + pixelShitPart2));
			rating.screenCenter();
			rating.x = coolText.x - 40;
			rating.y -= 60;
			rating.acceleration.y = 550;
			rating.velocity.y -= FlxG.random.int(140, 175);
			rating.velocity.x -= FlxG.random.int(0, 10);

			var comboSpr:FlxSprite = new FlxSprite().loadGraphic(Paths.image(pixelShitPart1 + 'combo' + pixelShitPart2));
			comboSpr.screenCenter();
			comboSpr.x = coolText.x;
			comboSpr.acceleration.y = 600;
			comboSpr.velocity.y -= 150;

			comboSpr.velocity.x += FlxG.random.int(1, 10);
			if (!funnyPart)
				add(rating);

			var multiplier:Float = 0.7;
			if(threeDeeNote){multiplier = 0.65;}
			if (!pixelNote)
			{
				rating.setGraphicSize(Std.int(rating.width * multiplier));
				if(!threeDeeNote)
				{
					rating.antialiasing = true;
				}
				comboSpr.setGraphicSize(Std.int(comboSpr.width * multiplier));
				if(!threeDeeNote)
				{
					comboSpr.antialiasing = true;
				}
			}
			else
			{
				rating.setGraphicSize(Std.int(rating.width * daPixelZoom * multiplier));
				comboSpr.setGraphicSize(Std.int(comboSpr.width * daPixelZoom * multiplier));
			}

			comboSpr.updateHitbox();
			rating.updateHitbox();

			var seperatedScore:Array<Int> = [];

			var comboSplit:Array<String> = (combo + "").split('');

			if (comboSplit.length == 2)
				seperatedScore.push(0); // make sure theres a 0 in front or it looks weird lol!

			for (i in 0...comboSplit.length)
			{
				var str:String = comboSplit[i];
				seperatedScore.push(Std.parseInt(str));
			}
			if (combo >= 10 || combo == 0 && !funnyPart)
				add(comboSpr);

			var daLoop:Int = 0;
			for (i in seperatedScore)
			{
				var numScore:FlxSprite = new FlxSprite().loadGraphic(Paths.image(pixelShitPart1 + 'num' + Std.int(i) + pixelShitPart2));
				numScore.screenCenter();
				numScore.x = coolText.x + (43 * daLoop) - 90;
				numScore.y += 80;

				var multiplier:Float = 0.5;
				if(threeDeeNote){multiplier = 0.45;}

				if (!pixelNote)
				{
					if(!threeDeeNote)
					{
						numScore.antialiasing = true;
					}
					numScore.setGraphicSize(Std.int(numScore.width * multiplier));
				}
				else
				{
					numScore.setGraphicSize(Std.int(numScore.width * daPixelZoom));
				}
				numScore.updateHitbox();

				numScore.acceleration.y = FlxG.random.int(200, 300);
				numScore.velocity.y -= FlxG.random.int(140, 160);
				numScore.velocity.x = FlxG.random.float(-5, 5);

				if ((combo >= 10 || combo == 0) && !funnyPart)
					add(numScore);

				FlxTween.tween(numScore, {alpha: 0}, 0.2, {
					onComplete: function(tween:FlxTween)
					{
						numScore.destroy();
					},
					startDelay: Conductor.crochet * 0.002
				});

				daLoop++;
			}
			/* 
				trace(combo);
				trace(seperatedScore);
			 */

			coolText.text = Std.string(seperatedScore);
			// add(coolText);

			FlxTween.tween(rating, {alpha: 0}, 0.2, {
				startDelay: Conductor.crochet * 0.001
			});

			FlxTween.tween(comboSpr, {alpha: 0}, 0.2, {
				onComplete: function(tween:FlxTween)
				{
					coolText.destroy();
					comboSpr.destroy();

					rating.destroy();
				},
				startDelay: Conductor.crochet * 0.001
			});

			curSection += 1;
		}
	}

	public function NearlyEquals(value1:Float, value2:Float, unimportantDifference:Float = 10):Bool
	{
		return Math.abs(FlxMath.roundDecimal(value1, 1) - FlxMath.roundDecimal(value2, 1)) < unimportantDifference;
	}

	var upHold:Bool = false;
	var downHold:Bool = false;
	var rightHold:Bool = false;
	var leftHold:Bool = false;

	public var botplaySine:Float = 0;
	public var botplayTxt:FlxText;

	private function keyShit():Void
	{
		// HOLDING
		var up = controls.UP;
		var right = controls.RIGHT;
		var down = controls.DOWN;
		var left = controls.LEFT;
		var apple = controls.APPLE;

		var upP = controls.UP_P;
		var rightP = controls.RIGHT_P;
		var downP = controls.DOWN_P;
		var leftP = controls.LEFT_P;
		var appleP = controls.APPLE_P;

		var upR = controls.UP_R;
		var rightR = controls.RIGHT_R;
		var downR = controls.DOWN_R;
		var leftR = controls.LEFT_R;
		var appleR = controls.APPLE_R;

		var controlArray:Array<Bool> = [leftP, downP, upP, rightP];
		if(isRing)
		{
			controlArray = [leftP, downP, appleP, upP, rightP];
		}

		// FlxG.watch.addQuick('asdfa', upP);
		if (((upP || rightP || downP || leftP || appleP) && !boyfriend.stunned && generatedMusic) || bottyPlay)
		{
			boyfriend.holdTimer = 0;

			var possibleNotes:Array<Note> = [];

			var ignoreList:Array<Int> = [];

			notes.forEachAlive(function(daNote:Note)
			{
				if (daNote.canBeHit && daNote.mustPress && !daNote.tooLate && !daNote.wasGoodHit && !daNote.isSustainNote && daNote.finishedGenerating)
				{
					possibleNotes.push(daNote);
				}
			});

			possibleNotes.sort((a, b) -> Std.int(a.noteData - b.noteData)); //sorting twice is necessary as far as i know
			haxe.ds.ArraySort.sort(possibleNotes, function(a, b):Int {
				var notetypecompare:Int = Std.int(a.noteData - b.noteData);

				if (notetypecompare == 0)
				{
					return Std.int(a.strumTime - b.strumTime);
				}
				return notetypecompare;
			});

			if (possibleNotes.length > 0)
			{
				var daNote = possibleNotes[0];

				if (bottyPlay) {
					noteCheck(true, daNote);
					return;
				}
				

				// Jump notes
				var lasthitnote:Int = -1;
				var lasthitnotetime:Float = -1;

				for (note in possibleNotes) 
				{
					var fuckinDick:Int = 4;
					if(isRing)
					{
						fuckinDick++;
					}
					if (controlArray[note.noteData % fuckinDick])
					{
						if (lasthitnotetime > Conductor.songPosition - Conductor.safeZoneOffset
							&& lasthitnotetime < Conductor.songPosition + (Conductor.safeZoneOffset * 0.2)) //reduce the past allowed barrier just so notes close together that aren't jacks dont cause missed inputs
						{
							if (((note.noteData % fuckinDick)) == ((lasthitnote % fuckinDick)))
							{
								continue; //the jacks are too close together
							}
						}
						lasthitnote = note.noteData;
						lasthitnotetime = note.strumTime;
						goodNoteHit(note);
					}
				}
				
				if (daNote.wasGoodHit)
				{
					daNote.kill();
					notes.remove(daNote, true);
					daNote.destroy();
				}
			}
			else if (!theFunne)
			{
				badNoteCheck(null);
			}
		}

		if ((up || right || down || left || apple) && generatedMusic)
		{
			notes.forEachAlive(function(daNote:Note)
			{
				if (daNote.canBeHit && daNote.mustPress && daNote.isSustainNote)
				{
					if(isRing)
					{
						switch (daNote.noteData)
						{
							// NOTES YOU ARE HOLDING
							case 3:
								if (up || upHold)
									goodNoteHit(daNote);
							case 4:
								if (right || rightHold)
									goodNoteHit(daNote);
							case 2:
								if(apple)
									goodNoteHit(daNote);
							case 1:
								if (down || downHold)
									goodNoteHit(daNote);
							case 0:
								if (left || leftHold)
									goodNoteHit(daNote);
						}
					}
					else
					{
						switch (daNote.noteData)
						{
							// NOTES YOU ARE HOLDING
							case 2:
								if (up || upHold)
									goodNoteHit(daNote);
							case 3:
								if (right || rightHold)
									goodNoteHit(daNote);
							case 1:
								if (down || downHold)
									goodNoteHit(daNote);
							case 0:
								if (left || leftHold)
									goodNoteHit(daNote);
						}
					}
				}
			});
		}

		if (boyfriend.holdTimer > Conductor.stepCrochet * 4 * 0.001 && !up && !down && !right && !left)
		{
			if (boyfriend.animation.curAnim.name.startsWith('sing') && !boyfriend.animation.curAnim.name.endsWith('miss'))
			{
				boyfriend.dance();
			}
		}

		playerStrums.forEach(function(spr:Strum)
		{
			if(isRing)
			{
				switch (spr.ID)
				{
					case 2:
						if (appleP && spr.animation.curAnim.name != 'confirm')
						{
							spr.animation.play('pressed');
						}
						if (appleR)
						{
							spr.animation.play('static');
						}
					case 3:
						if (upP && spr.animation.curAnim.name != 'confirm')
						{
							spr.animation.play('pressed');
						}
						if (upR)
						{
							spr.animation.play('static');
						}
					case 4:
						if (rightP && spr.animation.curAnim.name != 'confirm')
							spr.animation.play('pressed');
						if (rightR)
						{
							spr.animation.play('static');
						}
					case 1:
						if (downP && spr.animation.curAnim.name != 'confirm')
							spr.animation.play('pressed');
						if (downR)
						{
							spr.animation.play('static');
						}
					case 0:
						if (leftP && spr.animation.curAnim.name != 'confirm')
							spr.animation.play('pressed');
						if (leftR)
						{
							spr.animation.play('static');
						}
				}
			}
			else
			{
				switch (spr.ID)
				{
					case 2:
						if (upP && spr.animation.curAnim.name != 'confirm')
						{
							spr.animation.play('pressed');
						}
						if (upR)
						{
							spr.animation.play('static');
						}
					case 3:
						if (rightP && spr.animation.curAnim.name != 'confirm')
							spr.animation.play('pressed');
						if (rightR)
						{
							spr.animation.play('static');
						}
					case 1:
						if (downP && spr.animation.curAnim.name != 'confirm')
							spr.animation.play('pressed');
						if (downR)
						{
							spr.animation.play('static');
						}
					case 0:
						if (leftP && spr.animation.curAnim.name != 'confirm')
							spr.animation.play('pressed');
						if (leftR)
						{
							spr.animation.play('static');
						}
				}
			}

			if (spr.animation.curAnim.name == 'confirm' && !curStage.startsWith('school') && !funnyPart && (SONG.song.toLowerCase() != 'disability'))
			{
				if(!awesomeChars.contains(dad.curCharacter))
				{
					spr.centerOffsets();
					spr.offset.x -= 13;
					spr.offset.y -= 13;
				}
			}
			else if (SONG.song.toLowerCase() != 'disability')
				spr.centerOffsets();
			else
				spr.smartCenterOffsets();
		});
	}

	function noteMiss(direction:Int = 1, paloose:Bool = false, magic:Bool = false):Void
	{
		if((isRing && direction == 2) || paloose || magic)
		{
			return;
		}
		if (!boyfriend.stunned)
		{
			health -= 0.04;
			//trace("note miss");
			if (combo > 5 && gf.animOffsets.exists('sad'))
			{
				gf.playAnim('sad');
			}
			combo = 0;
			misses++;

			songScore -= 10;

			if(awesomeChars.contains(dad.curCharacter))
			{
				FlxG.sound.play(Paths.sound('awesome_miss'), 1);
			}
			else
			{
				FlxG.sound.play(Paths.soundRandom('missnote', 1, 3), FlxG.random.float(0.1, 0.2));
				// FlxG.sound.play(Paths.sound('missnote1'), 1, false);
				// FlxG.log.add('played imss note');
			}
			if (boyfriend.animation.getByName("singLEFTmiss") != null)
			{
				/*//'LEFT', 'DOWN', 'UP', 'RIGHT'
				var fuckingDumbassBullshitFuckYou:String;
				fuckingDumbassBullshitFuckYou = notestuffs[Math.round(Math.abs(direction)) % 4];
				if(!boyfriend.nativelyPlayable)
				{
					switch(notestuffs[Math.round(Math.abs(direction)) % 4])
					{
						case 'LEFT':
							fuckingDumbassBullshitFuckYou = 'RIGHT';
						case 'RIGHT':
							fuckingDumbassBullshitFuckYou = 'LEFT';
					}
				}
				boyfriend.playAnim('sing' + fuckingDumbassBullshitFuckYou + "miss", true);*/
				switch (direction)
				{
					case 4:
						if (isRing)
						{
							boyfriend.playAnim('singRIGHTmiss', true);
						}
					case 2:
						if (!isRing)
						{
							boyfriend.playAnim('singUPmiss', true);
						}
					case 3:
						if (!isRing)
						{
							boyfriend.playAnim('singRIGHTmiss', true);
						}
						else
						{
							boyfriend.playAnim('singUPmiss', true);
						}
					case 1:
						boyfriend.playAnim('singDOWNmiss', true);
	
					case 0:
						boyfriend.playAnim('singLEFTmiss', true);
				}
			}
			else
			{
				boyfriend.color = FlxColor.fromRGB(86, 86, 148);
				//'LEFT', 'DOWN', 'UP', 'RIGHT'
				/*var fuckingDumbassBullshitFuckYou:String;
				fuckingDumbassBullshitFuckYou = notestuffs[Math.round(Math.abs(direction)) % 4];
				if(!boyfriend.nativelyPlayable)
				{
					switch(notestuffs[Math.round(Math.abs(direction)) % 4])
					{
						case 'LEFT':
							fuckingDumbassBullshitFuckYou = 'RIGHT';
						case 'RIGHT':
							fuckingDumbassBullshitFuckYou = 'LEFT';
					}
				}
				boyfriend.playAnim('sing' + fuckingDumbassBullshitFuckYou, true);*/
				switch (direction)
				{
					case 4:
						if (isRing)
						{
							boyfriend.playAnim('singRIGHT', true);
						}
					case 2:
						if (!isRing)
						{
							boyfriend.playAnim('singUP', true);
						}
					case 3:
						if (!isRing)
						{
							boyfriend.playAnim('singRIGHT', true);
						}
						else
						{
							boyfriend.playAnim('singUP', true);
						}
					case 1:
						boyfriend.playAnim('singDOWN', true);
	
					case 0:
						boyfriend.playAnim('singLEFT', true);
				}
			}

			updateAccuracy();
		}
	}

	function badNoteCheck(note:Note = null)
	{
		if(bottyPlay)
		{
			return;
		}
		// just double pasting this shit cuz fuk u
		// REDO THIS SYSTEM!
		if (note != null)
		{
			if(note.mustPress && note.finishedGenerating && !bottyPlay)
			{
				noteMiss(note.noteData, note.palooseNote, note.wizNote);
			}
			return;
		}
		var upP = controls.UP_P;
		var rightP = controls.RIGHT_P;
		var downP = controls.DOWN_P;
		var leftP = controls.LEFT_P;
		var appleP = controls.APPLE_P;

		if(isRing)
		{
			if (leftP)
				noteMiss(0);
			if (upP)
				noteMiss(3);
			if (rightP)
				noteMiss(4);
			if (downP)
				noteMiss(1);
		}
		else
		{
			if (leftP)
				noteMiss(0);
			if (upP)
				noteMiss(2);
			if (rightP)
				noteMiss(3);
			if (downP)
				noteMiss(1);
		}
		updateAccuracy();
	}

	function updateAccuracy()
	{
		if (misses > 0 || accuracy < 96)
			fc = false;
		else
			fc = true;
		totalPlayed += 1;
		accuracy = totalNotesHit / totalPlayed * 100;
	}

	function noteCheck(keyP:Bool, note:Note):Void // sorry lol
	{
		var noteDiff:Float = Math.abs(note.strumTime - Conductor.songPosition);

		var placement:String = Std.string(combo);
		var score:Int = 350;

		var daRating:String = "sick";

		if (noteDiff > Conductor.safeZoneOffset * 2)
		{
			daRating = 'shit';
		}
		else if (noteDiff < Conductor.safeZoneOffset * -2)
		{
			daRating = 'shit';
		}
		else if (noteDiff > Conductor.safeZoneOffset * 0.45)
		{
			daRating = 'bad';
		}
		else if (noteDiff > Conductor.safeZoneOffset * 0.25)
		{
			daRating = 'good';
		}

		if(bottyPlay && daRating == 'sick')
		{
			goodNoteHit(note);
			return;
		}
		if (keyP)
		{
			goodNoteHit(note);
		}
		else if (!theFunne)
		{
			badNoteCheck(note);
		}
	}

	var wizAngleTween:FlxTween = null;
	var wizAngleTween2:FlxTween = null;

	var wizColorTween:FlxTween = null;

	//public var camColor:FlxColor = FlxColor.WHITE;

	var fucksSprite:FlxSprite = new FlxSprite(0, 0).makeGraphic(1, 1, FlxColor.WHITE);

	function daWizzing()
	{
		if(wizAngleTween != null)
		{
			wizAngleTween.cancel();
		}
		if(wizAngleTween2 != null)
		{
			wizAngleTween2.cancel();
		}
		if(wizColorTween != null)
		{
			wizColorTween.cancel();
		}

		FlxG.camera.angle = FlxG.random.float(-100, 100);

		camHUD.angle = FlxG.random.float(-45, 45);

		fucksSprite.color = FlxColor.fromRGB(FlxG.random.int(0, 255), FlxG.random.int(0, 255), FlxG.random.int(0, 255));

		wizAngleTween = FlxTween.tween(FlxG.camera, {angle: 0}, (Conductor.crochet / 1000) * 16);

		wizAngleTween2 = FlxTween.tween(camHUD, {angle: 0}, (Conductor.crochet / 1000) * 16);

		wizColorTween = FlxTween.color(fucksSprite, (Conductor.crochet / 1000) * 16, fucksSprite.color, FlxColor.WHITE);
	}

	function daPaloosin() 
	{
		var dickyThing:Float = 5;
		if(FlxG.save.data.downscroll)
		{
			dickyThing = -5;
		}
		strumYOffset += dickyThing;
		for(bitch in playerStrums)
		{
			bitch.y += dickyThing;
		}
		for(bitch in dadStrums)
		{
			bitch.y += dickyThing;
		}
	}

	function goodNoteHit(note:Note):Void
	{
		if(note.wizNote)
		{
			note.wasGoodHit = true;
			daWizzing();
			return;
		}
		else if(note.palooseNote)
		{
			note.wasGoodHit = true;
			daPaloosin();
			return;
		}

		if (isRing && note.noteData == 2 && !note.isSustainNote)
		{
			FlxG.sound.play(Paths.sound('applenote'));
			cNum += 1;
		}
		if (!note.wasGoodHit)
		{
			if (!note.isSustainNote)
			{
				if((isRing && note.noteData != 2) || !isRing)
				{
					popUpScore(note.strumTime, note.noteData, note.isPixelNote, note.is3dNote);
				}
				if (FlxG.save.data.donoteclick)
				{
					FlxG.sound.play(Paths.sound('note_click'));
				}
				combo += 1;

			}
			else
				totalNotesHit += 1;

			if (note.isSustainNote)
				health += 0.004;
			else
				health += 0.023;

			if (darkLevels.contains(curStage) && SONG.song.toLowerCase() != "polygonized")
			{
				boyfriend.color = nightColor;
			}
			else if(sunsetLevels.contains(curStage))
			{
				boyfriend.color = sunsetColor;
			}
			else
			{
				boyfriend.color = FlxColor.WHITE;
			}

			//sadly gotta sacrifice coolness for golden apple notes :( 
			//'LEFT', 'DOWN', 'UP', 'RIGHT'
			/*
			var fuckingDumbassBullshitFuckYou:String;
			fuckingDumbassBullshitFuckYou = notestuffs[Math.round(Math.abs(note.noteData)) % 4];
			if(!boyfriend.nativelyPlayable)
			{
				switch(notestuffs[Math.round(Math.abs(note.noteData)) % 4])
				{
					case 'LEFT':
						fuckingDumbassBullshitFuckYou = 'RIGHT';
					case 'RIGHT':
						fuckingDumbassBullshitFuckYou = 'LEFT';
				}
			}
			boyfriend.playAnim('sing' + fuckingDumbassBullshitFuckYou, true);
			*/
			if(shakingChars.contains(boyfriend.curCharacter) && !(SONG.song.toLowerCase() == 'cuberoot' && boyfriend.curCharacter == 'bambi-piss-3d'))
			{
				FlxG.camera.shake(0.0075, 0.1);
				camHUD.shake(0.0045, 0.1);
			}
			switch (note.noteData)
			{
				case 4:
					if (isRing)
					{
						if(note.isSustainNote)
						{
							if(boyfriend.animation.getByName('singRIGHT-hold') != null)
							{
								boyfriend.playAnim('singRIGHT-hold', true);
							}
							else
							{
								boyfriend.playAnim('singRIGHT', true);
							}
						}
						else
						{
							boyfriend.playAnim('singRIGHT', true);
						}
					}
				case 2:
					if (!isRing)
					{
						if(note.isSustainNote)
						{
							if(boyfriend.animation.getByName('singUP-hold') != null)
							{
								boyfriend.playAnim('singUP-hold', true);
							}
							else
							{
								boyfriend.playAnim('singUP', true);
							}
						}
						else
						{
							boyfriend.playAnim('singUP', true);
						}
					}
				case 3:
					if (!isRing)
					{
						if(note.isSustainNote)
						{
							if(boyfriend.animation.getByName('singRIGHT-hold') != null)
							{
								boyfriend.playAnim('singRIGHT-hold', true);
							}
							else
							{
								boyfriend.playAnim('singRIGHT', true);
							}
						}
						else
						{
							boyfriend.playAnim('singRIGHT', true);
						}
					}
					else
					{
						if(note.isSustainNote)
						{
							if(boyfriend.animation.getByName('singUP-hold') != null)
							{
								boyfriend.playAnim('singUP-hold', true);
							}
							else
							{
								boyfriend.playAnim('singUP', true);
							}
						}
						else
						{
							boyfriend.playAnim('singUP', true);
						}
					}
				case 1:
					if(note.isSustainNote)
					{
						if(boyfriend.animation.getByName('singDOWN-hold') != null)
						{
							boyfriend.playAnim('singDOWN-hold', true);
						}
						else
						{
							boyfriend.playAnim('singDOWN', true);
						}
					}
					else
					{
						boyfriend.playAnim('singDOWN', true);
					}

				case 0:
					if(note.isSustainNote)
					{
						if(boyfriend.animation.getByName('singLEFT-hold') != null)
						{
							boyfriend.playAnim('singLEFT-hold', true);
						}
						else
						{
							boyfriend.playAnim('singLEFT', true);
						}
					}
					else
					{
						boyfriend.playAnim('singLEFT', true);
					}
			}
			if (UsingNewCam)
			{
				focusOnDadGlobal = false;
				if(camMoveAllowed)
					ZoomCam(false);
			}

			playerStrums.forEach(function(spr:Strum)
			{
				if (Math.abs(note.noteData) == spr.ID)
				{
					spr.animation.play('confirm', true);
					if(bottyPlay)
					{
						spr.animation.finishCallback = function(name:String)
						{
							spr.animation.play('static',true);
							if (SONG.song.toLowerCase() != 'disability')
								spr.centerOffsets();
						}
					}
				}
			});

			note.wasGoodHit = true;
			vocals.volume = 1;

			note.kill();
			notes.remove(note, true);
			note.destroy();

			updateAccuracy();
		}
	}

	override function stepHit()
	{
		super.stepHit();

		if(SONG.song.toLowerCase() == 'deformation')
		{
			switch(curStep + 512)
			{
				case 1008:
				{
					FlxTween.tween(dad, {alpha: 1}, Conductor.crochet / 250);
					FlxTween.tween(iconP2, {alpha: 1}, Conductor.crochet / 250);
				}
				case 2048 | 3840 | 5376:
				{
					FlxTween.tween(dad, {alpha: 0}, Conductor.crochet / 250);
					FlxTween.tween(iconP2, {alpha: 0}, Conductor.crochet / 250);
				}
				case 2556:
				{
					swapDad('butch', 200, 100 + 200, true, FlxColor.BLACK);
					dad.alpha = 0;
					iconP2.changeIcon(dad.iconName);
					iconP2.alpha = 0;
					reloadTrixBg(1);
					FlxTween.tween(dad, {alpha: 1}, Conductor.crochet / 1000);
					FlxTween.tween(iconP2, {alpha: 1}, Conductor.crochet / 1000);
				}
				case 4352:
				{
					swapDad('bad', 200, 235, true, FlxColor.BLACK);
					dad.alpha = 0;
					iconP2.changeIcon(dad.iconName);
					iconP2.alpha = 0;
					reloadTrixBg(2);
					FlxTween.tween(dad, {alpha: 1}, Conductor.crochet / 1000);
					FlxTween.tween(iconP2, {alpha: 1}, Conductor.crochet / 1000);
				}
			}
		}

		if(SONG.song.toLowerCase() == 'unhinged' && curStep == 1228)
		{
			dad.canDance = false;
			dad.canSing = false;
			dad.playAnim('scream', true);
		}

		if(SONG.song.toLowerCase() == 'dave-x-bambi-shipping-cute')
		{
			switch(curStep)
			{
				case 40 | 42 | 44 | 46 | 104 | 106 | 108 | 109 | 110 | 288 | 290 | 292 | 294 | 296 | 298 | 300 | 301 | 302 | 552 | 554 | 556 | 558 | 616 | 618 | 620 | 621 | 622 | 800 | 802 | 804 | 806 | 807 | 808 | 810 | 812 | 814:
					dad.playAnim('singSmash', true);
				case 412:
					dad.curCamOffsetX = 0;
					dad.curCamOffsetY = 0;
					boyfriend.curCamOffsetX = 0;
					boyfriend.curCamOffsetY = 0;
					dad.canDance = false;
					boyfriend.canDance = false;
					dad.canSing = false;
					boyfriend.canSing = false;
					dad.playAnim('talk', true);
					boyfriend.playAnim('talk', true);
				case 528:
					dad.canDance = true;
					boyfriend.canDance = true;
					dad.canSing = true;
					boyfriend.canSing = true;
				case 912:
					dad.canDance = false;
					dad.canSing = false;
					dad.playAnim('holyshit', true);
			}
		}

		if (SONG.song.toLowerCase() == 'sunshine')
		{
			if (curStep == 64)
				tailscircle = 'hovering';
			if (curStep == 128 || curStep == 319 || curStep == 866)
				tailscircle = 'circling';
			if (curStep == 256 || curStep == 575) // this is to return tails to it's original positions (me very smart B))
			{
				FlxTween.tween(dad, {x: -150, y: 100}, 0.2, {
					onComplete: function(twn:FlxTween)
					{
						dad.setPosition(-150, 100);
						tailscircle = 'hovering';
						floaty = 41.82;
					}
				});
			}
			if (curStep == 588) // kill me 588
			{
				popup = false;
				boyfriend.alpha = 0;
				bgspec.visible = false;
				kadeEngineWatermark.visible = false;
				healthBarBG.visible = false;
				healthBar.visible = false;
				iconP1.visible = false;
				iconP2.visible = false;
				scoreTxt.visible = false;

				swapDad('doll-alt', -150, 100, false);

				dadStrums.forEach(function(spr:FlxSprite)
				{
					spr.alpha = 0;
				});
				playerStrums.forEach(function(spr:FlxSprite)
				{
					spr.alpha = 0;
				});

			}
			if (curStep == 860) // kill me
			{
				popup = true;
				boyfriend.alpha = 1;
				//dad.alpha = 1;
				bgspec.visible = true;
				kadeEngineWatermark.visible = true;
				healthBarBG.visible = true;
				healthBar.visible = true;
				iconP1.visible = true;
				iconP2.visible = true;
				scoreTxt.visible = true;
				swapDad('doll', -150, 100, false);
				ezTrail = new FlxTrail(dad, null, 2, 5, 0.3, 0.04);
				FlxTween.tween(dad, {x: -150, y: 100}, 0.2, {
					onComplete: function(twn:FlxTween)
					{
						tailscircle = '';
						dad.setPosition(-150, 100);
					}
				});
				dadStrums.forEach(function(spr:FlxSprite)
				{
					spr.alpha = 1;
				});
				playerStrums.forEach(function(spr:FlxSprite)
				{
					spr.alpha = 1;
				});
			}
			if (curStep == 1120)
			{
				FlxTween.tween(dad, {x: -150, y: 100}, 0.2, {
					onComplete: function(twn:FlxTween)
					{
						dad.setPosition(-150, 100);
						tailscircle = '';
						remove(ezTrail);
					}
				});
			}
		}

		if (Math.abs(FlxG.sound.music.time - (Conductor.songPosition - Conductor.offset)) > 20 || (SONG.needsVoices && Math.abs(vocals.time - (Conductor.songPosition - Conductor.offset)) > 20))		
		{
			resyncVocals();
		}

		if (dad.curCharacter == 'spooky' && curStep % 4 == 2)
		{
			// dad.dance();
		}

		if (danceOverride && !boyfriend.animation.curAnim.name.startsWith("sing") && boyfriend.canDance) {
			if (curStep % danceBeatSnap == 0) {

				boyfriend.dance();

				if (darkLevels.contains(curStage) && SONG.song.toLowerCase() != "polygonized")
				{
					boyfriend.color = nightColor;
				}
				else if(sunsetLevels.contains(curStage))
				{
					boyfriend.color = sunsetColor;
				}
				else
				{
					boyfriend.color = FlxColor.WHITE;
				}
			}
		}
		
		if (dadDanceOverride && (dad.animation.finished || (dad.animation.curAnim.name.startsWith('dance') || dad.animation.curAnim.name == 'idle'))) {
			if (dad.holdTimer <= 0 && curStep % dadDanceSnap == 0)
				dad.dance(idleAlt);
			if (dadmirror.holdTimer <= 0 && curStep % dadDanceSnap == 0)
				dadmirror.dance(idleAlt);
		}

		#if desktop
		DiscordClient.changePresence(SONG.song,
			"Acc: "
			+ truncateFloat(accuracy, 2)
			+ "% | Score: "
			+ songScore
			+ " | Misses: "
			+ misses, iconRPC, true,
			FlxG.sound.music.length
			- Conductor.songPosition);
		#end
	}

	var lightningStrikeBeat:Int = 0;
	var lightningOffset:Int = 8;

	var cool:Int = 0;

	var viggy:FlxSprite;

	var triggeredStupidDumbassPooperShitterInTheToiletAnus:Bool = false;

	override function beatHit()
	{
		super.beatHit();

		if(curBeat % 4 == 0)
		{
			if(SONG.notes[Math.floor(curStep / 16)] != null && SONG.notes[Math.floor(curStep / 16)].altAnim)
			{
				if(SONG.song.toLowerCase() == 'jeez' || SONG.song.toLowerCase() == 'unhinged')
				{
					idleAlt = true;
					if (SONG.song.toLowerCase() == 'unhinged')
						dad.POOP = true;
				}
			}
			else
			{
				if(SONG.song.toLowerCase() == 'jeez' || SONG.song.toLowerCase() == 'unhinged')
				{
					idleAlt = false;
					if (SONG.song.toLowerCase() == 'unhinged')
						dad.POOP = false;
				}
			}
		}

		if(SONG.song.toLowerCase() == 'ready-loud')
		{
			switch(curBeat)
			{
				case 58 | 120 | 155 | 227 | 256:
					boyfriend.canDance = false;
					boyfriend.canSing = false;
					flumpteez.visible = false;
					flumpteezTwo.visible = true;
					boyfriend.playAnim('scream', true);
				case 60 | 124 | 156 | 228 | 260:
					boyfriend.canDance = true;
					boyfriend.canSing = true;
					flumpteez.visible = true;
					flumpteezTwo.visible = false;
			}
		}

		if(curBeat % 2 == 0 && flumpteez != null)
		{
			flumpteez.animation.play('idle', true);
		}

		if(curBeat % 2 == 0 && SONG.song.toLowerCase() == 'apprentice')
		{
			if(pissStainDad.animation.getByName('idle') != null && pissStainDad != null)
			{
				pissStainDad.animation.play('idle', true);
			}
			if(pissStainChildren.animation.getByName('idle') != null && pissStainChildren != null)
			{
				pissStainChildren.animation.play('idle', true);
			}
		}

		if(curBeat == 392 && SONG.song.toLowerCase() == 'cell')
		{
			swapDad('cell-mad', dad.x, dad.y, true, FlxColor.RED);
			remove(pisswad);
			add(pisswad);
			iconP2.changeIcon(dad.iconName);
			viggy.visible = true;
		}

		if((curBeat) >= 8 && !triggeredStupidDumbassPooperShitterInTheToiletAnus)
		{
			trace('junkin and funkin and pooping and sloopin');
			FlxTween.tween(creddy, {x: creddy.width * -1}, 0.5, {ease: FlxEase.backIn});
			triggeredStupidDumbassPooperShitterInTheToiletAnus = true;
		}

		if(SONG.song.toLowerCase() == 'apprentice')
		{
			switch(curBeat)
			{
				case 168:
					var zoop = [boyfriend.x, boyfriend.y];
					pissStainDad.animation.remove('idle');
					pissStainDad.loadGraphic(Paths.image('apprentice/daverson'));
					pissStainDad.scale.set(1, 1);
					pissStainDad.y -= 75;
					pissStainDad.x -= 75;
					pissStainDad.updateHitbox();
					pissStainDad.antialiasing = false;
					zooBah = true;
					pissStainChildren.visible = false;
					for(i in pissyGroup.members)
					{
						i.visible = true;
						i.scale.set(1, 1);
						FlxTween.tween(i, {"scale.x": 0.5, "scale.y": 0.5}, FlxG.random.float(0.2, 0.7), {ease: FlxEase.quadOut});
					}
					pissStainSky.visible = false;
					pissStainClouds.visible = false;
					pissStainWater.visible = false;
					pissStainGrass.visible = false;
					pissStainProps.visible = false;
					curbg.visible = true;
					swapDad('3d-tristan');
					iconP2.changeIcon(dad.iconName);
					remove(boyfriend);
					boyfriend = new Boyfriend(zoop[0], zoop[1], '3d-bf');
					add(boyfriend);


					removeStatics();

					generateStaticArrows(0, false, false, false);
					generateStaticArrows(1, false, false, false);


				case 364:
					zooBah = false;
					var zoop = [boyfriend.x, boyfriend.y];
					pissStainDad.frames = Paths.getSparrowAtlas('apprentice/davec');
					pissStainDad.animation.addByPrefix('idle', 'idle', 24, false);
					pissStainDad.animation.play('idle', true);
					pissStainDad.scale.set(0.75, 0.75);
					pissStainDad.updateHitbox();
					pissStainDad.y += 75;
					pissStainDad.x += 75;
					pissStainDad.antialiasing = true;
					pissStainChildren.visible = true;
					for(i in pissyGroup.members)
					{
						i.visible = false;
					}
					pissStainSky.visible = true;
					pissStainClouds.visible = true;
					pissStainWater.visible = true;
					pissStainGrass.visible = true;
					pissStainProps.visible = true;
					curbg.visible = false;
					swapDad('da-apprentice');
					iconP2.changeIcon(dad.iconName);
					remove(boyfriend);
					boyfriend = new Boyfriend(zoop[0], zoop[1], 'bf');
					add(boyfriend);

					removeStatics();

					generateStaticArrows(0, false, false);
					generateStaticArrows(1, false, false);

			}
		}

		if(SONG.song.toLowerCase() == 'the-big-dingle')
		{
			switch(curBeat)
			{
				case 32 | 96:
					camBeatSnap = 1;
					camZoomIntensity = 1.25;
				case 64 | 128:
					camBeatSnap = 4;
					camZoomIntensity = 1;
			}
		}

		if(curBeat % camBeatSnap == 0)
		{
			if(timeTxtTween != null) 
			{
				timeTxtTween.cancel();
			}

			timeTxt.scale.x = 1.1;
			timeTxt.scale.y = 1.1;
			timeTxtTween = FlxTween.tween(timeTxt.scale, {x: 1, y: 1}, 0.2, {
				onComplete: function(twn:FlxTween) {
					timeTxtTween = null;
				}
			});
		}

		if (!UsingNewCam)
		{
			if (generatedMusic && PlayState.SONG.notes[Std.int(curStep / 16)] != null)
			{
				if (curBeat % 4 == 0)
				{
					// trace(PlayState.SONG.notes[Std.int(curStep / 16)].mustHitSection);
				}

				if (!PlayState.SONG.notes[Std.int(curStep / 16)].mustHitSection)
				{
					focusOnDadGlobal = true;
					if(camMoveAllowed)
						ZoomCam(true);
				}

				if (PlayState.SONG.notes[Std.int(curStep / 16)].mustHitSection)
				{
					focusOnDadGlobal = false;
					if(camMoveAllowed)
						ZoomCam(false);
				}
			}
		}
		if(curBeat % danceBeatSnap == 0 && daveFuckingDies != null)
		{
			daveFuckingDies.dance();
		}
		if (generatedMusic)
		{
			notes.sort(FlxSort.byY, FlxSort.DESCENDING);
		}

		if (SONG.notes[Math.floor(curStep / 16)] != null)
		{
			if (tailscircle == 'circling' && SONG.song.toLowerCase() == 'sunshine')
				remove(ezTrail);

			if (SONG.notes[Math.floor(curStep / 16)].changeBPM)
			{
				Conductor.changeBPM(SONG.notes[Math.floor(curStep / 16)].bpm);
				FlxG.log.add('CHANGED BPM!');
			}
			// else
			// Conductor.changeBPM(SONG.bpm);
		}
		/*
		if (dad.curCharacter == 'bandu')  {
			krunkity = dadmirror.animation.finished && dad.animation.finished;
		}*/
		if (!dadDanceOverride && (dad.curCharacter == 'bandu' || dad.curCharacter == 'bandu-sad')) {
			if (dad.holdTimer <= 0 && curBeat % dadDanceSnap == 0)
				!wtfThing ? dad.dance(dad.POOP) : dad.playAnim('idle-alt', true); // i hate everything
			if (dadmirror.holdTimer <= 0 && curBeat % dadDanceSnap == 0)
				!wtfThing ? dadmirror.dance(dad.POOP) : dadmirror.playAnim('idle-alt', true); // sutpid
		}
		else if (!dadDanceOverride && (dad.animation.finished || (dad.curCharacter == 'garrett-animal' && dad.animation.curAnim.name.startsWith('dance'))))
		{
			switch (SONG.song.toLowerCase())
			{
				case 'recovered-project':
					if (dad.holdTimer <= 0 && curBeat % dadDanceSnap == 0) {
						dad.dance(idleAlt);
						helloIAmNotMarcellosIAmMrBambiGiveMeYourFOOOOOOODDDDdddddd.forEach(function(spr:FlxSprite){
							spr.visible = false;
						});
					}
				case 'ferocious':
					if (dad.curCharacter == 'garrett-animal') {
						if (dad.holdTimer <= 0)
							dad.dance(idleAlt);
					}
					else {
						if (dad.holdTimer <= 0 && curBeat % dadDanceSnap == 0)
							dad.dance(idleAlt);
						if (dadmirror.holdTimer <= 0 && curBeat % dadDanceSnap == 0)
							dadmirror.dance(idleAlt);
					}
					
				case 'tutorial':
					dad.dance(idleAlt);
					dadmirror.dance(idleAlt);
				case 'disruption' | 'minus-disruption' | 'enchanted':
					if (curBeat % gfSpeed == 0 && dad.holdTimer <= 0) {
						dad.dance(idleAlt);
						dadmirror.dance(idleAlt);
					}
				case 'applecore':
					if (dad.holdTimer <= 0 && curBeat % dadDanceSnap == 0)
						!wtfThing ? dad.dance(dad.POOP) : dad.playAnim('idle-alt', true); // i hate everything
					if (dadmirror.holdTimer <= 0 && curBeat % dadDanceSnap == 0)
						!wtfThing ? dadmirror.dance(dad.POOP) : dadmirror.playAnim('idle-alt', true); // sutpid
				default:
					if (dad.holdTimer <= 0 && curBeat % dadDanceSnap == 0)
						dad.dance(idleAlt);
					if (dadmirror.holdTimer <= 0 && curBeat % dadDanceSnap == 0)
						dadmirror.dance(idleAlt);
			}
		}
		if(badai != null)
		{
			if ((badai.animation.finished || badai.animation.curAnim.name == 'idle') && badai.holdTimer <= 0 && curBeat % dadDanceSnap == 0)
				badai.dance();
		}
		if (swagger != null) {
			if (swagger.holdTimer <= 0 && curBeat % 1 == 0 && swagger.animation.finished)
				swagger.dance();
		}
		if (littleIdiot != null) {
			if (littleIdiot.animation.finished && littleIdiot.holdTimer <= 0 && curBeat % dadDanceSnap == 0) littleIdiot.dance();
		}
		if(dadTwo != null)
		{
			if ((dadTwo.animation.finished || dadTwo.animation.curAnim.name == 'idle') && dadTwo.holdTimer <= 0 && curBeat % dadDanceSnap == 0)
				dadTwo.dance();
		}

		if (FlxG.camera.zoom < (1.35 * camZoomIntensity) && curBeat % camBeatSnap == 0 && camZooming)
		{
			FlxG.camera.zoom += (0.015 * camZoomIntensity);
			camHUD.zoom += (0.03 * camZoomIntensity);
		}

		switch (curSong.toLowerCase())
		{
			case 'awesome':
				switch(curBeat)
				{
					case 72 | 216 | 528 | 592:
						swapDad('wtf-lmao');
					case 136 | 280 | 432 | 632:
						swapDad('dave-wheels');
					case 304 | 494:
						swapDad('bormp');
					case 496 | 560:
						swapDad('cock-cream');
				}
			case 'jeez':
				switch(curBeat)
				{
					case 268:
						for(strum in dadStrums)
							{
								var fuckingBitch = new FlxSprite(strum.x, strum.y);
								fuckingBitch.loadGraphicFromSprite(strum);

								var pissyX:Int = FlxG.random.int(-10, 50);
								var pissyY:Int = FlxG.random.int(-250, -70);

								fuckingBitch.velocity.set(pissyX, pissyY);
								fuckingBitch.acceleration.y = FlxG.random.int(300, 350);

								fuckingBitch.setGraphicSize(Std.int(fuckingBitch.width * 0.7));

								fuckingBitch.cameras = [camHUD];
								add(fuckingBitch);

								strum.destroy();
							}
						/*remove(dadStrums);
						dadStrums = new FlxTypedGroup<Strum>();
						dadStrums.cameras = [camHUD];
						add(dadStrums);*/
						dadStrums.clear();
						var splodey:FlxSprite = new FlxSprite(dad.x, dad.y);
						splodey.frames = Paths.getSparrowAtlas('jeez/gary_splode');
						splodey.animation.addByPrefix('idle', 'SPLODE', 24, false);
						add(splodey);
						splodey.animation.play('idle', true);
						splodey.animation.finishCallback = function(dick:String){splodey.destroy();};
						FlxG.sound.play(Paths.sound('bomb'), 0.8);
						dad.visible = false;
					case 272:
						swapDad('jeff', 100, 100, true);
						iconP2.changeIcon('jeff');
						dadChar = 'jeff';
						generateStaticArrows(0, true);
						for(note in notes.members)
						{
							note.make2d();
						}
						for(note in unspawnNotes)
						{
							note.make2d();
						}
				}
			case 'speed':
			{
				switch(curBeat)
				{
					case 192 | 240:
						thunderBlack.alpha = 1;
					case 193:
						swapDad('bormp', 100, 100, false);
					case 200:
						iconP2.changeIcon(dad.iconName);
						FlxTween.tween(thunderBlack, {alpha: 0}, 1);
					case 244:
						swapDad('dave-wheels', 100, 100, false);
					case 256:
						iconP2.changeIcon(dad.iconName);
						thunderBlack.alpha = 0;
				}
			}
			case 'too-shiny':
				switch(curBeat) {
					case 12:
						bruhhh.color = FlxColor.BLUE;
						FlxTween.tween(littleGuy, {"scale.x": 0.4, "scale.y": 0.4, x: littleGuy.x - 184 / 0.85}, (Conductor.crochet * 0.001) * 4, {ease: FlxEase.quadIn});
					case 16:
						bruhhh.color = FlxColor.WHITE;
						littleGuy.visible = false;
						FlxG.camera.flash(FlxColor.WHITE, 1, null, true);
						dad.visible = true;
				}
			case 'algebra':
				switch(curBeat)
				{
					case 160:
						swagSpeed = baseSwagSpeed - 0.5;
						//GARRETT TURN 1!!
						if (SaveFileState.saveFile.data.elfMode)
							swapDad('elf');
						else
							swapDad('garrett');
						algebraStander('og-dave', daveStand, 250, 100);
						daveJunk.visible = true;
						iconP2.changeIcon(dad.iconName);
					case 352: // 
						//HAPPY DAVE TURN 2!!
						swapDad('og-dave');
						daveJunk.visible = false;
						garrettJunk.visible = true;
						swagSpeed = baseSwagSpeed - 0.3;
						for(member in standersGroup.members)
						{
							member.destroy();
						}
						algebraStander('garrett', garrettStand, 500, 225);
						iconP2.changeIcon(dad.iconName);
					case 432:
						//GARRETT TURN 2
						swapDad('garrett');
						davePiss.visible = true;
						garrettJunk.visible = false;
						for(member in standersGroup.members)
						{
							member.destroy();
						}
						algebraStander('og-dave-angey', daveStand, 250, 100);
						iconP2.changeIcon(dad.iconName);
					case 440:
						//ANGEY DAVE TURN 1!!
						swapDad('og-dave-angey');
						davePiss.visible = false;
						garrettJunk.visible = true;
						for(member in standersGroup.members)
						{
							member.destroy();
						}
						algebraStander('garrett', garrettStand, 500, 225, true);
						iconP2.changeIcon(dad.iconName);
					case 512:
						//HALL MONITOR TURN
						//UNCOMMENT THIS WHEN HALL MONITOR SPRITES ARE DONE AND IN
						swapDad('hall-monitor');
						davePiss.visible = true;
						diamondJunk.visible = true;
						swagSpeed = (baseSwagSpeed * 0.5) + 0.4;
						for(member in standersGroup.members)
						{
							member.destroy();
						}
						algebraStander('garrett', garrettStand, 500, 225, true);
						algebraStander('og-dave-angey', daveStand, 250, 100);
						iconP2.changeIcon(dad.iconName);
					case 836:
						//DIAMOND MAN TURN
						swapDad('diamond-man');
						monitorJunk.visible = true;
						diamondJunk.visible = false;
						swagSpeed = baseSwagSpeed;
						for(member in standersGroup.members)
						{
							member.destroy();
						}
						algebraStander('garrett', garrettStand, 500, 225, true);
						//UNCOMMENT THIS WHEN HALL MONITOR SPRITES ARE DONE AND IN
						algebraStander('hall-monitor', hallMonitorStand, 0, 100);
						algebraStander('og-dave-angey', daveStand, 250, 100);
						iconP2.changeIcon(dad.iconName);
					case 1136:
						//PLAYROBOT TURN
						swapDad('playrobot');
						swagSpeed = 1.6;
						iconP2.changeIcon(dad.iconName);
					case 1292:
						FlxTween.tween(davePiss, {x: davePiss.x - 250}, 0.5, {ease:FlxEase.quadOut});
						davePiss.animation.play('d');
					case 1296:
						//SCARY PLAYROBOT TURN
						swapDad('playrobot-crazy');
						swagSpeed = baseSwagSpeed;
						iconP2.changeIcon(dad.iconName);
					case 1436:
						//ANGEY DAVE TURN 2!!
						swapDad('og-dave-angey');
						robotJunk.visible = true;
						davePiss.visible = false;
						for(member in standersGroup.members)
						{
							member.destroy();
						}
						algebraStander('playrobot-scary', playRobotStand, 750, 100, false, true);
						algebraStander('garrett', garrettStand, 500, 225, true);
						algebraStander('hall-monitor', hallMonitorStand, 0, 100);
						iconP2.changeIcon(dad.iconName);
					case 1564:
						swagSpeed = baseSwagSpeed + 0.9;
					
				}
			case 'gift-card':
				switch (curBeat) {
					case 221:
						swag.visible = false;
						var z = [boyfriend.x, boyfriend.y];
						var t = [gf.x, gf.y];
						remove(boyfriend);
						boyfriend = new Boyfriend(z[0], z[1], 'bf-pixel-white');
						add(boyfriend);
		
						remove(gf);
						gf = new Character(t[0] + 50, t[1] + 150, 'gf-pixel-white');
						add(gf);
						swapDad('chipper', 200, 650);
						iconP2.changeIcon(dad.iconName);	
						iconP1.changeIcon(boyfriend.iconName);	
					case 320:
						swag.visible = true;
						var z = [boyfriend.x, boyfriend.y];
						var t = [gf.x, gf.y];
						remove(boyfriend);
						boyfriend = new Boyfriend(z[0], z[1], 'bf');
						add(boyfriend);

						remove(gf);
						gf = new Character(t[0] - 50, t[1] - 150, 'gf-only');
						add(gf);
						swapDad('bandu-card', -50, 200);
						dad.x += 150;
						dad.y -= 55;
						iconP2.changeIcon(dad.iconName);
						iconP1.changeIcon(boyfriend.iconName);	
				}			
			case 'sugar-rush':
				switch(curBeat)
				{
					case 172:
						FlxTween.tween(thunderBlack, {alpha: 0.35}, Conductor.stepCrochet / 500);
					case 204:
						FlxTween.tween(thunderBlack, {alpha: 0}, Conductor.stepCrochet / 500);
				}
			case 'thunderstorm':
				switch(curBeat)
				{
					case 272 | 304:
						FlxTween.tween(thunderBlack, {alpha: 0.35}, Conductor.stepCrochet / 500);
					case 300 | 332:
						FlxTween.tween(thunderBlack, {alpha: 0}, Conductor.stepCrochet / 500);
				}
			case 'collision':
				if (curBeat == 76) dad.playAnim('idle-alt', true);
			case 'applecore':
				switch(curBeat) {
					case 192:
						wtfThing = true;
						what.forEach(function(spr:FlxSprite){
							spr.frames = Paths.getSparrowAtlas('applecore/minion');

							var dicknose:Array<String> = ['poip', 'cartwheel', 'god i love trampolining'];
							var deezy:String = dicknose[FlxG.random.int(0, 2)];
							spr.animation.addByPrefix(deezy, deezy, 24, true);
							spr.animation.play(deezy);
						});
						creditsWatermark.text = 'Screw you!';
						kadeEngineWatermark.y -= 20;
						camHUD.flash(FlxColor.WHITE, 1);
						
						iconRPC = 'icon_the_two_dunkers';
						iconP2.changeIcon('junkers');
						dad.playAnim('NOOMYPHONES', true);
						dadmirror.playAnim('NOOMYPHONES', true);
						dad.POOP = true; // WORK WORK WOKR< WOKRMKIEPATNOLIKSEHGO:"IKSJRHDLG"H
						dadmirror.POOP = true; // :))))))))))
						poopStrums.visible = true; // ??????
						new FlxTimer().start(3.5, function(deez:FlxTimer){
							swagThings.forEach(function(spr:FlxSprite){
								FlxTween.tween(spr, {y: spr.y + 1010}, 1.2, {ease: FlxEase.circOut, startDelay: 0.5 + (0.2 * spr.ID)});
							});	
							poopStrums.forEach(function(spr:Strum){
								FlxTween.tween(spr, {alpha: 1}, 1, {ease: FlxEase.circOut, startDelay: 0.5 + (0.2 * spr.ID)});
							});
							FlxTween.tween(swagger, {y: swagger.y + 1000}, 1.05, {ease:FlxEase.cubeInOut});
						});
						unswagBG.active = unswagBG.visible = true;
						curbg =  unswagBG;
						swagBG.visible = swagBG.active = false;
					case 496:
						defaultCamZoom = 0.375;
						unfairPart = true;
						viggy.visible = true;
						gfSpeed = 1;
						playerStrums.forEach(function(spr:Strum){
							spr.scale.set(0.7, 0.7);
						});
						what.forEach(function(spr:FlxSprite){
							spr.alpha = 0;
						});
						gfSpeed = 1;
						wtfThing = false;
						var dumbStupid = new FlxSprite().loadGraphic(Paths.image('applecore/yeah'));
						dumbStupid.scrollFactor.set();
						dumbStupid.screenCenter();
						littleIdiot.alpha = 0;
						littleIdiot.visible = true;
						add(dumbStupid);
						dumbStupid.cameras = [camHUD];
						dumbStupid.color = FlxColor.BLACK;
						creditsWatermark.text = "Ghost tapping is forced off! Screw you!";
						health = 2;
						theFunne = false;
						poopStrums.visible = false;
						FlxTween.tween(dumbStupid, {alpha: 1}, 0.2, {onComplete: function(twn:FlxTween){
							scaryBG.active = true;
							curbg = scaryBG;
							unswagBG.visible = unswagBG.active = false;
							FlxTween.tween(dumbStupid, {alpha: 0}, 1.2, {onComplete: function(twn:FlxTween){
								trace('hi'); // i actually forgot what i was going to put here
								//silly silly grantare
							}});
						}});
					case 200:
						vocals.volume = 1;
					case 519:
						FlxTween.tween(littleIdiot, {alpha: 1}, 1.4, {ease: FlxEase.circOut});
					case 527:
						FlxTween.tween(littleIdiot, {"scale.x": littleIdiot.scale.x + 2.1, "scale.y": littleIdiot.scale.y + 2.1}, 1.35, {ease: FlxEase.cubeInOut, onComplete: function(twn:FlxTween){
							iconP2.changeIcon(littleIdiot.iconName);
							orbit = false;
							dad.visible = dadmirror.visible = swagger.visible = false;
							var derez = new FlxSprite(dad.getMidpoint().x, dad.getMidpoint().y).loadGraphic(Paths.image('applecore/monkey_guy'));
							derez.scale.set(0.8, 0.8);
							derez.updateHitbox();
							derez.setPosition(derez.x - derez.width / 2, derez.y - derez.height / 2);
							derez.antialiasing = false;
							add(derez);
							var deez = new FlxSprite(swagger.getMidpoint().x, swagger.getMidpoint().y).loadGraphic(Paths.image('applecore/monkey_person'));
							deez.setPosition(deez.x - deez.width / 2, deez.y - deez.height / 2);
							deez.antialiasing = false;
							add(deez);
							var swagsnd = new FlxSound().loadEmbedded(Paths.sound('suck'));
							swagsnd.play(true);
							var whatthejunk = new FlxSound().loadEmbedded(Paths.sound('suckEnd'));
							littleIdiot.playAnim('inhale');
							littleIdiot.animation.finishCallback = function(d:String) {
								swagsnd.stop();
								whatthejunk.play(true);
								littleIdiot.animation.finishCallback = null;
							};
							new FlxTimer().start(0.2, function(tmr:FlxTimer){
								FlxTween.tween(deez, {"scale.x": 0.1, "scale.y": 0.1, x: littleIdiot.getMidpoint().x - deez.width / 2, y: littleIdiot.getMidpoint().y - deez.width / 2 - 400}, 0.65, {ease: FlxEase.quadIn});
								FlxTween.angle(deez, 0, 360, 0.65, {ease: FlxEase.quadIn, onComplete: function(twn:FlxTween) deez.kill()});

								FlxTween.tween(derez, {"scale.x": 0.1, "scale.y": 0.1, x: littleIdiot.getMidpoint().x - derez.width / 2 - 100, y: littleIdiot.getMidpoint().y - derez.width / 2 - 500}, 0.65, {ease: FlxEase.quadIn});
								FlxTween.angle(derez, 0, 360, 0.65, {ease: FlxEase.quadIn, onComplete: function(twn:FlxTween) derez.kill()});

								new FlxTimer().start(1, function(tmr:FlxTimer){ poipInMahPahntsIsGud = true; iconRPC = 'icon_unfair_junker';});
							});
						}});
				}
			case 'recovered-project':
				switch (curBeat) {
					case 256:
						swapDad('RECOVERED_PROJECT_2');
						iconP2.changeIcon(dad.iconName);
						sonicAllAmericanHotdogCombo = true;
					case 480:
						thunderBlack.alpha = 1;
						swapDad("RECOVERED_PROJECT_3");
						sonicAllAmericanHotdogCombo = false;
					case 484:
						FlxTween.tween(thunderBlack, {alpha: 0}, 1);
						iconP2.changeIcon(dad.iconName);
				}
			case 'wireframe':
				FlxG.camera.shake(0.005, Conductor.crochet / 1000);
				switch(curBeat)
				{
					case 254:
						badai.visible = true;
						new FlxTimer().start((Conductor.crochet / 1000) * 0.5, function(tmr:FlxTimer){
							FlxTween.tween(badai, {x: -300, y: 100}, (Conductor.crochet / 1000) * 1.5, {ease: FlxEase.cubeIn});
						});
						//FlxTween.tween(dad, {x: 1500, y: 1500}, Conductor.crochet / 1000, {ease: FlxEase.cubeIn});
					case 256:
						creditsWatermark.text = 'Screw you!';
						kadeEngineWatermark.y -= 20;
						dad.visible = false;
						var baldiBasic:FlxSprite = new FlxSprite(dad.x, dad.y);
						baldiBasic.frames = daveFuckingDies.frames;
						baldiBasic.animation.addByPrefix('HI', 'IDLE', 24, false);
						baldiBasic.animation.play("HI");
						baldiBasic.x = dad.getMidpoint().x - baldiBasic.width / 2;
						baldiBasic.y = dad.getMidpoint().y - baldiBasic.height / 2;
						add(baldiBasic);
						FlxTween.tween(baldiBasic, {x: baldiBasic.x + 100, y: baldiBasic.y + 500}, 0.15, {ease:FlxEase.cubeOut, onComplete: function(twn:FlxTween){
							baldiBasic.kill();
							remove(baldiBasic);
							baldiBasic.destroy();
						}});
						//this transition was lazy and dumb lets do it better
						FlxG.camera.flash(FlxColor.WHITE, 1);/*
						remove(dad);
						//badai time
						dad = new Character(-300, 100, 'badai', false);
						add(dad);
						iconP2.animation.play('badai', true);
						daveFuckingDies.visible = true;*/
						camMoveAllowed = false;
						badaiTime = true;
						//boyfriend.canDance = false;
						//boyfriend.playAnim('turn', true);
						new FlxTimer().start(1, function(tmr:FlxTimer)
						{
							camMoveAllowed = true;
							var position = boyfriend.getPosition();
							var width = boyfriend.width;
							/*
							remove(boyfriend);
							boyfriend = new Boyfriend(position.x, position.y, 'tunnel-bf-flipped');
							add(boyfriend);
							*/
							//boyfriendOldIcon = 'bf-old-flipped';
							//iconP1.animation.play('tunnel-bf-flipped');
							iconP2.changeIcon(badai.iconName);
							iconRPC = 'icon_badai';
							daveFuckingDies.visible = true;
							FlxTween.tween(daveFuckingDies, {y: -300}, 2.5, {ease: FlxEase.cubeInOut});
							new FlxTimer().start(2.5, function(tmr:FlxTimer)
							{
								daveFuckingDies.inCutscene = false;
							});
						});
				}
			case 'minus-wireframe':
				FlxG.camera.shake(0.005, Conductor.crochet / 1000);
				switch(curBeat)
				{
					case 254:
						FlxTween.tween(badai, {alpha: 1}, (Conductor.crochet / 1000) * 2);
					case 256:
						creditsWatermark.text = 'Screw you!';
						kadeEngineWatermark.y -= 20;
						dad.canDance = false;
						dad.playAnim('splode', true);
						dad.animation.finishCallback = function theDeezers(sucky:String) 
						{
							dad.visible = false;
							dad.animation.finishCallback = null;
						}
						FlxG.camera.flash(FlxColor.WHITE, 0.5);
						camMoveAllowed = false;
						badaiTime = true;
						new FlxTimer().start(1, function(tmr:FlxTimer)
						{
							camMoveAllowed = true;
							iconP2.changeIcon(badai.iconName);
							iconRPC = 'icon_badai';
							doMinusJunket();
						});
				}
			case 'the-big-dingle':
				if (curBeat == 148) {
					talk.visible = true;
					talk.animation.play('idle');
				}
				if (curBeat == 280) {
					remove(dad);
					add(dad);
					iconP2.changeIcon('dingle-donk-duo');
					iconRPC = badai.iconRPC;
					FlxG.camera.flash(FlxColor.WHITE, 1, null, true);
					badai.visible = true;
					boyfriend.x += 655;
					dingleBGs[1].visible = bops.visible = true;
					dingleBGs[0].visible = false;
					badaiTime = true;
				}

				if (curBeat % 2 == 0)
					bops.animation.play('bop', true);
			case 'resumed':
				switch (curBeat) {
					case 422:
						dad.canDance = false;
						dad.playAnim('look');
					case 424:
						dad.playAnim('talk');
					case 452:
						camMoveAllowed = false;
						camFollow.set(boyfriend.getGraphicMidpoint().x, boyfriend.getGraphicMidpoint().y);
						gfSpeed = 1;
						badaiTime = true;
						badai.visible = true;
						dadDanceSnap = 4;
						iconP2.changeIcon(badai.iconName);
						iconRPC = badai.iconRPC;
						FlxTween.tween(dad, {x: -950}, 1, {ease: FlxEase.quadInOut});
						FlxTween.tween(badai, {y: badai.y + 850}, 1.1, {ease: FlxEase.cubeInOut});
					case 455:
						camMoveAllowed = true;
					case 776:
						badai.canDance = false;
						badai.playAnim('look');
					case 778:
						badai.playAnim('talk');
				}
			case 'ferocious':
				switch(curBeat) {
					case 2192:
						imDoneWithThisCrap.frames = Paths.getSparrowAtlas('funnyAnimal/zunkity');
						imDoneWithThisCrap.animation.addByPrefix('idle', 'FAKE LOADING SCREEN', 0, false);
						imDoneWithThisCrap.animation.play('idle');
					case 2224 | 2264 | 2316 | 2332 | 2360 | 2423 | 2488 | 2552 | 2616 | 2683 | 2748:
						imDoneWithThisCrap.animation.curAnim.curFrame++;
					case 1180:
						theDickPenis = true;
						defaultCamZoom = 0.85;
						funnyPart = false;
						switchScene('hall');
						swapDad('wizard', running.getMidpoint().x, running.getMidpoint().y);
						iconP2.changeIcon(dad.iconName);
						remove(boyfriend);
						boyfriend.destroy();
						boyfriend = new Boyfriend(0, 0, '3d-bf');
						add(boyfriend);
						boyfriend.setPosition(running.getMidpoint().x + 150, running.getMidpoint().y + 100);
						dad.y -= dad.height  / 2;
						dad.x -= dad.width * 0.65;
						removeStatics();
						generateStaticArrows(0, false, false, false);
						generateStaticArrows(1, false, false, false);
						notes.cameras = [camHUD];
						strumLineNotes.cameras = [camHUD];
						strumYOffset = 0;
						trace('help');
					case 802:
						trace('kickdeez');
						leggi.animation.play('kick', true);
						flingBfToOblivionAndBeyond();
					case 804:
						updatevels = false;
						trace('15 seconds of being in a jail cell');
						switchScene('jailCell');
						running.visible = leggi.visible = false;
						leggi.animation.play('idle');
					case 827:
						var swagPad = new FlxSprite().loadGraphic(Paths.image('funnyAnimal/futurePad'));
						swagPad.setGraphicSize(1280);
						var penis = [swagPad.scale.x, swagPad.scale.y];
						swagPad.screenCenter();
						swagPad.scale.set(0, 0);
						swagPad.antialiasing = false;
						add(swagPad);
						FlxTween.tween(swagPad, {"scale.x": penis[0], "scale.y": penis[1]}, Conductor.crochet / 1000, {onComplete: function(twn:FlxTween) {
							remove(swagPad);
							swagPad.destroy();
						}, onUpdate: function(twn:FlxTween) swagPad.screenCenter()});
					case 828:
						theDickPenis = false;
						switchScene("futurePad");
						removeStatics();
						generateStaticArrows(0, true, false, false);
						generateStaticArrows(1, true, false, false);
						strumYOffset = 0;
						notes.cameras = [camGame];
						strumLineNotes.cameras = [camGame];
					case 292:
						theDickPenis = true;
						swapDad('playtime-2', dad.x, dad.y, false);
						dad.playAnim('friend', true);
						dad.animation.finishCallback = function(deezNuts:String){DUMBASSPLAYTIMETWOPOINTOHISCLOSERTOBFSOTHECAMSHOULDNTMOVEASFARASITDOES = true; dad.animation.finishCallback = null;};
						iconP2.changeIcon(dad.iconName);
					case 540:
						theDickPenis = false;
						switchScene('chaseScene');
					case 1475:
						theDickPenis = false;
						removeStatics();
						generateStaticArrows(0, false, false, false);
						generateStaticArrows(1, false, false, false);
						strumYOffset = 0;
						var thisThing = new FlxSprite(-1280, -720);
						var tex = Paths.getSparrowAtlas('funnyAnimal/mrMusic');
						thisThing.frames = tex;
						thisThing.animation.addByPrefix('idle', 'YEA', 24, false);
						thisThing.animation.play('idle');
						thisThing.scale.set(3, 3);
						thisThing.updateHitbox();
						thisThing.y = (boyfriend.y + boyfriend.height) - thisThing.height + 275;
						add(thisThing);
						whatJunk = [boyfriend.x - thisThing.width, thisThing.y];
						FlxTween.tween(thisThing, {x: boyfriend.x - thisThing.width}, Conductor.crochet / 1000,  {onComplete: function(twn:FlxTween) {
							remove(thisThing);
							thisThing.destroy();
						}});
					case 1476:
						theDickPenis = false;
						swapDad('mr-music', whatJunk[0] + 450, whatJunk[1]);
						running.animation.play('idle', true, true);
						iconP2.changeIcon(dad.iconName);
						flipBF();
						whatAmIDoing = true;
					case 2759:
						theDickPenis = false;
						thunderBlack.alpha = 1;
						running.animation.play('idle', true, true);
					case 2760:
						theDickPenis = false;
						chasePart2 = true;
						badaiTime = true;
						badai.alpha = 1;
						dad.alpha = 0;
						
						imDoneWithThisCrap.alpha = 0;
						thunderBlack.alpha = 0;
						badai.y -= 285;
						badai.x -= badai.width * 1.25;
						boyfriend.x += 150;
						boyfriend.y = cheating5;
						leggi.x = boyfriend.x - 85;
						leggi.flipX = !leggi.flipX;
						leggi.visible = true;

						boyfriend.x += 245;
						leggi.x += 245;

						whatsTheBigIdea.setPosition(badai.x - 60, badai.y);
						whatsTheBigIdea.visible = true;
					case 1928:
						theDickPenis = false;
						//defaultCamZoom = 1.175;
						lookOverThere = true;
						running.animation.pause();
						FlxTween.tween(boyfriend, {x: boyfriend.x - 75}, 0.25);
						FlxTween.tween(dad, {x: dad.x - 1280}, 0.5, {onComplete: function(twn:FlxTween){
							swapDad('do-you-accept', boyfriend.x + 350, running.getMidpoint().y, false);
							dad.y = boyfriend.y + boyfriend.height - dad.height;
							iconP2.changeIcon(dad.iconName);
							iconP2.flipX = !iconP2.flipX;
						}});
					case 1941:
						theDickPenis = true;
						defaultCamZoom = 0.85;
						lookOverThere = false;
					case 2174:
						theDickPenis = true;
						imDoneWithThisCrap = new Character(dad.x, dad.y, 'do-you-accept');
						add(imDoneWithThisCrap);
						swapDad('garrett-piss', boyfriend.x - 1311, running.getMidpoint().y, false);
						flipBF();
						iconP2.changeIcon(dad.iconName);
						iconP2.flipX = !iconP2.flipX;
						dad.y = boyfriend.y + boyfriend.height - dad.height + 80;
						dad.alpha = 0;
						FlxTween.tween(dad, {alpha: 1}, 1);
					case 2178:
						whatsTheBigIdea = new FlxSprite(badai.x, badai.y);
						whatsTheBigIdea.frames = Paths.getSparrowAtlas('funnyAnimal/palooseCar');
						whatsTheBigIdea.animation.addByPrefix('idle', 'idle', 24, false);
						whatsTheBigIdea.animation.play('idle');
						whatsTheBigIdea.visible = false;
						add(whatsTheBigIdea);
						badai.x += 60;	
					case 2176:
						shakeCam = true;
					case 2184:
						shakeCam = false;
					case 2824:
						defaultCamZoom = 1.45;
					case 2856:
						defaultCamZoom = 0.85;
				}

				if (whatsTheBigIdea != null) {
					whatsTheBigIdea.animation.play('idle');
				}
			case 'jambino':
				switch (curBeat) {
					case 668:
						badaiTime = true;
						badai.scale.set(0, 0);
						badai.visible = true;
						FlxTween.tween(badai, {"scale.x": 1, "scale.y": 1}, 0.25, {ease:FlxEase.cubeIn});
						FlxTween.tween(dad, {x: dad.x - 145, y: dad.y - 200}, 1, {ease: FlxEase.quadOut});
					case 956:
						badaiTime = false;
						FlxTween.tween(badai, {x: badai.x - 350}, 0.75, {ease:FlxEase.quadOut});
						FlxTween.tween(dad, {x: dad.x + 145, y: dad.y + 200}, 1, {ease: FlxEase.quadOut});
				}
		}

		if (shakeCam)
		{
			gf.playAnim('scared', true);
		}

		//health icon bounce but epic
		if (curBeat % gfSpeed == 0) {
			curBeat % (gfSpeed * 2) == 0 ? {
				iconP1.scale.set(1.1, 0.8);
				iconP2.scale.set(1.1, 1.3);

				FlxTween.angle(iconP1, -15, 0, Conductor.crochet / 1300 * gfSpeed, {ease: FlxEase.quadOut});
				FlxTween.angle(iconP2, 15, 0, Conductor.crochet / 1300 * gfSpeed, {ease: FlxEase.quadOut});
			} : {
				iconP1.scale.set(1.1, 1.3);
				iconP2.scale.set(1.1, 0.8);

				FlxTween.angle(iconP2, -15, 0, Conductor.crochet / 1300 * gfSpeed, {ease: FlxEase.quadOut});
				FlxTween.angle(iconP1, 15, 0, Conductor.crochet / 1300 * gfSpeed, {ease: FlxEase.quadOut});
			}

			FlxTween.tween(iconP1, {'scale.x': 1, 'scale.y': 1}, Conductor.crochet / 1250 * gfSpeed, {ease: FlxEase.quadOut});
			FlxTween.tween(iconP2, {'scale.x': 1, 'scale.y': 1}, Conductor.crochet / 1250 * gfSpeed, {ease: FlxEase.quadOut});

			iconP1.updateHitbox();
			iconP2.updateHitbox();
		}

		if(curBeat % danceBeatSnap == 0)
		{
			if(iconP1.charPublic == 'bandu-origin')
			{
				iconP1.animation.play(iconP1.charPublic, true);
			}
			if(iconP2.charPublic == 'bandu-origin')
			{
				iconP2.animation.play(iconP2.charPublic, true);
			}
		}

		if (curBeat % gfSpeed == 0)
		{
			if (!shakeCam)
			{
				gf.dance();
			}
		}

		if (!boyfriend.animation.curAnim.name.startsWith("sing") && boyfriend.canDance && curBeat % danceBeatSnap == 0 && !danceOverride)
		{
			boyfriend.dance();
			if (darkLevels.contains(curStage) && SONG.song.toLowerCase() != "polygonized")
			{
				boyfriend.color = nightColor;
			}
			else if(sunsetLevels.contains(curStage))
			{
				boyfriend.color = sunsetColor;
			}
			else
			{
				boyfriend.color = FlxColor.WHITE;
			}
		}

		if (curBeat % 8 == 7 && SONG.song == 'Tutorial' && dad.curCharacter == 'gf') // fixed your stupid fucking code ninjamuffin this is literally the easiest shit to fix like come on seriously why are you so dumb
		{
			dad.playAnim('cheer', true);
			boyfriend.playAnim('hey', true);
		}
	}

	var whatsTheBigIdea:FlxSprite;

	var chasePart2 = false;

	var imDoneWithThisCrap:Character;

	var whatAmIDoing =  false;

	var fiftyThousandRobux:Bool = false;

	var lookOverThere = false;

	var palooseMyDeez:Bool = false;

	private function switchScene(scene:String):Void
	{
		switch (scene) {
			case 'hall': 
				futurePad.visible = false;
				if (futurePadOverlay != null) futurePadOverlay.visible = false;
				ihmp = krunkity = false;
				running.animation.play('idle', true, true);
				running.animation.pause();
				running.visible = true;
				camMoveAllowed = false;
				camFollow.set(running.getMidpoint().x, running.getMidpoint().y);
				FlxG.camera.snapToTarget();
				camMoveAllowed = true;
			case 'jailCell':
				newbg.visible = true;
				palooseMyDeez = false;
				dad.x = dad.y = 100;
				dad.y += 100;
				new FlxTimer().start(3.5, function(tmr:FlxTimer){
					FlxTween.tween(dad, {x: dad.x + 3000}, 2.25);
				});
				boyfriend.setPosition(770, 450);
				flipBF();
				camMoveAllowed = false;
				camFollow.set(boyfriend.x, boyfriend.y);
				FlxG.camera.snapToTarget();
				camMoveAllowed = true;
			case 'chaseScene':
				palooseMyDeez = true;
				DUMBASSPLAYTIMETWOPOINTOHISCLOSERTOBFSOTHECAMSHOULDNTMOVEASFARASITDOES = false;
				var penis = [Math.abs(boyfriend.x - (540 + 50)), Math.abs(boyfriend.y - (560 - 65))];
				running.setPosition(penis[0], penis[1]);
				flipBF();
				leggi.x = boyfriend.x - 85;
				leggi.y += 20;
				leggi.visible = true;
				swapDad('paloose-men', 1607, 434);
				iconP2.changeIcon(dad.iconName);
				iconP2.antialiasing = true;
				dad.y -= 20;
				running.visible = true;
				camMoveAllowed = false;
				camFollow.set(running.getMidpoint().x, running.getMidpoint().y);
				FlxG.camera.snapToTarget();
				camMoveAllowed = true;
				boyfriend.y += 100;
				running.y -= 20;
				ihmp = true;
				cheating5 = boyfriend.y;
			case 'futurePad':
				newbg.visible = false;
				funnyPart = true;
				defaultCamZoom = 1;
				FlxG.camera.zoom = 1;
				blackDeez.visible = whiteDeez1.visible = whiteDeez2.visible = true;
				leggi.visible = false;
				swapDad('garrett-pad');
				iconP2.changeIcon(dad.iconName);
				iconP2.antialiasing = false;
				dad.scrollFactor.set(0, 0);
				remove(boyfriend);
				boyfriend = new Boyfriend(452, 241, 'bf-pad');
				boyfriend.x -= 135;
				boyfriend.y -= 110;
				boyfriend.scrollFactor.set(0, 0);
				add(boyfriend);
				futurePad.visible = true;
				futurePadOverlay = new FlxSprite(-15, -29).loadGraphic(Paths.image('funnyAnimal/padFront'));
				futurePadOverlay.setGraphicSize(1139);
				futurePadOverlay.updateHitbox();
				futurePadOverlay.antialiasing = false;
				futurePadOverlay.scrollFactor.set(0, 0);
				add(futurePadOverlay);
		}
	}

	var bfFLip = true;
	var inJail = false;

	var whatJunk:Array<Float>;
	var cheating5:Float;

	function flipBF() {
		bfFLip = !bfFLip;
		boyfriend.flipX = !boyfriend.flipX;
		boyfriend.animation.remove('singLEFT');
		boyfriend.animation.remove('singRIGHT');
		boyfriend.animation.addByPrefix('singLEFT', '${bfFLip ? 'LEFT' : 'RIGHT'}', 24, false);
		boyfriend.animation.addByPrefix('singRIGHT', '${!bfFLip ? 'LEFT' : 'RIGHT'}', 24, false);
		boyfriend.animation.remove('singLEFTmiss');
		boyfriend.animation.remove('singRIGHTmiss');
		boyfriend.animation.addByPrefix('singLEFTmiss', 'M${bfFLip ? 'LEFT' : 'RIGHT'}', 24, false);
		boyfriend.animation.addByPrefix('singRIGHTmiss', 'M${!bfFLip ? 'LEFT' : 'RIGHT'}', 24, false);

		if(bfFLip)
		{
			boyfriend.addOffset('idle');
			boyfriend.addOffset("singUP", 79, 129);
			boyfriend.addOffset("singRIGHT", -59, 17);
			boyfriend.addOffset("singLEFT", -12, 13);
			boyfriend.addOffset("singDOWN", -11, -3);
			boyfriend.addOffset("singUPmiss", 73, 120);
			boyfriend.addOffset("singLEFTmiss", 70, 120);
			boyfriend.addOffset("singRIGHTmiss", 73, 120);
			boyfriend.addOffset("singDOWNmiss", 74, 120);
		}
		else
		{
			boyfriend.addOffset('idle');
			boyfriend.addOffset("singUP", 109, 129);
			boyfriend.addOffset("singLEFT", 58, 17);
			boyfriend.addOffset("singRIGHT", 11, 13);
			boyfriend.addOffset("singDOWN", -1, -3);
			boyfriend.addOffset("singUPmiss", 113, 120);
			boyfriend.addOffset("singRIGHTmiss", 110, 120);
			boyfriend.addOffset("singLEFTmiss", 113, 120);
			boyfriend.addOffset("singDOWNmiss", 114, 120);
		}
	}

	function eatShit(ass:String):Void
	{
		if (dialogue[0] == null)
		{
			trace(ass);
		}
		else
		{
			trace(dialogue[0]);
		}
	}

	function doMinusJunket()
	{
		for (junkyNumber in 0...3)
		{
			var fuckyJunk:FlxSprite = new FlxSprite(dad.x + FlxG.random.float(10, dad.width - 10), dad.y - FlxG.random.float(0, 50));
			fuckyJunk.loadGraphic(Paths.image('minus/junk' + Std.string(junkyNumber + 1)));
			fuckyJunk.scale.set(0.55, 0.55);
			fuckyJunk.updateHitbox();
			add(fuckyJunk);
			fuckyJunk.acceleration.y = FlxG.random.int(400, 550);
			fuckyJunk.velocity.y -= FlxG.random.int(200, 150);
			fuckyJunk.velocity.x = FlxG.random.float(-50, 50);
		}
	}

	function swapDad(char:String, x:Float = 100, y:Float = 100, flash:Bool = true, flashColor:FlxColor = FlxColor.WHITE)
	{
		if(dad != null)
			remove(dad);
			trace('remove dad');
		dad = new Character(x, y, char, false);
		trace('set dad');
		repositionDad();
		trace('repositioned dad');
		add(dad);
		trace('added dad');
		charactersInThisSongWow.push(dad.curCharacter);
		iconRPC = dad.iconRPC;
		if(flash)
		{
			FlxG.camera.flash(flashColor, 1, null, true);
			trace('flashed');
		}
	}

	function yum(char:String, x:Float = 100, y:Float = 100, flash:Bool = true, flashColor:FlxColor = FlxColor.WHITE)
	{
		if(dadmirror != null)
			remove(dadmirror);
			trace('remove dad');
		dadmirror = new Character(x, y, char, false);
		trace('set dad');
		add(dadmirror);
		trace('added dad');
		charactersInThisSongWow.push(dadmirror.curCharacter);
		if(flash)
		{
			FlxG.camera.flash(flashColor, 1, null, true);
			trace('flashed');
		}
	}

	function repositionDad() {
		switch (dad.curCharacter)
		{
			case 'cynda':
				dad.y += 75;
			case 'awesome-son':
				dad.y += 225;
				dad.x -= 75;
			case 'blogblez':
				dad.y += 75;
			case 'da-apprentice':
				dad.y += 185;
			case 'cock-cream' | 'wtf-lmao':
				dad.y += 150;
				dad.x += 75;
			case 'brob':
				dad.y += 300;
			case 'badrum':
				dad.y += 275;
				dad.x += 100;
			case 'swanki':
				dad.x -= 150;
				dad.y -= 25;
			case 'among':
				dad.x -= 130;
			case 'bookworm':
				dad.y += 200;
			case 'dave-unchecked':
				dad.y += 100;
				dad.x -= 250;
			case 'roblos':
				dad.y += 200;
				dad.x += -75;
			case 'diamond-man-mugen':
				dad.y += 300;
				dad.x += 25;
			case 'gotta-sleep':
				dad.setPosition(-1000, 300);
			case 'robot-guy':
				dad.setPosition(-45, -235);
			case 'gf':
				dad.setPosition(gf.x, gf.y);
				gf.visible = false;
				if (isStoryMode)
				{
					tweenCamIn();
				}
			case 'dave' | 'dave-annoyed' | 'dave-splitathon':
				{
					dad.y += 160;
					dad.x += 250;
				}
			case 'jeff':
				dad.y += 350;
			case 'bambi-piss-3d':
				{
					dad.y -= 250;
					dad.x -= 185;
				}
			case 'ringi':
				dad.y -= 475;
				dad.x -= 455;
			case 'bambom':
				dad.y -= 375;
				dad.x -= 500;
			case 'bendu':
				dad.y += 50;
				dad.x += 10;
			case 'bambi-unfair':
				{
					dad.y += 100;
				}
			case 'bambi' | 'bambi-old' | 'bambi-bevel' | 'what-lmao' | 'bambi-good' | 'super':
				{
					dad.y += 400;
				}
			case 'bambi-new' | 'bambi-farmer-beta':
				{
					dad.y += 450;
					dad.x += 200;
				}
			case 'bormp':
				dad.y += 400;
			case 'dave-wheels':
				dad.x += 100;
				dad.y += 300;
			case 'bambi-splitathon':
				{
					dad.x += 175;
					dad.y += 400;
				}
			case 'dave-png':
				dad.x += 81;
				dad.y += 108;
			case 'bambi-angey':
				dad.y += 450;
				dad.x += 100;
			case 'bandu-scaredy':
				dad.setPosition(-202, 20);
			case 'sart-producer-night':
				dad.setPosition(732, 83);
				dad.y -= 200;
			case 'RECOVERED_PROJECT' | 'corrupt-file':
				dad.setPosition(-307, 10);
			case 'RECOVERED_PROJECT_2' | 'RECOVERED_PROJECT_3':
				dad.setPosition(-307, 10);
				dad.y -= 400;
				dad.x -= 125;
			case 'sart-producer':
				dad.x -= 750;
				dad.y -= 360;
			case 'garrett':
				dad.y += 65;
			case 'elf':
				dad.x -= 285;
				dad.y -= 175;
			case 'diamond-man' | 'too-shiny':
				dad.y += 25;
			case 'og-dave' | 'og-dave-angey':
				dad.x -= 190;
			case 'hall-monitor':
				dad.x += 45;
				dad.y += 185;
			case 'garrett-animal':
				dad.x -= 175;
				dad.y -= 10;

				dad.x -= 250;
				dad.y -= 25;
			case 'playtime-2':
				dad.x -= 355;
				dad.y -= 216;
			case 'garrett-pad':
				dad.setPosition(227, 446);
				dad.x -= 75;
				dad.y -= 55;
			case 'playrobot' | 'playrobot-crazy':
				dad.y += 300;
				dad.x -= 235;
			case 'bandu-slices':
				dad.y += 250;
			case 'crazed':
				dad.y += 150;
			case 'jambi':
				dad.x -= 175;
			case 'dingle':
				dad.y += 150;
				dad.x += 50;
		}
	}
	
	//this is old and stupid but whatever its a good preloading thing
	function algebraStander(char:String, physChar:Character, x:Float = 100, y:Float = 100, startScared:Bool = false, idleAsStand:Bool = false)
	{
		return;
		if(physChar != null)
		{
			if(standersGroup.members.contains(physChar))
				standersGroup.remove(physChar);
				trace('remove physstander from group');
			remove(physChar);
			trace('remove physstander entirely');
		}
		physChar = new Character(x, y, char, false);
		trace('new physstander');
		standersGroup.add(physChar);
		trace('physstander in group');
		if(startScared)
		{
			physChar.playAnim('scared', true);
			trace('scaredy');
			new FlxTimer().start(Conductor.crochet / 1000, function(dick:FlxTimer){
				physChar.playAnim('stand', true);
				trace('standy');
			});
		}
		else
		{
			if(idleAsStand)
				physChar.playAnim('idle', true);
			else
				physChar.playAnim('stand', true);
			trace('standy');
		}
	}

	function snapCamFollowToPos(x:Float, y:Float) {
		camFollow.set(x, y);
		camFollowPos.setPosition(x, y);
	}

	function bgImg(Path:String) {
		return Paths.image('algebra/bgJunkers/$Path');
	}

	public function preload(graphic:String) //preload assets
	{
		if (boyfriend != null)
		{
			boyfriend.stunned = true;
		}
		var newthing:FlxSprite = new FlxSprite(15000, 15000).loadGraphic(Paths.image(graphic));
		add(newthing);
		if (boyfriend != null)
		{
			boyfriend.stunned = false;
		}
	}

	var zooBah = false;
}
