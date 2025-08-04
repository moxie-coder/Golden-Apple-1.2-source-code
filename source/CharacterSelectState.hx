package;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.text.FlxText;
import flixel.system.FlxSoundGroup;
import flixel.math.FlxPoint;
import openfl.geom.Point;
import flixel.*;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.math.FlxMath;
import flixel.util.FlxStringUtil;

using StringTools;

 /**
 hey you fun commiting people, 
 i don't know about the rest of the mod but since this is basically 99% my code 
 i do not give you guys permission to grab this specific code and re-use it in your own mods without asking me first.
 the secondary dev, ben
*/

/**

	hi

**/

class CharacterInSelect
{
	public var names:Array<String>;
	public var polishedNames:Array<String>;

	public function new(names:Array<String>, polishedNames:Array<String>)
	{
		this.names = names;
		this.polishedNames = polishedNames;
	}
}

class CharacterSelectState extends MusicBeatState
{
	public var char:Boyfriend;
	public var current:Int = 0;
	public var curForm:Int = 0;
	public var characterText:FlxText;

	public var funnyIconMan:HealthIcon;

	var notestuffs:Array<String> = ['LEFT', 'DOWN', 'UP', 'RIGHT'];

	public var isDebug:Bool = false; //CHANGE THIS TO FALSE BEFORE YOU COMMIT RETARDS

	public var PressedTheFunny:Bool = false;

	var selectedCharacter:Bool = false;

	var currentSelectedCharacter:CharacterInSelect;

	var noteMsTexts:FlxTypedGroup<FlxText> = new FlxTypedGroup<FlxText>();

	//it goes left,right,up,down
	
	public var characters:Array<CharacterInSelect> = 
	[
		new CharacterInSelect(['bf', 'bf-pixel', '3d-bf'], ["Boyfriend", 'Pixel Boyfriend', '3D Boyfriend']),
		new CharacterInSelect(['froing'], ['Boing Froing']),
		new CharacterInSelect(['epic'], ['Biggity Dawg']),
		new CharacterInSelect(['split-dave-3d', 'insanidave'], ['Disability Dave', 'Cuberoot Dave']),
		new CharacterInSelect(['tunnel-dave', 'dave-unchecked'], ['Decimated Dave', 'Decimated Dave (Left Unchecked)']),
		new CharacterInSelect(['crazed'], ["Insane Dave"]),
		new CharacterInSelect(['og-dave', 'og-dave-angey'], ['Algebra Dave', 'Algebra Dave (Angry)']),
		new CharacterInSelect(['da-apprentice', '3d-tristan'], ['Tristan', '3D Tristan']),
		new CharacterInSelect(['bambi-piss-3d', 'bamb-root'], ['Angry 3D Bambi', 'Cuberoot Bambi']),
		new CharacterInSelect(['unfair-junker'], ['Expunged (Applecore, Facing Forward)']),
		new CharacterInSelect(['bandu', 'badai', 'bandu-candy', 'bandu-card', 'bandu-origin', 'bandu-lullaby'], ['Bandu', 'Badai', 'Bandu (Sugar Rush)', 'Bandu (Gift Card)', 'Bandu (Origin)', 'Bandu (Lullaby)']),
		new CharacterInSelect(['garrett'], ["Garrett"]),
		new CharacterInSelect(['hall-monitor'], ["Hall Monitor"]),
		new CharacterInSelect(['diamond-man', 'too-shiny', 'diamond-man-mugen'], ["Diamond Man", "Diamond Man (Too Shiny)", 'Diamond Man (Collision)']),
		new CharacterInSelect(['playrobot', 'playrobot-crazy'], ["Playrobot", 'Playrobot (Crazy)']),
		new CharacterInSelect(['alge'], ["Algebraicaitrix"]),
		new CharacterInSelect(['butch'], ["Butchatrix"]),
		new CharacterInSelect(['bad'], ["Badtrix"]),
		new CharacterInSelect(['garrett-animal', 'garrett-piss', 'car'], ['Garrett (Ferocious)', 'Garrett (Ferocious, Pissed)', 'Garrett (Ferocious, Car)']),
		new CharacterInSelect(['playtime-2'], ['Playtime 2.0']),
		new CharacterInSelect(['paloose-men'], ['Paloose Men']),
		new CharacterInSelect(['wizard'], ["This is a Wizard"]),
		new CharacterInSelect(['mr-music'], ["Mr. Music"]),
		new CharacterInSelect(['do-you-accept-player'], ["Do You Accept"]),
		new CharacterInSelect(['dingle'], ["The Big Dingle"]),
		new CharacterInSelect(['donk'], ["Donk"]),
		new CharacterInSelect(['dale'], ["Dale"]),
		new CharacterInSelect(['dambu'], ["Dambu"]),
		new CharacterInSelect(['dambai'], ["Dambai"]),
		//new CharacterInSelect(['sart-producer', 'sart-producer-night'], ["Sart Producer", "Sart Producer (Night)"]),
		new CharacterInSelect(['ringi'], ["Ringi"]),
		new CharacterInSelect(['bambom'], ["Bambom"]),
		new CharacterInSelect(['bendu'], ["Bendu"]),
		//new CharacterInSelect(['swanki'], ["Swanki"]),
		new CharacterInSelect(['blogblez'], ["Blogblez"]),
		new CharacterInSelect(['dave-wheels'/*, 'wtf-lmao'*/], ["Dave but Awesome"/*, "Dave but Awesome (3D)"*/]),
		//new CharacterInSelect(['bormp', 'cock-cream'], ["Bambi but Awesome", "Bambi but Awesome (3D)"]),
		new CharacterInSelect(['awesome-son'], ["Dave's Awesome Son"]),
		new CharacterInSelect(['prealpha'], ["Prealpha Dave"]),
		new CharacterInSelect(['roblos'], ["Roblox Dave"]),
		new CharacterInSelect(['super'], ["Nupersovae Bambi"]),
	];
	public function new() 
	{
		super();
	}
	
	override public function create():Void 
	{
		super.create();
		Conductor.changeBPM(100);

		currentSelectedCharacter = characters[current];

		FlxG.sound.playMusic(Paths.music("character_select"),1,true);
		
		//create stage
		var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('stageback'));
		bg.antialiasing = true;
		bg.scrollFactor.set(0.9, 0.9);
		bg.active = false;
		add(bg);

		var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('stagefront'));
		stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
		stageFront.updateHitbox();
		stageFront.antialiasing = true;
		stageFront.scrollFactor.set(0.9, 0.9);
		stageFront.active = false;
		add(stageFront);

		var stageCurtains:FlxSprite = new FlxSprite(-500, -300).loadGraphic(Paths.image('stagecurtains'));
		stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
		stageCurtains.updateHitbox();
		stageCurtains.antialiasing = true;
		stageCurtains.scrollFactor.set(1.3, 1.3);
		stageCurtains.active = false;
		add(stageCurtains);

		FlxG.camera.zoom = 0.75;

		//create character
		char = new Boyfriend(FlxG.width / 2, FlxG.height / 2, "bf");
		char.screenCenter();
		add(char);
		
		characterText = new FlxText((FlxG.width / 9) - 50, (FlxG.height / 8) - 225, "Boyfriend");
		characterText.font = 'Comic Sans MS Bold';
		characterText.setFormat(Paths.font("comic.ttf"), 90, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		characterText.autoSize = false;
		characterText.fieldWidth = FlxG.width;
		characterText.borderSize = 7;
		characterText.screenCenter(X);
		add(characterText);

		funnyIconMan = new HealthIcon('bf', true);
		funnyIconMan.screenCenter(X);
		funnyIconMan.y = characterText.y + 100;
		add(funnyIconMan);

		var tutorialThing:FlxSprite = new FlxSprite().loadGraphic(Paths.image('charSelectGuide'));
		tutorialThing.setGraphicSize(Std.int(tutorialThing.width * 1.5));
		tutorialThing.antialiasing = true;
		tutorialThing.y += tutorialThing.height / 2;
		add(tutorialThing);
	}

	override public function update(elapsed:Float):Void 
	{
		Conductor.songPosition = FlxG.sound.music.time;

		super.update(elapsed);
		//FlxG.camera.focusOn(FlxG.ce);

		if (FlxG.keys.justPressed.ESCAPE)
		{
			LoadingState.loadAndSwitchState(new PlayMenuState());
		}

		if(controls.LEFT_P && !PressedTheFunny)
		{
			if(!char.nativelyPlayable)
			{
				char.playAnim('singRIGHT', true);
			}
			else
			{
				char.playAnim('singLEFT', true);
			}

		}
		if(controls.RIGHT_P && !PressedTheFunny)
		{
			if(!char.nativelyPlayable)
			{
				char.playAnim('singLEFT', true);
			}
			else
			{
				char.playAnim('singRIGHT', true);
			}
		}
		if(controls.UP_P && !PressedTheFunny)
		{
			char.playAnim('singUP', true);
		}
		if(controls.DOWN_P && !PressedTheFunny)
		{
			char.playAnim('singDOWN', true);
		}
		
		if(char.animation.curAnim.name.contains('idle') || char.animation.curAnim.name.contains('dance'))
		{
			fuckyWucky = true;
		}
		else
		{
			fuckyWucky = char.animation.finished;
		}
		
		if (controls.ACCEPT || FlxG.keys.justPressed.ENTER)
		{
			if(!SaveFileState.saveFile.data.charUnlock.get(char.curCharacter, false))
			{
				return;
			}
			if (PressedTheFunny)
			{
				return;
			}
			else
			{
				PressedTheFunny = true;
			}
			selectedCharacter = true;
			if(char.animation.getByName("hey") != null)
			{
				char.playAnim('hey', true);
			}
			else if(char.animation.getByName("cheer") != null)
			{
				char.playAnim('cheer', true);
			}
			else if(char.animation.getByName("stand") != null)
			{
				char.playAnim('stand', true);
			}
			else
			{
				char.playAnim('singUP', true);
			}
			FlxG.sound.music.stop();
			FlxG.sound.play(Paths.music('gameOverEnd'));
			new FlxTimer().start(1.9, endIt);
		}
		if (FlxG.keys.justPressed.LEFT && !selectedCharacter)
		{
			curForm = 0;
			current--;
			if (current < 0)
			{
				current = characters.length - 1;
			}
			UpdateBF();
			FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		}

		if (FlxG.keys.justPressed.RIGHT && !selectedCharacter)
		{
			curForm = 0;
			current++;
			if (current > characters.length - 1)
			{
				current = 0;
			}
			UpdateBF();
			FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		}
		if (FlxG.keys.justPressed.DOWN && !selectedCharacter)
		{
			curForm--;
			if (curForm < 0)
			{
				curForm = characters[current].names.length - 1;
			}
			UpdateBF();
			FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		}

		if (FlxG.keys.justPressed.UP && !selectedCharacter)
		{
			curForm++;
			if (curForm > characters[current].names.length - 1)
			{
				curForm = 0;
			}
			UpdateBF();
			FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		}
	}

	public function UpdateBF()
	{
		funnyIconMan.color = FlxColor.WHITE;
		currentSelectedCharacter = characters[current];
		characterText.text = currentSelectedCharacter.polishedNames[curForm];
		char.destroy();
		char = new Boyfriend(FlxG.width / 2, FlxG.height / 2, currentSelectedCharacter.names[curForm]);
		char.screenCenter();
		char.y = 450;

		if(!SaveFileState.saveFile.data.charUnlock.get(char.curCharacter, false))
		{
			characterText.text = 'Locked Character';
			char.color = FlxColor.BLACK;
			funnyIconMan.color = FlxColor.BLACK;
		}

		char.screenCenter();
		add(char);
		funnyIconMan.changeIcon(char.iconName);
		characterText.screenCenter(X);
	}

	var fuckyWucky:Bool = true;

	override function beatHit()
	{
		super.beatHit();
		if (char != null && !selectedCharacter && fuckyWucky)
		{
			char.dance();
		}
	}
	
	
	public function endIt(e:FlxTimer = null)
	{
		trace("ENDING");
		PlayState.characteroverride = currentSelectedCharacter.names[0];
		PlayState.formoverride = currentSelectedCharacter.names[curForm];
		PlayState.curmult = [1, 1, 1, 1];
		LoadingState.loadAndSwitchState(new LoadingScreenState());
	}
	
}