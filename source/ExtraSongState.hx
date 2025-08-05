package;

import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.util.FlxStringUtil;
import lime.utils.Assets;
#if desktop
import Discord.DiscordClient;
#end
import sys.FileSystem;

using StringTools;

class ExtraSongState extends MusicBeatState
{
	var gfSpeed:Int = 1;

	override function beatHit()
	{
		for (iconP2 in iconArray)
		{
			iconP2.scale.set(1.2, 1.2);
			iconP2.updateHitbox();
		}
		super.beatHit();
	}

	var songs:Array<SongMetadata> = [];

	var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('backgrounds/SUSSUS AMOGUS'));
	var curSelected:Int = 0;

	private var iconArray:Array<HealthIcon> = [];

	public var cat:String = 'extra';

	var swagText:FlxText = new FlxText(0, 0, FlxG.width, 'my poop is brimming', 85);
	var awesomeText:FlxText = new FlxText(0, 0, FlxG.width, 'Press space to view the OG mod!', 85);

	var songColors:Array<FlxColor> = [
		0xFFca1f6f, // GF
		0xFF4965FF, // DAVE
		0xFF00B515, // MISTER BAMBI r slur (i cant reclaim) //MISTER BAMBI RETARD (i can though)
		0xFF00FFFF, // SPLIT THE THONNNNN
		0xFF000000, // sart.
		FlxColor.YELLOW, // GARRETT????
		FlxColor.WHITE, // leaked recovered project full week
		FlxColor.GRAY, // HOLY SHIT ITS PLAYROBOT!!!
		FlxColor.LIME, // ALIEN?!?!?!?!
		FlxColor.BLUE // DIAMOND MAN!??!?!?!?!?!?
	];

	var logos:Array<FlxSprite> = [];

	var logoNames:Array<String> = ['SonicExe', 'HypnosLullaby', 'Shaggy', 'YungLixo'];
	var sourceModLinks:Array<String> = [
		'https://gamebanana.com/mods/316022',
		'https://gamebanana.com/mods/332345',
		'https://gamebanana.com/mods/284121',
		'https://gamejolt.com/games/yunglixomod/655212'
	];

	private var grpSongs:FlxTypedGroup<Alphabet>;

	public override function new(cat:String)
	{
		this.cat = cat;
		super();
	}

	override function create()
	{
		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}

		#if desktop DiscordClient.changePresence("In the Extra Songs Menu", null); #end

		bg.loadGraphic(MainMenuState.randomizeBG());
		bg.color = 0xFF4965FF;
		add(bg);

		if (cat == 'covers')
			logos = [for (i in logoNames) new FlxSprite().loadGraphic(Paths.image('logos/$i'))];

		switch (cat)
		{
			case 'secret':
				addWeek(['Cell'], 4, ['cell']);
				addWeek(['Ticking'], 2, ['ouch']);
				addWeek(['RECOVERED-PROJECT'], 6, ['recovered']);
				addWeek(['Dave-X-Bambi-Shipping-Cute'], 3, ['dab']);
			case 'ocs':
				addWeek(['Tantalum', 'Strawberry', 'Keyboard'], 2, ['ringi', 'bambom', 'bendu']);
				addWeek(['Sillier'], 2, ['blogblez']);
			case 'covers':
				addWeek(['Sunshine'], 2, ['doll']);
				addWeek(['Left-Unchecked', 'Thunderstorm'], 1, ['dave-unchecked', 'dave-png']);
				// addWeek(['Cycles'], 4, ['sart-producer']);
				addWeek(['Collision'], 9, ['diamond']);
			case 'iykyk':
				addWeek(['OG', 'Sick-Tricks'], 1, ['prealpha', 'roblos']);
				addWeek(['Galactic'], 2, ['super']);
			case 'awesome':
				addWeek(['Slices', 'Poopers'], 2, ['bandu', 'brob']);
				addWeek(['Clit'], 9, ['diamond']);
				addWeek(['Sweaty-Workout'], 2, ['butch']);
				addWeek(['My-Home'], 8, ['hall-monitor']);
				addWeek(['2-Spheres'], 0, ['leak-gf']);
				addWeek(['Jerry-the-Mouse', 'Threesome'], 3, ['underscore', 'face']);
				addWeek(['Sit-On-My-Face'], 6, ['gunk']);
				addWeek(['Amongfairness'], 2, ['sus']);
				addWeek(['Reflection', 'Bug-Eyed-Bitch'], 1, ['3d-bf', 'decdave']);
				addWeek(['Ny-Tristan'], 0, ['3d-tristan']);
				addWeek(['Gobbledegook', 'Generic'], 2, ['leak-wtf', 'icons']);
				addWeek(['Chilli-Powder'], 6, ['chili_icons']);
				addWeek(['Impregnate'], 5, ['scrub_icons']);
				addWeek(['Fuckity', 'Encrypted'], 2, ['leak-ringonal', 'leak-encrypted']);
				addWeek(['Pink-Bandu'], 0, ['lullabandu']);
				addWeek(['Trampoline-Accident', 'The-Big-Dingle'], 2, ['froing', 'dingle']);
				// addWeek(['The-100th-Ruby-Song'], 1, ['bweasal']);
				addWeek(['Locked-Lips'], 2, ['junkers']);
				// addWeek(['Wednesday'], 4, ['penis']);
				addWeek(['FL-Keys'], 5, ['charlie']);
				addWeek(['Bandu-Radical'], 2, ['radical-nambe']);
				addWeek(['Pee-Shooter'], 5, ['peashooter']);
				addWeek(['Third-Chance'], 2, ['sillycon-min-removebg-preview']);
				addWeek(['Second-Coming-Of-The-'], 0, ['clown']);
				addWeek(['I-Am-Canonically-Trans'], 1, ['peensum']);
				addWeek(['Among-Us-Penis-Sex'], 0, ['among']);
				addWeek(['The-Willy-Walter-Rap'], 0, ['willy-walter']);
			// addWeek(['T4-Player'], 0, ['t5-furry']);
			case 'joke':
				addWeek(['Wheels'], 1, ['wheels']);
				addWeek(['Poopers'], 0, ['awesome-son']);
				addWeek(['The-Boopadoop-Song'], 4, ['cynda']);
			default:
				addWeek(['Sugar-Rush', 'Gift-Card', 'The-Big-Dingle', 'Dale', 'Origin'], 2, ['bandu', 'bandu', 'dingle', 'dale', 'bandu-origin']);
				addWeek(['Apprentice'], 0, ['tristan']);
				addWeek(['Resumed', 'Ready-Loud', 'Bookworm'], 2, ['dambu', 'flumpt', 'bookworm']);
				addWeek(['Cuberoot', 'Alternate', 'Unhinged'], 1, ['disability', 'david', 'unhinged']);
				addWeek(['Theft'], 5, ['garrett']);
				addWeek(['Too-Shiny'], 9, ['diamond']);
				// addWeek(['Gotta-Sleep'], 7, ['gotta']);
				// addWeek(['Production', 'Genocidal'], 4, ['sart-producer', 'sart-producer']);
				// addWeek(['Cynda'], Std.parseInt('Cynda'), ['cynda']); trolled
		}

		grpSongs = new FlxTypedGroup<Alphabet>();
		add(grpSongs);

		swagText.setFormat("Comic Sans MS Bold", 48, FlxColor.BLACK, CENTER);
		swagText.screenCenter(X);
		swagText.y += 50;
		add(swagText);

		awesomeText.setFormat("Comic Sans MS Bold", 48, FlxColor.BLACK, CENTER);
		awesomeText.screenCenter(X);
		awesomeText.y += 50;
		if (cat == 'covers')
		{
			add(awesomeText);
		}

		for (i in 0...songs.length)
		{
			var songText:Alphabet = new Alphabet(0, (70 * i) + 30, songs[i].songName, true, false);
			songText.isMenuItem = true;
			songText.targetY = i;
			grpSongs.add(songText);

			var icon:HealthIcon = new HealthIcon(songs[i].songCharacter);
			icon.sprTracker = songText;
			if (songs[i].blackoutIcon)
			{
				icon.color = FlxColor.BLACK;
			}

			iconArray.push(icon);
			add(icon);
		}

		for (i in logos)
		{
			i.setGraphicSize(500);
			i.screenCenter();
			i.x += 275;
			add(i);
		}

		changeSelection();

		updateDiffies();

		super.create();
	}

	public function addWeek(songs:Array<String>, weekNum:Int, ?songCharacters:Array<String>)
	{
		if (songCharacters == null)
			songCharacters = ['bf'];

		var num:Int = 0;
		for (song in songs)
		{
			if (!checkSongUnlock(song))
				addSong('unknown', 4, songCharacters[num], true);
			else
				addSong(song, weekNum, songCharacters[num], false);

			if (songCharacters.length != 1)
				num++;
		}
	}

	public function checkSongUnlock(song:String)
	{
		if ((song.toLowerCase() == 'dave-x-bambi-shipping-cute' && !SaveFileState.saveFile.data.shipUnlocked)
			|| (song.toLowerCase() == 'recovered-project' && !SaveFileState.saveFile.data.foundRecoveredProject)
			|| (song.toLowerCase() == 'ticking' && !SaveFileState.saveFile.data.foundTicking)
			|| (song.toLowerCase() == 'cell' && !SaveFileState.saveFile.data.foundCell))
		{
			return false;
		}
		else
		{
			return true;
		}
	}

	public function addSong(songName:String, weekNum:Int, songCharacter:String, blackoutIcon:Bool = false)
	{
		songs.push(new SongMetadata(songName, weekNum, songCharacter, blackoutIcon));
	}

	override function update(p:Float)
	{
		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		Conductor.songPosition = FlxG.sound.music.time;

		for (iconP2 in iconArray)
		{
			var mult:Float = FlxMath.lerp(1, iconP2.scale.x, CoolUtil.boundTo(1 - (p * 9), 0, 1));
			iconP2.scale.set(mult, mult);
			iconP2.updateHitbox();
		}

		super.update(p);

		if (controls.UP_P)
			changeSelection(-1);

		if (controls.DOWN_P)
			changeSelection(1);

		if (controls.BACK)
			FlxG.switchState(new PlayMenuState());

		if (cat == 'covers')
		{
			if (FlxG.keys.justPressed.SPACE)
			{
				fancyOpenURL(sourceModLinks[curSelected]);
			}
		}

		if (controls.ACCEPT || FlxG.keys.justPressed.ENTER)
		{
			switch (songs[curSelected].songName.toLowerCase())
			{
				case 'unknown':
					FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
					FlxG.camera.shake(0.05, Conductor.stepCrochet / 1000, null, true);
				default:
					var pisswad = songs[curSelected].songName.toLowerCase();

					if (cat == 'awesome')
					{
						pisswad = 'slices';
					}

					var poop:String = Highscore.formatSong(pisswad, 1);

					trace(poop);

					PlayState.SONG = Song.loadFromJson(poop, pisswad);

					PlayState.isStoryMode = false;

					PlayState.storyDifficulty = 1;

					PlayState.xtraSong = true;

					PlayState.formoverride = 'none';

					PlayState.practicing = false;

					PlayState.fakedScore = false;

					PlayState.deathCounter = 0;

					PlayState.storyWeek = songs[curSelected].week;
					if (songs[curSelected].songName.toLowerCase() == 'midnight'
						|| songs[curSelected].songName.toLowerCase() == 'ready-loud'
						|| songs[curSelected].songName.toLowerCase() == 'cuberoot'
						|| songs[curSelected].songName.toLowerCase() == 'dave-x-bambi-shipping-cute'
						|| songs[curSelected].songName.toLowerCase() == 'cheating-not-cute'
						|| songs[curSelected].songName.toLowerCase() == 'left-unchecked'
						|| songs[curSelected].songName.toLowerCase() == 'collision')
					{
						LoadingState.loadAndSwitchState(new PlayState());
					}
					else
					{
						LoadingState.loadAndSwitchState(new CharacterSelectState());
					}
			}
		}
	}

	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		curSelected += change;

		if (curSelected < 0)
			curSelected = songs.length - 1;

		if (curSelected >= songs.length)
			curSelected = 0;

		switch (songs[curSelected].songName.toLowerCase())
		{
			case 'unknown':
				swagText.text = 'A secret is required to unlock this song!';
				swagText.visible = true;
			default:
				swagText.visible = false;
		}

		#if PRELOAD_ALL
		if (cat == 'awesome')
		{
			if (songs[curSelected].songName.toLowerCase() == 'slices')
			{
				FlxG.sound.playMusic(Paths.inst(songs[curSelected].songName), 0);
				var hmm;
				try
				{
					var poop:String = Highscore.formatSong(songs[curSelected].songName.toLowerCase(), 1);

					trace(poop);
					hmm = Song.loadFromJson(poop, songs[curSelected].songName.toLowerCase());
					if (hmm != null)
					{
						Conductor.changeBPM(hmm.bpm);
					}
				}
				catch (ex)
				{
				}
			}
			else if (songs[curSelected].songName.toLowerCase() == 'fl-keys')
			{
				FlxG.sound.playMusic(Paths.inst(songs[curSelected].songName), 0);
			}
			else
			{
				FlxG.sound.playMusic(Paths.tta(Std.string(FlxG.random.int(0, 30))), 0);
			}
		}
		else
		{
			FlxG.sound.playMusic(Paths.inst(songs[curSelected].songName), 0);
			var hmm;
			try
			{
				var poop:String = Highscore.formatSong(songs[curSelected].songName.toLowerCase(), 1);

				trace(poop);
				hmm = Song.loadFromJson(poop, songs[curSelected].songName.toLowerCase());
				if (hmm != null)
				{
					Conductor.changeBPM(hmm.bpm);
				}
			}
			catch (ex)
			{
			}
		}
		Conductor.songPosition = 0;
		curBeat = 0;
		#end

		var bullShit:Int = 0;

		for (i in 0...iconArray.length)
		{
			iconArray[i].alpha = 0.6;
		}

		iconArray[curSelected].alpha = 1;

		for (item in grpSongs.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;

			if (item.targetY == 0)
			{
				item.alpha = 1;
			}
		}

		for (i in logos)
		{
			i.visible = logos.indexOf(i) == curSelected;
		}

		updateDiffies();

		FlxTween.color(bg, 0.25, bg.color, songColors[songs[curSelected].week]);
	}

	var difficultyImg:FlxSprite;

	function updateDiffies()
	{
		if (difficultyImg != null)
		{
			remove(difficultyImg);
		}
		var suffey = '';
		if (cat == 'awesome')
			suffey = '-demon';
		difficultyImg = new FlxSprite();
		difficultyImg.loadGraphic(Paths.image('diff/' + CoolUtil.songDiffRating(songs[curSelected].songName.toLowerCase()) + suffey));
		difficultyImg.scale.set(0.5, 0.5);
		difficultyImg.setPosition(FlxG.width - ((546 / 1.4) + 5), FlxG.height - ((497 / 1.4) + 5));
		difficultyImg.scrollFactor.set(0, 0);
		add(difficultyImg);
	}
}

class SongMetadata
{
	public var songName:String = "";
	public var week:Int = 0;
	public var songCharacter:String = "";
	public var blackoutIcon:Bool = false;

	public function new(song:String, week:Int, songCharacter:String, blackoutIcon:Bool)
	{
		this.songName = song;
		this.week = week;
		this.songCharacter = songCharacter;
		this.blackoutIcon = blackoutIcon;
	}
}
