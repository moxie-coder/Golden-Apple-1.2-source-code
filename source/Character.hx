package;

import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.animation.FlxAnimationController;

using StringTools;

class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';

	public var canSing:Bool = true;

	public var holdTimer:Float = 0;
	public var furiosityScale:Float = 1.02;
	public var canDance:Bool = true;

	public var iconName:String = 'face';

	public var iconRPC:String = 'icon_dave';

	public var nativelyPlayable:Bool = false;

	public var globaloffset:Array<Float> = [0, 0];

	public var curCamOffsetX:Float = 0;
	public var curCamOffsetY:Float = 0;

	public var offsetScale:Float = 1;

	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false)
	{
		super(x, y);

		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		this.isPlayer = isPlayer;

		var tex:FlxAtlasFrames;
		antialiasing = true;

		switch (curCharacter)
		{
			case 'chipper':
				tex = Paths.getSparrowAtlas('characters/chipper');
				frames = tex;
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");

				scale.set(6, 6);
				updateHitbox();
				antialiasing = false;

				playAnim('idle');

				iconName = 'chipper';

				iconRPC = 'icon_chipper';
			case 'dambu': // literally just a copy of dambai's code with 1 letter changed and 1 removed
				// GARRETT SHITE ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/dambu');
				frames = tex;
				animation.addByPrefix('idle', 'IDLE'.toLowerCase(), 24, false);
				animation.addByPrefix('singUP', 'UP'.toLowerCase(), 24, false);
				animation.addByPrefix('singRIGHT', 'RIGHT'.toLowerCase(), 24, false);
				animation.addByPrefix('singDOWN', 'DOWN'.toLowerCase(), 24, false);
				animation.addByPrefix('singLEFT', 'LEFT'.toLowerCase(), 24, false);
				animation.addByPrefix('look', 'look', 24, false);
				animation.addByPrefix('talk', 'talk', 24, false);

				addOffset('idle');
				addOffset("singUP", 0, 90);
				addOffset("singRIGHT", -120);
				addOffset("singLEFT", 70, 10);
				addOffset("singDOWN");

				antialiasing = false;

				playAnim('idle');

				iconName = 'dambu';

				iconRPC = 'icon_dambu';
			case 'dambai':
				// GARRETT SHITE ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/dambai');
				frames = tex;
				animation.addByPrefix('idle', 'IDLE'.toLowerCase(), 24, false);
				animation.addByPrefix('singUP', 'UP'.toLowerCase(), 24, false);
				animation.addByPrefix('singRIGHT', 'RIGHT'.toLowerCase(), 24, false);
				animation.addByPrefix('singDOWN', 'DOWN'.toLowerCase(), 24, false);
				animation.addByPrefix('singLEFT', 'LEFT'.toLowerCase(), 24, false);
				animation.addByPrefix('look', 'look', 24, false);
				animation.addByPrefix('talk', 'talk', 24, false);

				addOffset('idle');
				addOffset("singUP", 0, 90);
				addOffset("singRIGHT", -120);
				addOffset("singLEFT", 70, 10);
				addOffset("singDOWN");

				antialiasing = false;

				playAnim('idle');

				iconName = 'dambai';

				iconRPC = 'icon_dambai';
			case 'sammy':
				// GARRETT SHITE ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/SammyNew');
				frames = tex;
				animation.addByPrefix('idle', 'IDLE'.toLowerCase(), 24, false);
				animation.addByPrefix('singUP', 'UP'.toLowerCase(), 24, false);
				animation.addByPrefix('singRIGHT', 'left'.toLowerCase(), 24, false);
				animation.addByPrefix('singDOWN', 'DOWN'.toLowerCase(), 24, false);
				animation.addByPrefix('singLEFT', 'right'.toLowerCase(), 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");

				antialiasing = false;

				playAnim('idle');

				iconName = 'sammy';

				iconRPC = 'icon_sammy';
			case 'bambop':
				// GARRETT SHITE ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/bambop');
				frames = tex;
				animation.addByPrefix('idle', 'Dad idle dance', 24, false);
				animation.addByPrefix('singUP', 'Dad Sing Note UP', 24, false);
				animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24, false);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24, false);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");

				antialiasing = false;

				playAnim('idle');

				iconName = 'bambop';

				iconRPC = 'icon_bambop';
			case '3d-tristan':
				// GARRETT SHITE ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/adopted_motherfucker');
				frames = tex;
				animation.addByPrefix('idle', 'IDLE', 24, false);
				animation.addByPrefix('singUP', 'UP', 24, false);
				animation.addByPrefix('singRIGHT', 'RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'LEFT', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");

				antialiasing = false;
				scale.set(0.85, 0.85);
				updateHitbox();

				playAnim('idle');

				iconName = '3d-tristan';

				iconRPC = 'icon_3d_tristan';
			case 'blogblez':
				// GARRETT SHITE ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/blogblez');
				frames = tex;
				animation.addByPrefix('idle', 'BlogblezIdle', 24, false);
				animation.addByPrefix('singUP', 'BlogblezUp', 24, false);
				animation.addByPrefix('singRIGHT', 'BlogblezRight', 24, false);
				animation.addByPrefix('singDOWN', 'BlogblezDown', 24, false);
				animation.addByPrefix('singLEFT', 'BlogblezLeft', 24, false);

				addOffset('idle');
				addOffset("singUP", 104 * 0.75, 111 * 0.75);
				addOffset("singRIGHT", -40 * 0.75, -60 * 0.75);
				addOffset("singLEFT", 200, -60);
				addOffset("singDOWN", 140 * 0.75, -470 * 0.75);

				scale.set(0.75, 0.75);

				antialiasing = false;

				playAnim('idle');

				iconName = 'blogblez';

				iconRPC = 'icon_blogblez';
			case 'da-apprentice':
				// GARRETT SHITE ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/tristan');
				frames = tex;
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);

				addOffset('idle');
				addOffset("singUP", 21 * 0.9, 98 * 0.9);
				addOffset("singRIGHT", -30 * 0.9, -12 * 0.9);
				addOffset("singLEFT", 100 * 0.9, 15 * 0.9);
				addOffset("singDOWN", -10 * 0.9, -10 * 0.9);

				playAnim('idle');

				scale.set(0.9, 0.9);
				updateHitbox();

				iconName = 'tristan';

				iconRPC = 'icon_tristan';
			case 'awesome-son':
				// GARRETT SHITE ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/daves_awesome_son');
				frames = tex;
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);
				animation.addByPrefix('singUP-alt', 'screaming up', 24, false);
				animation.addByPrefix('singRIGHT-alt', 'screaming right', 24, false);
				animation.addByPrefix('singDOWN-alt', 'screaming down', 24, false);
				animation.addByPrefix('singLEFT-alt', 'screaming left', 24, false);

				addOffset('idle');
				addOffset("singUP", 0, 690);
				addOffset("singRIGHT", -120, 70);
				addOffset("singLEFT", 170, 20);
				addOffset("singDOWN", -30, -40);
				addOffset("singUP-alt", 320, 360);
				addOffset("singRIGHT-alt", 480, 280);
				addOffset("singLEFT-alt", 1330, 425);
				addOffset("singDOWN-alt", 530, 200);

				playAnim('idle');

				iconName = 'awesome-son';

				antialiasing = false;

				iconRPC = 'icon_awesome_son';
			case 'do-you-accept-player':
				tex = Paths.getSparrowAtlas('funnyAnimal/do_you_accept');
				frames = tex;
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'left', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'right', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");

				setGraphicSize(Std.int(width * furiosityScale), Std.int(height * furiosityScale));
				updateHitbox();
				antialiasing = false;

				playAnim('idle');

				flipX = !flipX;

				iconName = 'do-you-accept-player';

				iconRPC = 'icon_dya';
			case 'diamond-man-mugen':
				tex = Paths.getSparrowAtlas('characters/diamondmugen');
				frames = tex;
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('idle-alt', 'chacharealsmooth', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);

				addOffset('idle', 0, 270);
				addOffset('idle-alt', 35, 328);
				addOffset("singUP", 169, 280);
				addOffset("singRIGHT", 114, 326);
				addOffset("singLEFT", 449, -26);
				addOffset("singDOWN", 168, 24);

				scale.set(1.2, 1.2);
				updateHitbox();
				antialiasing = false;

				playAnim('idle');

				iconName = 'diamond';

				iconRPC = 'icon_diamond';
			case 'garrett-piss':
				tex = Paths.getSparrowAtlas('funnyAnimal/garrett_piss');
				frames = tex;
				animation.addByIndices('danceLeft', 'idle', [0, 1, 2, 3, 4, 5], '', 24, false);
				animation.addByIndices('danceRight', 'idle', [6, 7, 8, 9, 10, 11], '', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");

				setGraphicSize(Std.int(width * furiosityScale), Std.int(height * furiosityScale));
				updateHitbox();
				antialiasing = false;

				playAnim('danceRight');

				iconName = 'garrett-animal';

				iconRPC = 'icon_garrett_animal';
			case 'do-you-accept':
				tex = Paths.getSparrowAtlas('funnyAnimal/do_you_accept');
				frames = tex;
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");

				setGraphicSize(Std.int(width * furiosityScale), Std.int(height * furiosityScale));
				updateHitbox();
				antialiasing = false;

				playAnim('idle');

				iconName = 'do-you-accept';

				iconRPC = 'icon_dya';
			case 'prealpha':
				tex = Paths.getSparrowAtlas('characters/prealpha_dude');
				frames = tex;
				animation.addByPrefix('idle', 'Dad idle dance', 24, false);
				animation.addByPrefix('singUP', 'Dad Sing note UP', 24, false);
				animation.addByPrefix('singLEFT', 'dad sing note right', 24, false);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24, false);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note LEFT', 24, false);

				addOffset('idle');
				addOffset("singUP", -7, 45);
				addOffset("singRIGHT", -2, 21);
				addOffset("singLEFT", -9, 5);
				addOffset("singDOWN", 2, -32);

				playAnim('idle');

				iconName = 'prealpha';

				iconRPC = 'icon_prealpha';
			case 'car':
				tex = Paths.getSparrowAtlas('funnyAnimal/carThing');
				frames = tex;
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");

				setGraphicSize(Std.int(width * furiosityScale), Std.int(height * furiosityScale));
				updateHitbox();
				antialiasing = false;

				playAnim('idle');

				iconName = 'garrett-animal';

				iconRPC = 'icon_garrett_animal';
			case 'mr-music':
				tex = Paths.getSparrowAtlas('funnyAnimal/mrMusic');
				frames = tex;
				animation.addByPrefix('idle', 'YEA', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);

				addOffset('idle');
				addOffset("singUP", -26 * 3, 64 * 3);
				addOffset("singRIGHT", 3 * 3, -7 * 3);
				addOffset("singLEFT", 88 * 3, -6 * 3);
				addOffset("singDOWN", 31 * 3, -34 * 3);

				scale.set(3, 3);
				updateHitbox();
				antialiasing = false;

				playAnim('idle');

				iconName = 'mr-music';

				iconRPC = 'icon_mr_music';
			case 'wizard':
				tex = Paths.getSparrowAtlas('funnyAnimal/wizard');
				frames = tex;
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");

				setGraphicSize(Std.int(width * furiosityScale), Std.int(height * furiosityScale));
				updateHitbox();
				antialiasing = false;

				playAnim('idle');

				iconName = 'wizard';

				iconRPC = 'icon_wizard';
			case 'hover-dude':
				tex = Paths.getSparrowAtlas('characters/hover_dude');
				frames = tex;
				animation.addByPrefix('idle', 'IDLE', 24, false);
				animation.addByPrefix('singUP', 'UP', 24, false);
				animation.addByPrefix('singRIGHT', 'RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'LEFT', 24, false);

				addOffset('idle');
				addOffset("singUP", -50, -50);
				addOffset("singRIGHT", 25, 21);
				addOffset("singLEFT", -32, -38);
				addOffset("singDOWN", 39, 97);

				setGraphicSize(Std.int(width * furiosityScale), Std.int(height * furiosityScale));
				updateHitbox();
				antialiasing = false;

				playAnim('idle');

				iconName = 'shitter';

				iconRPC = 'icon_shitter';
			case 'bamb-root':
				tex = Paths.getSparrowAtlas('characters/root_bamber');
				frames = tex;
				// animation.addByPrefix('idle', 'IDLE', 24, false);
				animation.addByIndices('danceLeft', 'IDLE'.toLowerCase(), [for (i in 0...13) i], "", 24, false);
				animation.addByIndices('danceRight', 'IDLE'.toLowerCase(), [for (i in 13...25) i], "", 24, false);
				animation.addByPrefix('singUP', 'UP'.toLowerCase(), 24, false);
				animation.addByPrefix('singRIGHT', 'RIGHT'.toLowerCase(), 24, false);
				animation.addByPrefix('singDOWN', 'DOWN'.toLowerCase(), 24, false);
				animation.addByPrefix('singLEFT', 'LEFT'.toLowerCase(), 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");

				setGraphicSize(Std.int(width * furiosityScale), Std.int(height * furiosityScale));
				updateHitbox();
				antialiasing = false;

				// nativelyPlayable = true;

				playAnim('danceLeft');

				iconName = 'bambroot';

				iconRPC = 'icon_bambroot';
			case 'garrett-pad':
				tex = Paths.getSparrowAtlas('funnyAnimal/garret_padFuture');
				frames = tex;
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");

				scale.set(0.51, 0.51);
				updateHitbox();
				antialiasing = false;

				playAnim('idle');

				iconName = 'garrett-animal';

				iconRPC = 'icon_garrett_animal';
			case 'bf-pad':
				frames = Paths.getSparrowAtlas('funnyAnimal/garrett_bf');
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);

				addOffset('idle');
				addOffset("singUP", 14, 25);
				addOffset("singRIGHT", 0, 7);
				addOffset("singLEFT", 60, 18);
				addOffset("singDOWN", -7, -24);

				nativelyPlayable = flipX = true;

				antialiasing = false;

				scale.set(0.35, 0.35);
				updateHitbox();

				iconName = '3d-bf';

				playAnim('idle');
			case 'paloose-men':
				tex = Paths.getSparrowAtlas('funnyAnimal/palooseMen');
				frames = tex;
				animation.addByPrefix('idle', 'idle', 24, true);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);

				addOffset('idle');
				addOffset("singUP", -237, 106);
				addOffset("singRIGHT", -260, -40);
				addOffset("singLEFT", 362, -56);
				addOffset("singDOWN", -180, -240);

				setGraphicSize(Std.int(width * furiosityScale), Std.int(height * furiosityScale));
				updateHitbox();
				antialiasing = false;

				playAnim('idle');

				iconName = 'paloose-men';

				iconRPC = 'icon_paloose_men';
			case 'playtime-2':
				tex = Paths.getSparrowAtlas('funnyAnimal/playTimeTwoPointOh');
				frames = tex;
				animation.addByPrefix('friend', 'CHECK OUT MY LIL FRIENDO', 24, false);
				animation.addByIndices('danceLeft', 'idle', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15], '', 24, false);
				animation.addByIndices('danceRight', 'idle', [16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32], '', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);

				addOffset('danceLeft', -614, -360);
				addOffset('danceRight', -614, -360);
				addOffset("singUP", -614, -360);
				addOffset("singRIGHT", -614, -360);
				addOffset("singLEFT", -614, -360);
				addOffset("singDOWN", -614, -360);
				addOffset('friend');

				setGraphicSize(Std.int(width * furiosityScale), Std.int(height * furiosityScale));
				updateHitbox();
				antialiasing = false;

				playAnim('friend');

				iconName = 'playtime-2';

				iconRPC = 'icon_playtime_2';
			case 'garrett-animal':
				tex = Paths.getSparrowAtlas('funnyAnimal/garrett');
				frames = tex;
				animation.addByIndices('danceLeft', 'idle', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15], '', 24, false);
				animation.addByIndices('danceRight', 'idle', [16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32], '', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);

				addOffset('danceLeft');
				addOffset('danceRight');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");

				setGraphicSize(Std.int(width * furiosityScale), Std.int(height * furiosityScale));
				updateHitbox();
				antialiasing = false;

				playAnim('danceRight');

				iconName = 'garrett-animal';

				iconRPC = 'icon_garrett_animal';
			case 'future-dave':
				tex = Paths.getSparrowAtlas('future/FUTURE_DAVE');
				frames = tex;
				animation.addByIndices('danceLeft', 'idle', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], '', 24, false);
				animation.addByIndices('danceRight', 'idle', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], '', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");

				setGraphicSize(Std.int(width * furiosityScale), Std.int(height * furiosityScale));
				updateHitbox();
				antialiasing = false;

				playAnim('danceRight');

				iconName = 'future';

				iconRPC = 'icon_future';
			case 'gf':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('characters/GF_assets');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				iconName = 'gf';

				playAnim('danceRight');
			case 'gf-only':
				frames = Paths.getSparrowAtlas('characters/GF_ONLY');
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				addOffset('sad');
				addOffset('danceLeft');
				addOffset('danceRight');

				iconName = 'gf';

				playAnim('danceRight');
			case 'gf-pixel':
				tex = Paths.getSparrowAtlas('characters/gfPixel');
				frames = tex;
				animation.addByIndices('singUP', 'GF IDLE', [2], "", 24, false);
				animation.addByIndices('danceLeft', 'GF IDLE', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF IDLE', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);

				playAnim('danceRight');

				setGraphicSize(Std.int(width * PlayState.daPixelZoom));
				updateHitbox();
				antialiasing = false;

				globaloffset[0] = -200;
				globaloffset[1] = -175;

				iconName = 'gf';
			case 'gf-pixel-only':
				tex = Paths.getSparrowAtlas('characters/gf_only_pixel');
				frames = tex;
				animation.addByIndices('singUP', 'GF IDLE', [2], "", 24, false);
				animation.addByIndices('danceLeft', 'GF IDLE', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF IDLE', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);

				playAnim('danceRight');

				setGraphicSize(Std.int(width * PlayState.daPixelZoom));
				updateHitbox();
				antialiasing = false;

				globaloffset[0] = -200;
				globaloffset[1] = -175;

				iconName = 'gf';
			case 'gf-pixel-white':
				tex = Paths.getSparrowAtlas('characters/gfOnlyPixelWhite');
				frames = tex;
				animation.addByIndices('singUP', 'GF IDLE', [2], "", 24, false);
				animation.addByIndices('danceLeft', 'GF IDLE', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF IDLE', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);

				playAnim('danceRight');

				setGraphicSize(Std.int(width * PlayState.daPixelZoom));
				updateHitbox();
				antialiasing = false;

				globaloffset[0] = -200;
				globaloffset[1] = -175;

				iconName = 'gf';
			case 'gf-christmas':
				tex = Paths.getSparrowAtlas('characters/gfChristmas');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');

				iconName = 'gf';
			case '3d-bf':
				frames = Paths.getSparrowAtlas('characters/3D_BF');
				animation.addByPrefix('idle', 'IDLE', 24, false);
				animation.addByPrefix('singUP', 'UP', 24, false);
				animation.addByPrefix('singLEFT', 'LEFT', 24, false);
				animation.addByPrefix('singRIGHT', 'RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'DOWN', 24, false);
				animation.addByPrefix('singUPmiss', 'MUP', 24, false);
				animation.addByPrefix('singLEFTmiss', 'MLEFT', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'MRIGHT', 24, false);
				animation.addByPrefix('singDOWNmiss', 'MDOWN', 24, false);

				addOffset('idle');
				addOffset("singUP", 79, 129);
				addOffset("singRIGHT", -59, 17);
				addOffset("singLEFT", -12, 13);
				addOffset("singDOWN", -11, -3);
				addOffset("singUPmiss", 73, 120);
				addOffset("singLEFTmiss", 70, 120);
				addOffset("singRIGHTmiss", 73, 120);
				addOffset("singDOWNmiss", 74, 120);

				flipX = true;

				nativelyPlayable = true;

				// wtf
				antialiasing = false;

				iconName = '3d-bf';

				playAnim('idle');
			case 'bookworm':
				frames = Paths.getSparrowAtlas('characters/bookworm');
				animation.addByPrefix('idle', 'bambi idle0', 24, false);
				animation.addByPrefix('singUP', 'bambi up0', 24, false);
				animation.addByPrefix('singLEFT', 'bambi left0', 24, false);
				animation.addByPrefix('singRIGHT', 'bambi right0', 24, false);
				animation.addByPrefix('singDOWN', 'bambi down0', 24, false);
				animation.addByPrefix('idle-alt', 'bambi idle mad0', 24, false);
				animation.addByPrefix('singUP-alt', 'bambi up mad0', 24, false);
				animation.addByPrefix('singLEFT-alt', 'bambi left mad0', 24, false);
				animation.addByPrefix('singRIGHT-alt', 'bambi right mad0', 24, false);
				animation.addByPrefix('singDOWN-alt', 'bambi down mad0', 24, false);

				addOffset('idle');
				addOffset("singUP", 27, 43);
				addOffset("singRIGHT", 107, -10);
				addOffset("singLEFT", 50);
				addOffset("singDOWN", 30, -13);
				addOffset('idle-alt', 90, -30);
				addOffset("singUP-alt", 30, 44);
				addOffset("singRIGHT-alt", 107, -10);
				addOffset("singLEFT-alt", 47, -3);
				addOffset("singDOWN-alt", 31, -8);

				iconName = 'bookworm';

				iconRPC = 'icon_bookworm';

				playAnim('idle');
			case 'hang-bf':
				frames = Paths.getSparrowAtlas('characters/hanging_bf');
				animation.addByPrefix('idle', 'HANG', 24, false);
				animation.addByPrefix('firstDeath', 'HANG', 24, false);
				animation.addByIndices('deathLoop', "HANG", [10], '', 24, false);
				animation.addByIndices('deathConfirm', "HANG", [10], '', 24, false);
				animation.play('firstDeath');

				nativelyPlayable = flipX = true;

				antialiasing = false;

				iconName = '3d-bf';
			case '3d-bf-death':
				frames = Paths.getSparrowAtlas('characters/3d_bf_dies');
				animation.addByPrefix('idle', 'DIES', 24, false);
				animation.addByPrefix('firstDeath', 'DIES', 24, false);
				animation.addByPrefix('deathLoop', 'DIE LOOP', 24, false);
				animation.addByPrefix('deathConfirm', 'DIE CONFIRM', 24, false);
				animation.play('firstDeath');

				nativelyPlayable = flipX = true;

				antialiasing = false;

				iconName = '3d-bf';
			case 'eww-bf':
				frames = Paths.getSparrowAtlas('characters/yucky_bf');
				animation.addByPrefix('idle', 'IDLE', 24, false);
				animation.addByPrefix('singUP', 'UP', 24, false);
				animation.addByPrefix('singLEFT', 'LEFT', 24, false);
				animation.addByPrefix('singRIGHT', 'RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'DOWN', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT", 80);
				addOffset("singLEFT", 0, -20);
				addOffset("singDOWN", 30);

				nativelyPlayable = flipX = true;

				antialiasing = false;

				iconName = 'testicles';

				playAnim('idle');
			case 'bf-pixel':
				frames = Paths.getSparrowAtlas('characters/bfPixel');
				animation.addByPrefix('idle', 'BF IDLE', 24, false);
				animation.addByPrefix('singUP', 'BF UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'BF LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'BF RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'BF DOWN NOTE', 24, false);
				animation.addByPrefix('singUPmiss', 'BF UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF DOWN MISS', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				addOffset("singUPmiss");
				addOffset("singRIGHTmiss");
				addOffset("singLEFTmiss");
				addOffset("singDOWNmiss");

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('idle');

				width -= 100;
				height -= 100;

				antialiasing = false;

				flipX = true;

				nativelyPlayable = true;

				globaloffset[0] = -200;
				globaloffset[1] = -175;

				iconName = 'bf-pixel';
			case 'bf-pixel-white':
				frames = Paths.getSparrowAtlas('characters/bfPixelWhite');
				animation.addByPrefix('idle', 'BF IDLE', 24, false);
				animation.addByPrefix('singUP', 'BF UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'BF LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'BF RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'BF DOWN NOTE', 24, false);
				animation.addByPrefix('singUPmiss', 'BF UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF DOWN MISS', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				addOffset("singUPmiss");
				addOffset("singRIGHTmiss");
				addOffset("singLEFTmiss");
				addOffset("singDOWNmiss");

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('idle');

				width -= 100;
				height -= 100;

				antialiasing = false;

				flipX = true;

				nativelyPlayable = true;

				globaloffset[0] = -200;
				globaloffset[1] = -175;

				iconName = 'bf-pixel-white';
			case 'bf-pixel-dead':
				frames = Paths.getSparrowAtlas('characters/bfPixelsDEAD');
				animation.addByPrefix('singUP', "BF Dies pixel", 24, false);
				animation.addByPrefix('firstDeath', "BF Dies pixel", 24, false);
				animation.addByPrefix('deathLoop', "Retry Loop", 24, false);
				animation.addByPrefix('deathConfirm', "RETRY CONFIRM", 24, false);
				animation.play('firstDeath');

				addOffset('firstDeath');
				addOffset('deathLoop', -37);
				addOffset('deathConfirm', -37);
				playAnim('firstDeath');
				// pixel bullshit
				setGraphicSize(Std.int(width * 6));
				updateHitbox();
				antialiasing = false;
				flipX = true;
				iconName = 'bf-pixel';
			case 'bf-christmas':
				var tex = Paths.getSparrowAtlas('characters/bfChristmas');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);

				playAnim('idle');

				flipX = true;

				iconName = 'bf';
			case 'first-dave-sprites':
				tex = Paths.getSparrowAtlas('characters/the_original_vs_dave');
				frames = tex;
				animation.addByPrefix('idle', "Pico Idle Dance", 24);
				animation.addByPrefix('singUP', 'pico Up note0', 24, false);
				animation.addByPrefix('singDOWN', 'Pico Down Note0', 24, false);
				if (isPlayer)
				{
					animation.addByPrefix('singLEFT', 'Pico NOTE LEFT0', 24, false);
					animation.addByPrefix('singRIGHT', 'Pico Note Right0', 24, false);
					animation.addByPrefix('singRIGHTmiss', 'Pico Note Right Miss', 24, false);
					animation.addByPrefix('singLEFTmiss', 'Pico NOTE LEFT miss', 24, false);
				}
				else
				{
					// Need to be flipped! REDO THIS LATER!
					animation.addByPrefix('singLEFT', 'Pico Note Right0', 24, false);
					animation.addByPrefix('singRIGHT', 'Pico NOTE LEFT0', 24, false);
					animation.addByPrefix('singRIGHTmiss', 'Pico NOTE LEFT miss', 24, false);
					animation.addByPrefix('singLEFTmiss', 'Pico Note Right Miss', 24, false);
				}

				animation.addByPrefix('singUPmiss', 'pico Up note miss', 24);
				animation.addByPrefix('singDOWNmiss', 'Pico Down Note MISS', 24);

				addOffset('idle');
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -68, -7);
				addOffset("singLEFT", 65, 9);
				addOffset("singDOWN", 200, -70);
				addOffset("singUPmiss", -19, 67);
				addOffset("singRIGHTmiss", -60, 41);
				addOffset("singLEFTmiss", 62, 64);
				addOffset("singDOWNmiss", 210, -28);

				playAnim('idle');

				flipX = true;

				antialiasing = false;

				iconName = 'first-dave';
			case 'bandu-scaredy':
				frames = Paths.getSparrowAtlas('characters/bandu_scaredy');
				animation.addByPrefix('idle', 'idle', 24, false);
				for (anim in ['left', 'down', 'up', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
				}
				animation.addByPrefix('hey', 'creaming', 24, false);

				addOffset('idle');
				addOffset('singLEFT');
				addOffset('singDOWN');
				addOffset('singUP');
				addOffset('singRIGHT');
				addOffset('hey');

				nativelyPlayable = flipX = true;

				antialiasing = false;

				setGraphicSize(1009);
				updateHitbox();

				iconName = 'bandu';

				iconRPC = 'icon_bandu';

				playAnim('idle');
			case 'bandu-card':
				frames = Paths.getSparrowAtlas('characters/card_bandu');
				animation.addByPrefix('idle', 'IDLE', 24, false);
				for (anim in ['LEFT', 'DOWN', 'UP', 'RIGHT'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
				}

				addOffset('idle');
				addOffset('singLEFT', -116, 9);
				addOffset('singDOWN', -60, 40);
				addOffset('singUP', 35, -12);
				addOffset('singRIGHT', 10, 10);

				antialiasing = false;

				setGraphicSize(Std.int(width * furiosityScale), Std.int(height * furiosityScale));
				updateHitbox();

				scale.set(1.35, 1.35);
				updateHitbox();

				iconName = 'bandu';

				iconRPC = 'icon_bandu';

				playAnim('idle');
			case 'facecam':
				frames = Paths.getSparrowAtlas('characters/live_bandu_reaction');
				animation.addByPrefix('idle', 'IDLE', 24, false);
				animation.addByPrefix('scream', 'SCREAM', 24, false);
				for (anim in ['LEFT', 'DOWN', 'UP', 'RIGHT'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
				}

				addOffset('idle');
				addOffset('scream');
				addOffset('singLEFT');
				addOffset('singDOWN');
				addOffset('singUP');
				addOffset('singRIGHT');

				antialiasing = false;

				scale.set(0.75, 0.75);
				updateHitbox();

				iconName = 'bandu';

				iconRPC = 'icon_bandu';

				nativelyPlayable = true;
				flipX = !flipX;

				playAnim('idle');
			case 'bandu-slices':
				frames = Paths.getSparrowAtlas('characters/slices_bandu');
				animation.addByPrefix('idle', 'IDLE', 24, false);
				for (anim in ['LEFT', 'DOWN', 'UP', 'RIGHT'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
				}

				addOffset('idle');
				addOffset('singLEFT');
				addOffset('singDOWN');
				addOffset('singUP');
				addOffset('singRIGHT');

				if (isPlayer)
				{
					iconName = 'awesomePlayer';
				}
				else
				{
					iconName = 'awesomeEnemy';
				}

				iconRPC = 'icon_bandu';

				playAnim('idle');
			case 'doll':
				frames = Paths.getSparrowAtlas('characters/bandoll');
				animation.addByPrefix('idle', 'IDLE', 24, false);
				for (anim in ['LEFT', 'DOWN', 'UP', 'RIGHT'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
				}

				addOffset('idle');
				addOffset('singLEFT', 0, 60);
				addOffset('singDOWN', 60, 10);
				addOffset('singUP', 150, -150);
				addOffset('singRIGHT', 340);

				antialiasing = false;

				setGraphicSize(Std.int(width * furiosityScale), Std.int(height * furiosityScale));
				updateHitbox();

				iconName = 'doll';

				iconRPC = 'icon_doll';

				playAnim('idle');
			case 'swanki':
				frames = Paths.getSparrowAtlas('characters/swanki');
				animation.addByPrefix('idle', 'IDLE', 24, false);
				for (anim in ['LEFT', 'DOWN', 'UP', 'RIGHT'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim + '0', 24, false);
				}

				for (anim in ['LEFT', 'DOWN', 'UP', 'RIGHT'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}-hold', anim + ' HOLD', 24, false);
				}

				addOffset('idle');
				addOffset('singLEFT');
				addOffset('singDOWN');
				addOffset('singUP');
				addOffset('singRIGHT');
				addOffset('singLEFT-hold');
				addOffset('singDOWN-hold');
				addOffset('singUP-hold');
				addOffset('singRIGHT-hold');

				antialiasing = false;

				setGraphicSize(Std.int(width * furiosityScale), Std.int(height * furiosityScale));
				updateHitbox();

				iconName = 'smartass';

				iconRPC = 'icon_smartass';

				playAnim('idle');
			case 'doll-alt':
				frames = Paths.getSparrowAtlas('characters/bandoll_lightsoff');
				animation.addByPrefix('idle', 'IDLE', 24, false);
				for (anim in ['LEFT', 'DOWN', 'UP', 'RIGHT'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
				}

				addOffset('idle');
				addOffset('singLEFT', 0, 60);
				addOffset('singDOWN', 60, 10);
				addOffset('singUP', 150, -150);
				addOffset('singRIGHT', 340);

				antialiasing = false;

				setGraphicSize(Std.int(width * furiosityScale), Std.int(height * furiosityScale));
				updateHitbox();

				iconName = 'doll';

				iconRPC = 'icon_doll';

				playAnim('idle');
			case 'playrobot':
				frames = Paths.getSparrowAtlas('characters/playrobot');

				animation.addByIndices('danceRight', 'Idle', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], '', 24, false);
				animation.addByIndices('danceLeft', 'Idle', [12, 13, 14, 15, 16, 17], '', 24, false);
				animation.addByPrefix('singUP', 'Up', 24, false);
				animation.addByPrefix('singLEFT', 'Left', 24, false);
				animation.addByPrefix('singRIGHT', 'Right', 24, false);
				animation.addByPrefix('singDOWN', 'Down', 24, false);

				addOffset('danceLeft');
				addOffset('danceRight');
				addOffset('singLEFT', 216, -56);
				addOffset('singDOWN', -76, -26);
				addOffset('singUP', -124, 75);
				addOffset('singRIGHT', -190, 63);

				antialiasing = false;

				playAnim('danceRight');

				iconName = 'playrobot';
				iconRPC = 'icon_playrobot';
			case 'playrobot-crazy':
				frames = Paths.getSparrowAtlas('characters/ohshit');

				animation.addByIndices('danceRight', 'Idle', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], '', 24, false);
				animation.addByIndices('danceLeft', 'Idle', [12, 13, 14, 15, 16, 17], '', 24, false);
				animation.addByPrefix('singUP', 'Up', 24, false);
				animation.addByPrefix('singLEFT', 'Left', 24, false);
				animation.addByPrefix('singRIGHT', 'Right', 24, false);
				animation.addByPrefix('singDOWN', 'Down', 24, false);

				addOffset('danceLeft');
				addOffset('danceRight');
				addOffset('singLEFT', 216, -56);
				addOffset('singDOWN', -76, -26);
				addOffset('singUP', -124, 75);
				addOffset('singRIGHT', -190, 63);

				antialiasing = false;

				playAnim('danceRight');

				iconName = 'playrobot';

				iconRPC = 'icon_playrobot';
			case 'hall-monitor':
				frames = Paths.getSparrowAtlas('characters/HALL_MONITOR');
				animation.addByPrefix('idle', 'gdj', 24, false);
				for (anim in ['left', 'down', 'up', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
				}

				addOffset('idle');
				addOffset('singLEFT', 436, 401);
				addOffset('singDOWN', 145, 25);
				addOffset('singUP', -150, 62);
				addOffset('singRIGHT', 201, 285);

				antialiasing = false;
				scale.set(1.5, 1.5);
				updateHitbox();

				playAnim('idle');

				iconName = 'hall-monitor';

				iconRPC = 'icon_hall_monitor';
			case 'diamond-man':
				frames = Paths.getSparrowAtlas('characters/diamondMan');
				animation.addByPrefix('idle', 'idle', 24, true);
				for (anim in ['left', 'down', 'up', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
				}

				addOffset('idle');
				addOffset('singLEFT', 610);
				addOffset('singDOWN', 91, -328);
				addOffset('singUP', -12, 338);
				addOffset('singRIGHT', 4);

				scale.set(1.3, 1.3);
				updateHitbox();

				antialiasing = false;

				playAnim('idle');

				iconName = 'diamond';

				iconRPC = 'icon_diamond';
			case 'too-shiny':
				frames = Paths.getSparrowAtlas('characters/diamondswag');
				animation.addByPrefix('idle', 'diamond idle', 24, false);
				for (anim in ['left', 'down', 'up', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', 'diamond ' + anim, 24, false);
				}

				addOffset('idle');
				addOffset('singLEFT', 318, 33);
				addOffset('singDOWN', 80, -60);
				addOffset('singUP', 70, 154);
				addOffset('singRIGHT', 100, 23);

				antialiasing = false;

				playAnim('idle');

				iconName = 'diamond';

				iconRPC = 'icon_diamond';
			case 'dave-wheels':
				frames = Paths.getSparrowAtlas('characters/cool');
				animation.addByIndices('danceLeft', 'idle', [0, 1, 2, 3, 4, 5, 6], '', 24, false);
				animation.addByIndices('danceRight', 'idle', [7, 8, 9, 10, 11, 12, 13], '', 24, false);
				for (anim in ['left', 'down', 'up', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
				}

				addOffset('danceLeft');
				addOffset('danceRight');
				addOffset('singLEFT', 12, -23);
				addOffset('singDOWN', -40, -23);
				addOffset('singUP', -40, 214);
				addOffset('singRIGHT', 9, -23);

				antialiasing = false;
				scale.set(1.8, 1.8);
				updateHitbox();

				playAnim('danceRight');

				iconName = 'wheels';

				iconRPC = 'icon_wheels';
			case 'wtf-lmao':
				frames = Paths.getSparrowAtlas('characters/what_the_fuck');
				animation.addByPrefix('danceLeft', 'DL', 24, false);
				animation.addByPrefix('danceRight', 'DR', 24, false);
				for (anim in ['LEFT', 'DOWN', 'UP', 'RIGHT'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
				}

				addOffset('danceLeft');
				addOffset('danceRight');
				addOffset('singLEFT', 220 * 1.5, 300 * 1.5);
				addOffset('singDOWN', 0, 30 * 1.5);
				addOffset('singUP', 330 * 1.5, 170 * 1.5);
				addOffset('singRIGHT', 40 * 1.5, 333 * 1.5);

				antialiasing = false;
				scale.set(1.5, 1.5);
				updateHitbox();

				playAnim('danceRight');

				iconName = 'wheels';

				iconRPC = 'icon_wheels';
			case 'cock-cream':
				frames = Paths.getSparrowAtlas('characters/cock_cream');
				animation.addByPrefix('idle', 'IDLE', 24, false);
				for (anim in ['LEFT', 'DOWN', 'UP', 'RIGHT'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
				}

				addOffset('idle');
				addOffset('singLEFT');
				addOffset('singDOWN');
				addOffset('singUP', 0, 50 * 1.5);
				addOffset('singRIGHT');

				antialiasing = false;
				scale.set(1.5, 1.5);
				updateHitbox();

				playAnim('idle');

				iconName = 'bormp';

				iconRPC = 'icon_bormp';
			case 'epic':
				frames = Paths.getSparrowAtlas('characters/epic');
				animation.addByPrefix('idle', 'idle', 24, false);
				for (anim in ['left', 'down', 'up', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
				}

				addOffset('idle');
				addOffset('singLEFT', 70, 20);
				addOffset('singDOWN', -90);
				addOffset('singUP', -135, 346);
				addOffset('singRIGHT', -93, 49);

				nativelyPlayable = true;

				flipX = true;

				antialiasing = false;

				playAnim('idle');

				iconName = 'epic';
			case 'bormp':
				frames = Paths.getSparrowAtlas('characters/awesome_bambi');
				animation.addByPrefix('idle', 'idle', 24, false);
				for (anim in ['left', 'down', 'up', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
				}

				addOffset('idle');
				addOffset('singLEFT', 230, 90);
				addOffset('singDOWN', 104, 17);
				addOffset('singUP', 151, 239);
				addOffset('singRIGHT', -22, 40);

				antialiasing = false;

				playAnim('idle');

				iconName = 'bormp';

				iconRPC = 'icon_bormp';
			case 'crazed':
				frames = Paths.getSparrowAtlas('characters/crazyDave');
				animation.addByPrefix('idle', 'idle', 24, false);
				for (anim in ['left', 'down', 'up', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
				}

				animation.addByPrefix('idle-alt', 'mad idle', 24, false);
				for (anim in ['left', 'down', 'up', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}-alt', 'mad ' + anim, 24, false);
				}

				animation.addByPrefix('scream', 'scream', 24, false);

				addOffset('idle');
				addOffset('singLEFT', 64, -11);
				addOffset('singDOWN', 3, -93);
				addOffset('singUP', 59, 173);
				addOffset('singRIGHT', 7, -27);
				addOffset('idle-alt');
				addOffset('singLEFT-alt', 64, -11);
				addOffset('singDOWN-alt', 3, -93);
				addOffset('singUP-alt', 59, 173);
				addOffset('singRIGHT-alt', 7, -27);
				addOffset('scream', 3, -27);

				playAnim('idle');

				iconName = 'unhinged';

				iconRPC = 'icon_unhinged';
			case 'david':
				frames = Paths.getSparrowAtlas('characters/david');
				animation.addByIndices('danceRight', 'IDLE', [0, 1, 2, 3, 4, 5, 6, 7], '', 24, false);
				animation.addByIndices('danceLeft', 'IDLE', [8, 9, 10, 11, 12, 13], '', 24, false);
				for (anim in ['LEFT', 'DOWN', 'UP', 'RIGHT'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
				}

				addOffset('danceRight');
				addOffset('danceLeft', 0, 20);
				addOffset('singLEFT', -80, 30);
				addOffset('singDOWN', 0, 60);
				addOffset('singUP');
				addOffset('singRIGHT', 50);

				antialiasing = false;

				setGraphicSize(Std.int(width * furiosityScale), Std.int(height * furiosityScale));
				updateHitbox();

				playAnim('danceRight');

				iconName = 'david';

				iconRPC = 'icon_david';
			case 'badrum':
				frames = Paths.getSparrowAtlas('characters/badrum');
				animation.addByPrefix('idle', 'IDLE', 24, false);
				for (anim in ['LEFT', 'DOWN', 'UP', 'RIGHT'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
				}

				animation.addByIndices('singLEFT-hold', 'LEFT', [for (i in 1...9) i], '', 24, false);
				animation.addByIndices('singRIGHT-hold', 'RIGHT', [for (i in 1...9) i], '', 24, false);
				animation.addByIndices('singDOWN-hold', 'DOWN', [for (i in 1...9) i], '', 24, false);
				animation.addByIndices('singUP-hold', 'UP', [for (i in 1...10) i], '', 24, false);

				addOffset('idle');
				addOffset('singLEFT', 69, -22);
				addOffset('singDOWN', 60, 80);
				addOffset('singUP', 68, 51);
				addOffset('singRIGHT', -50, -50);
				addOffset('singLEFT-hold', 69, -22);
				addOffset('singDOWN-hold', 60, 80);
				addOffset('singUP-hold', 68, 51);
				addOffset('singRIGHT-hold', -50, -50);

				antialiasing = false;

				scale.set(1.5, 1.5);
				updateHitbox();

				playAnim('idle');

				iconName = 'badrum';

				iconRPC = 'icon_badrum';
			case 'super':
				frames = Paths.getSparrowAtlas('characters/novae');
				animation.addByPrefix('idle', 'Bambert idle', 24, false);
				animation.addByPrefix('singUP', 'Bambert note up', 24, false);
				animation.addByPrefix('singLEFT', 'Bambert note left', 24, false);
				animation.addByPrefix('singRIGHT', 'Bambert note Right', 24, false);
				animation.addByPrefix('singDOWN', 'Bambert note down', 24, false);

				addOffset('idle');
				addOffset('singLEFT', 128, -10);
				addOffset('singDOWN', -78, -63);
				addOffset('singUP', -57, 88);
				addOffset('singRIGHT', -100);

				playAnim('idle');

				iconName = 'super';

				iconRPC = 'icon_super';
			case 'faty':
				frames = Paths.getSparrowAtlas('characters/faty');
				animation.addByPrefix('idle', 'Fat bambi Idle', 24, false);
				animation.addByPrefix('singUP', 'Fat bambi note up', 24, false);
				animation.addByPrefix('singLEFT', 'Fat bambi note left', 24, false);
				animation.addByPrefix('singRIGHT', 'Fat bambi note right', 24, false);
				animation.addByPrefix('singDOWN', 'Fat bambi note down', 24, false);

				addOffset('idle');
				addOffset('singLEFT', 68, 36);
				addOffset('singDOWN', -66, -53);
				addOffset('singUP', -63, 109);
				addOffset('singRIGHT', -40, 1);

				playAnim('idle');

				iconName = 'faty';
			case 'roblos':
				frames = Paths.getSparrowAtlas('characters/roblox_dave_sprites');
				animation.addByPrefix('idle', 'Roblox dave Idle', 24, false);
				animation.addByPrefix('singUP', 'Roblox dave note up', 24, false);
				animation.addByPrefix('singLEFT', 'Roblox dave note left', 24, false);
				animation.addByPrefix('singRIGHT', 'Roblox dave note right', 24, false);
				animation.addByPrefix('singDOWN', 'Roblox dave note down', 24, false);

				addOffset('idle');
				addOffset('singLEFT', 150);
				addOffset('singDOWN', 10, 210);
				addOffset('singUP', 16, 73);
				addOffset('singRIGHT', -120, 40);

				playAnim('idle');

				iconName = 'roblos';

				iconRPC = 'icon_roblos';
			case 'gf-wheels':
				loadGraphic(Paths.image('characters/best_gf'), true, 241, 231);
				animation.add('idle', [0], 0, false);

				scale.set(1.9, 1.9);
				antialiasing = false;
				updateHitbox();

				playAnim('idle');

				iconName = 'gf';
			case 'ringi':
				frames = Paths.getSparrowAtlas('characters/ringi');
				animation.addByPrefix('idle', 'IDLE', 24, false);
				for (anim in ['LEFT', 'DOWN', 'UP', 'RIGHT'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
				}

				addOffset('idle');
				addOffset('singLEFT');
				addOffset('singDOWN');
				addOffset('singUP');
				addOffset('singRIGHT');

				setGraphicSize(Std.int(width * furiosityScale), Std.int(height * furiosityScale));
				updateHitbox();

				antialiasing = false;

				playAnim('idle');

				iconName = 'ringi';

				iconRPC = 'icon_ringi';
			case 'bambom':
				frames = Paths.getSparrowAtlas('characters/bambom');
				animation.addByPrefix('idle', 'IDLE', 24, false);
				for (anim in ['LEFT', 'DOWN', 'UP', 'RIGHT'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
				}

				addOffset('idle');
				addOffset('singLEFT');
				addOffset('singDOWN');
				addOffset('singUP');
				addOffset('singRIGHT');

				furiosityScale = 0.75;

				setGraphicSize(Std.int(width * furiosityScale), Std.int(height * furiosityScale));
				updateHitbox();

				antialiasing = false;

				playAnim('idle');

				iconName = 'bambom';

				iconRPC = 'icon_bambom';
			case 'gary':
				frames = Paths.getSparrowAtlas('characters/gary');
				animation.addByPrefix('idle', 'Idle', 24, false);
				for (anim in ['left', 'down', 'up', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
				}

				addOffset('idle');
				addOffset('singLEFT', 68, -81);
				addOffset('singDOWN', 30, -135);
				addOffset('singUP', 22, -57);
				addOffset('singRIGHT', 25, -92);

				setGraphicSize(Std.int(width * furiosityScale), Std.int(height * furiosityScale));
				updateHitbox();

				antialiasing = false;

				playAnim('idle');

				iconName = 'gary';

				iconRPC = 'icon_gary';
			case 'bendu':
				frames = Paths.getSparrowAtlas('characters/bendu');
				animation.addByPrefix('idle', 'IDLE', 24, false);
				for (anim in ['LEFT', 'DOWN', 'UP', 'RIGHT'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
				}

				addOffset('idle');
				addOffset('singLEFT');
				addOffset('singDOWN');
				addOffset('singUP');
				addOffset('singRIGHT');

				setGraphicSize(Std.int(width * furiosityScale), Std.int(height * furiosityScale));
				updateHitbox();

				antialiasing = false;

				playAnim('idle');

				iconName = 'bendu';

				iconRPC = 'icon_bendu';
			case 'jeff':
				frames = Paths.getSparrowAtlas('characters/jeff');
				animation.addByPrefix('idle', 'Idle', 24, false);
				for (anim in ['Down', 'Up', 'Right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
				}
				animation.addByPrefix('singLEFT', 'Lefty', 24, false);

				addOffset('idle');
				addOffset('singLEFT', 88, 11);
				addOffset('singDOWN', -40, -20);
				addOffset('singUP', -40, 93);
				addOffset('singRIGHT', -80, 10);

				playAnim('idle');

				iconName = 'jeff';

				iconRPC = 'icon_jeff';
			case 'dave-png':
				frames = Paths.getSparrowAtlas('characters/dave-png');
				animation.addByPrefix('idle', 'idle', 24, false);
				for (anim in ['left', 'down', 'up', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
				}

				addOffset('idle');
				addOffset('singLEFT', 45);
				addOffset('singDOWN', 28, -5);
				addOffset('singUP', -2, 29);
				addOffset('singRIGHT', 1);

				playAnim('idle');

				iconName = 'dave-png';
			case 'brob':
				frames = Paths.getSparrowAtlas('characters/brobgonal');
				animation.addByPrefix('idle', 'IDLE', 24, false);
				for (anim in ['LEFT', 'DOWN', 'UP', 'RIGHT'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
				}

				addOffset('idle');
				addOffset('singLEFT', 20, -30);
				addOffset('singDOWN', -3, 1);
				addOffset('singUP', -8, 2);
				addOffset('singRIGHT', 154, -14);

				playAnim('idle');

				antialiasing = false;

				iconName = 'brob';

				iconRPC = 'icon_brob';

			case 'barbu':
				tex = Paths.getSparrowAtlas('characters/barbu');
				frames = tex;
				animation.addByPrefix('idle', 'IDLE', 24, true);
				animation.addByPrefix('singUP', 'UP', 24, false);
				animation.addByPrefix('singRIGHT', 'RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'LEFT', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				setGraphicSize(Std.int(width * furiosityScale), Std.int(height * furiosityScale));
				updateHitbox();
				antialiasing = false;

				playAnim('idle');

				iconName = 'barbu';

				iconRPC = 'icon_barbu';

			case 'split-dave-3d':
				// DAVE SHITE ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/split_dave_3d');
				frames = tex;
				animation.addByPrefix('idle', 'IDLE', 24, false);
				animation.addByPrefix('singUP', 'UP', 24, false);
				animation.addByPrefix('singRIGHT', 'RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'LEFT', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				setGraphicSize(Std.int(width * furiosityScale), Std.int(height * furiosityScale));
				updateHitbox();
				antialiasing = false;

				playAnim('idle');

				iconName = 'disability';

				iconRPC = 'icon_split_dave_3d';

			case 'insanidave':
				// DAVE SHITE ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/insanidave');
				frames = tex;
				animation.addByPrefix('idle', 'IDLE', 24, false);
				animation.addByPrefix('singUP', 'UP', 24, false);
				animation.addByPrefix('singRIGHT', 'RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'LEFT', 24, false);

				addOffset('idle');
				addOffset("singUP", 1, -28);
				addOffset("singRIGHT", 30);
				addOffset("singLEFT", -40, -5);
				addOffset("singDOWN", 0, 27);
				setGraphicSize(Std.int(width * furiosityScale), Std.int(height * furiosityScale));
				updateHitbox();
				antialiasing = false;

				playAnim('idle');

				iconName = 'disability';

				iconRPC = 'icon_split_dave_3d';

			case 'bandu-origin':
				tex = Paths.getSparrowAtlas('characters/bandu_origin');
				frames = tex;
				animation.addByPrefix('idle', 'IDLE', 24, false);
				animation.addByPrefix('singUP', 'UP', 24, false);
				animation.addByPrefix('singRIGHT', 'RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'LEFT', 24, false);
				animation.addByPrefix('cutscene', 'CUTSCENE', 24, false);
				animation.addByPrefix('singFUCK', 'FUCK', 24, false);

				addOffset('idle');
				addOffset("singUP", 69, -30);
				addOffset("singRIGHT", 10, -36);
				addOffset("singLEFT", -90, -10);
				addOffset("singDOWN", 80, 100);
				addOffset("cutscene", 0, -10);
				addOffset('singFUCK', -218, -98);

				setGraphicSize(Std.int(width * furiosityScale), Std.int(height * furiosityScale));
				updateHitbox();
				antialiasing = false;

				iconName = 'bandu-origin';

				iconRPC = 'icon_bandu';

				playAnim('idle');

			case 'RECOVERED_PROJECT':
				tex = Paths.getSparrowAtlas('characters/RECOVERED_PROJECT_01');
				frames = tex;
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				setGraphicSize(Std.int(width * furiosityScale), Std.int(height * furiosityScale));
				updateHitbox();
				antialiasing = false;

				playAnim('idle');

				iconName = 'recovered';

				iconRPC = 'icon_recovered';

			case 'corrupt-file':
				tex = Paths.getSparrowAtlas('characters/corrupted_file');
				frames = tex;
				animation.addByPrefix('idle', 'IDLE', 24, false);
				animation.addByPrefix('singUP', 'UP', 24, false);
				animation.addByPrefix('singRIGHT', 'RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'LEFT', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				setGraphicSize(Std.int(width * furiosityScale), Std.int(height * furiosityScale));
				updateHitbox();
				antialiasing = false;

				playAnim('idle');

				iconName = 'corrupt';

				iconRPC = 'icon_corrupt';

			case 'dale':
				tex = Paths.getSparrowAtlas('characters/dale');
				frames = tex;
				animation.addByPrefix('idle', 'IDLE', 24, false);
				animation.addByPrefix('singUP', 'UP', 24, false);
				animation.addByPrefix('singRIGHT', 'RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'LEFT', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				setGraphicSize(Std.int(width * furiosityScale), Std.int(height * furiosityScale));
				updateHitbox();
				antialiasing = false;

				playAnim('idle');

				iconName = 'dale';

				iconRPC = 'icon_dale';

			case 'dingle':
				tex = Paths.getSparrowAtlas('characters/dingle');
				frames = tex;
				animation.addByPrefix('idle', 'IDLE'.toLowerCase(), 24, false);
				animation.addByPrefix('singUP', 'UP'.toLowerCase(), 24, false);
				animation.addByPrefix('singRIGHT', 'RIGHT'.toLowerCase(), 24, false);
				animation.addByPrefix('singDOWN', 'DOWN'.toLowerCase(), 24, false);
				animation.addByPrefix('singLEFT', 'LEFT'.toLowerCase(), 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				setGraphicSize(Std.int(width * furiosityScale), Std.int(height * furiosityScale));
				updateHitbox();
				antialiasing = false;

				playAnim('idle');

				iconName = 'dingle';

				iconRPC = 'icon_dingle';

			case 'donk':
				tex = Paths.getSparrowAtlas('characters/donk');
				frames = tex;
				animation.addByPrefix('idle', 'IDLE'.toLowerCase(), 24, false);
				animation.addByPrefix('singUP-alt', 'UP'.toLowerCase(), 24, false);
				animation.addByPrefix('singRIGHT-alt', 'RIGHT'.toLowerCase(), 24, false);
				animation.addByPrefix('singDOWN-alt', 'DOWN'.toLowerCase(), 24, false);
				animation.addByPrefix('singLEFT-alt', 'LEFT'.toLowerCase(), 24, false);

				addOffset('idle');
				addOffset("singUP-alt");
				addOffset("singRIGHT-alt");
				addOffset("singLEFT-alt");
				addOffset("singDOWN-alt");
				setGraphicSize(Std.int(width * furiosityScale), Std.int(height * furiosityScale));
				updateHitbox();
				antialiasing = false;

				playAnim('idle');

				iconName = 'donk';

				iconRPC = 'icon_donk';

			case 'cell':
				tex = Paths.getSparrowAtlas('characters/Cell');
				frames = tex;
				animation.addByPrefix('idle', 'Idle', 24, false);
				animation.addByPrefix('singUP', 'Up', 24, false);
				animation.addByPrefix('singRIGHT', 'Right', 24, false);
				animation.addByPrefix('singDOWN', 'Down', 24, false);
				animation.addByPrefix('singLEFT', 'Left', 24, false);

				addOffset('idle');
				addOffset("singUP", 0, 160);
				addOffset("singRIGHT", -70, -70);
				addOffset("singLEFT", 249, 19);
				addOffset("singDOWN", 41, -60);

				antialiasing = false;

				playAnim('idle');

				iconName = 'cell';

				iconRPC = 'icon_cell';

			case 'cell-mad':
				tex = Paths.getSparrowAtlas('characters/CellMad');
				frames = tex;
				animation.addByPrefix('idle', 'Idle', 24, false);
				animation.addByPrefix('singUP', 'Up', 24, false);
				animation.addByPrefix('singRIGHT', 'Right', 24, false);
				animation.addByPrefix('singDOWN', 'Down', 24, false);
				animation.addByPrefix('singLEFT', 'Left', 24, false);

				addOffset('idle');
				addOffset("singUP", 210, 150);
				addOffset("singRIGHT", 200, -110);
				addOffset("singLEFT", 420, -40);
				addOffset("singDOWN", 410, -390);

				antialiasing = false;

				playAnim('idle');

				iconName = 'cellangry';

				iconRPC = 'icon_cell';

			case 'froing':
				tex = Paths.getSparrowAtlas('characters/froing');
				frames = tex;
				animation.addByPrefix('idle', 'IDLE'.toLowerCase(), 24, false);
				animation.addByPrefix('singUP', 'UP'.toLowerCase(), 24, false);
				animation.addByPrefix('singRIGHT', 'RIGHT'.toLowerCase(), 24, false);
				animation.addByPrefix('singDOWN', 'DOWN'.toLowerCase(), 24, false);
				animation.addByPrefix('singLEFT', 'LEFT'.toLowerCase(), 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				setGraphicSize(Std.int(width * furiosityScale), Std.int(height * furiosityScale));
				updateHitbox();
				antialiasing = false;

				flipX = !flipX;

				nativelyPlayable = true;

				playAnim('idle');

				iconName = 'froing';

			case 'cheat-bamb':
				tex = Paths.getSparrowAtlas('characters/bambianim8or');
				frames = tex;
				animation.addByPrefix('idle', 'IDLE', 24, false);
				animation.addByPrefix('singUP', 'UP', 24, false);
				animation.addByPrefix('singRIGHT', 'RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'LEFT', 24, false);

				addOffset('idle');
				addOffset("singUP", -26, 84);
				addOffset("singRIGHT", -10, 240);
				addOffset("singLEFT", 60, 84);
				addOffset("singDOWN", -26, -24);

				setGraphicSize(Std.int(width * furiosityScale), Std.int(height * furiosityScale));
				updateHitbox();
				antialiasing = false;

				playAnim('idle');

				iconName = 'cheaty';

				iconRPC = 'icon_cheaty';

			case 'cheat-bamb-ang':
				tex = Paths.getSparrowAtlas('characters/bambiAngyAnim8or');
				frames = tex;
				animation.addByPrefix('idle', 'IDLE', 24, false);
				animation.addByPrefix('singUP', 'UP', 24, false);
				animation.addByPrefix('singRIGHT', 'RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'LEFT', 24, false);

				addOffset('idle');
				addOffset("singUP", 8, 55);
				addOffset("singRIGHT", 23, -4);
				addOffset("singLEFT", 2, 3);
				addOffset("singDOWN", 15, 30);

				setGraphicSize(Std.int(width * furiosityScale), Std.int(height * furiosityScale));
				updateHitbox();
				antialiasing = false;

				playAnim('idle');

				iconName = 'cheaty';

				iconRPC = 'icon_cheaty';

			case 'butch':
				tex = Paths.getSparrowAtlas('characters/butchatrix');
				frames = tex;
				animation.addByPrefix('idle', 'IDLE', 24, false);
				animation.addByPrefix('singUP', 'UP', 24, false);
				animation.addByPrefix('singRIGHT', 'RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'LEFT', 24, false);

				addOffset('idle');
				addOffset("singUP", 163, 230);
				addOffset("singRIGHT", 107, 229);
				addOffset("singLEFT", 210, -225);
				addOffset("singDOWN", 1, -673);
				setGraphicSize(Std.int(width * furiosityScale), Std.int(height * furiosityScale));
				updateHitbox();
				antialiasing = false;

				playAnim('idle');

				iconName = 'butch';

				iconRPC = 'icon_butch';

			case 'alge':
				tex = Paths.getSparrowAtlas('characters/algebraicaitrix');
				frames = tex;
				animation.addByPrefix('idle', 'IDLE', 24, false);
				animation.addByPrefix('singUP', 'UP', 24, false);
				animation.addByPrefix('singRIGHT', 'RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'LEFT', 24, false);
				animation.addByPrefix('boo', 'BOO', 24, false);
				animation.addByPrefix('hah', 'HAH', 24, false);

				addOffset('idle');
				addOffset("singUP", 100, 294);
				addOffset("singRIGHT", 13, -136);
				addOffset("singLEFT", 282, -109);
				addOffset("singDOWN", -5, -39);
				addOffset("boo", -37, -126);
				addOffset("hah", 38, 24);
				setGraphicSize(Std.int(width * furiosityScale), Std.int(height * furiosityScale));
				updateHitbox();
				antialiasing = false;

				playAnim('idle');

				iconName = 'alge';

				iconRPC = 'icon_alge';

			case 'bad':
				tex = Paths.getSparrowAtlas('characters/badtrix');
				frames = tex;
				animation.addByPrefix('idle', 'IDLE', 24, false);
				animation.addByPrefix('singUP', 'UP', 24, false);
				animation.addByPrefix('singRIGHT', 'RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'LEFT', 24, false);

				addOffset('idle');
				addOffset("singUP", 439, 262);
				addOffset("singRIGHT", 220, 450);
				addOffset("singLEFT", 671, 111);
				addOffset("singDOWN", 130, 81);
				setGraphicSize(Std.int(width * furiosityScale), Std.int(height * furiosityScale));
				updateHitbox();
				antialiasing = false;

				playAnim('idle');

				iconName = 'bad';

				iconRPC = 'icon_bad';

			case 'RECOVERED_PROJECT_2':
				tex = Paths.getSparrowAtlas('characters/recovered_project_2');
				frames = tex;
				animation.addByPrefix('idle', 'IDLE', 24, true);
				animation.addByPrefix('singUP', 'UP', 24, false);
				animation.addByPrefix('singRIGHT', 'RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'LEFT', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				setGraphicSize(Std.int(765 * furiosityScale), Std.int(903 * furiosityScale));
				updateHitbox();
				antialiasing = false;

				playAnim('idle');

				iconName = 'gunk';

				iconRPC = 'icon_gunk';

			case 'RECOVERED_PROJECT_3':
				tex = Paths.getSparrowAtlas('characters/recovered_project_3');
				frames = tex;
				animation.addByPrefix('idle', 'IDLE', 24, false);
				animation.addByPrefix('singUP', 'UP', 24, false);
				animation.addByPrefix('singRIGHT', 'RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'LEFT', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				setGraphicSize(Std.int(765 * furiosityScale), Std.int(903 * furiosityScale));
				updateHitbox();
				antialiasing = false;

				playAnim('idle');

				iconName = 'gross';

				iconRPC = 'icon_gross';

			case 'badai':
				// BADAI SHITE ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/badai');
				frames = tex;
				animation.addByPrefix('idle', 'IDLE', 24, false);
				animation.addByPrefix('singUP', 'UP', 24, false);
				animation.addByPrefix('singRIGHT', 'RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'LEFT', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				setGraphicSize(Std.int(width * furiosityScale), Std.int(height * furiosityScale));
				updateHitbox();
				antialiasing = false;

				playAnim('idle');

				iconName = 'badai';

				iconRPC = 'icon_badai';

			case 'batai':
				// BADAI SHITE ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/batai');
				frames = tex;
				animation.addByPrefix('idle', 'IDLE', 24, false);
				animation.addByPrefix('singUP', 'UP', 24, false);
				animation.addByPrefix('singRIGHT', 'RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'LEFT', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				setGraphicSize(Std.int(width * furiosityScale), Std.int(height * furiosityScale));
				updateHitbox();
				antialiasing = false;

				playAnim('idle');

				iconName = 'badai';

				iconRPC = 'icon_badai';

			case 'tunnel-dave':
				// DAVE SHITE ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/tunnel_chase_dave');
				frames = tex;
				animation.addByPrefix('idle', 'IDLE', 24, false);
				animation.addByPrefix('singUP', 'UP', 24, false);
				animation.addByPrefix('singRIGHT', 'RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'LEFT', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				setGraphicSize(Std.int(width * furiosityScale), Std.int(height * furiosityScale));
				updateHitbox();
				antialiasing = false;

				playAnim('idle');

				iconName = 'decdave';

				iconRPC = 'icon_tunnel_dave';

			case 'robot-guy':
				// DAVE SHITE ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/robot_guy');
				frames = tex;
				animation.addByPrefix('idle', 'IDLE', 24, false);
				animation.addByPrefix('singUP', 'UP', 24, false);
				animation.addByPrefix('singRIGHT', 'RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'LEFT', 24, false);
				animation.addByPrefix('splode', 'SPLODE', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				addOffset("splode");

				setGraphicSize(Std.int(width * furiosityScale), Std.int(height * furiosityScale));
				updateHitbox();
				antialiasing = false;

				playAnim('idle');

				iconName = 'decdave';

				iconRPC = 'icon_tunnel_dave';

			case 'og-dave':
				// DAVE SHITE ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/og_dave');
				frames = tex;
				animation.addByPrefix('idle', 'IDLE', 24, false);
				animation.addByPrefix('singUP', 'UP', 24, false);
				animation.addByPrefix('singRIGHT', 'RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'LEFT', 24, false);
				animation.addByPrefix('stand', 'STAND', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN", -82, -24);
				addOffset("stand", -87, -29);

				setGraphicSize(Std.int(width * furiosityScale), Std.int(height * furiosityScale));
				updateHitbox();
				antialiasing = false;

				playAnim('idle');

				iconName = 'og-dave';

				iconRPC = 'icon_og_dave';

			case 'og-dave-angey':
				// DAVE SHITE ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/og_dave_angey');
				frames = tex;
				animation.addByPrefix('idle', 'IDLE', 24, false);
				animation.addByPrefix('singUP', 'UP', 24, false);
				animation.addByPrefix('singRIGHT', 'RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'LEFT', 24, false);
				animation.addByPrefix('stand', 'STAND', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				addOffset("stand", -156, -45);

				setGraphicSize(Std.int(width * furiosityScale), Std.int(height * furiosityScale));
				updateHitbox();
				antialiasing = false;

				playAnim('idle');

				iconName = 'og-dave';

				iconRPC = 'icon_og_dave';

			case 'garrett':
				// GARRETT SHITE ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/garrett_algebra');
				frames = tex;
				animation.addByPrefix('idle', 'IDLE', 24, false);
				animation.addByPrefix('singUP', 'UP', 24, false);
				animation.addByPrefix('singRIGHT', 'RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'LEFT', 24, false);
				animation.addByPrefix('stand', 'STAND', 24, false);
				animation.addByPrefix('scared', 'SHOCKED', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT", -45, 3);
				addOffset("singLEFT");
				addOffset("singDOWN", -48, -46);
				addOffset("stand", 20);
				addOffset("scared");

				furiosityScale = 1.3;

				setGraphicSize(Std.int(width * furiosityScale), Std.int(height * furiosityScale));
				updateHitbox();
				antialiasing = false;

				playAnim('idle');

				iconName = 'garrett';

				iconRPC = 'icon_garrett';

			case 'bambi-piss-3d':
				var thing:Int = 1;
				// BAMBI SHITE ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/bambi_pissyboy');
				frames = tex;
				animation.addByIndices('danceLeft', 'idle', [for (i in 0...13) i], "", 24, false);
				animation.addByIndices('danceRight', 'idle', [for (i in 13...23) i], "", 24, false);
				for (anim in ['left', 'down', 'up', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
				}

				if (isPlayer)
					thing = -1;

				addOffset('danceLeft');
				addOffset('danceRight');
				addOffset("singUP", 10 * thing, 20 * thing);
				addOffset("singRIGHT", 30 * thing, 20 * thing);
				addOffset("singLEFT", 30 * thing);
				addOffset("singDOWN", 0, -10 * thing);
				globaloffset[0] = 150;
				globaloffset[1] = 450; // this is the y
				setGraphicSize(Std.int(width / furiosityScale));
				updateHitbox();
				antialiasing = false;

				iconName = 'disrupt';

				iconRPC = 'icon_bambi_piss_3d';

				playAnim('danceRight');

			case 'boxer':
				// BAMBI SHITE ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/boxer');
				frames = tex;

				animation.addByPrefix('idle', 'IDLE', 24, false);

				for (anim in ['LEFT', 'DOWN', 'UP', 'RIGHT'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
				}

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");

				furiosityScale = 1.75;

				setGraphicSize(Std.int(width * furiosityScale), Std.int(height * furiosityScale));
				updateHitbox();

				antialiasing = false;

				iconName = 'disrupt';

				iconRPC = 'icon_piss_bambi_3d';

				playAnim('idle');

			case 'gotta-sleep':
				// BAMBI SHITE ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/gotta_sleep');
				frames = tex;

				animation.addByPrefix('idle', 'IDLE', 24, false);

				for (anim in ['LEFT', 'DOWN', 'UP', 'RIGHT'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
				}

				addOffset('idle');
				addOffset("singUP", -33, 94);
				addOffset("singRIGHT", 150, 100);
				addOffset("singLEFT", 80, 30);
				addOffset("singDOWN", 87, -60);

				setGraphicSize(Std.int(width * furiosityScale), Std.int(height * furiosityScale));
				updateHitbox();

				antialiasing = false;

				iconName = 'gotta';

				iconRPC = 'icon_gotta';

				playAnim('idle');

			case 'bandu':
				frames = Paths.getSparrowAtlas('characters/bandu');

				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);

				animation.addByIndices('idle-alt', 'phones fall', [17], '', 24, false);
				animation.addByPrefix('singUP-alt', 'sad up', 24, false);
				animation.addByPrefix('singRIGHT-alt', 'sad right', 24, false);
				animation.addByPrefix('singDOWN-alt', 'sad down', 24, false);
				animation.addByPrefix('singLEFT-alt', 'sad left', 24, false);

				animation.addByIndices('NOOMYPHONES', 'phones fall', [0, 2, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 17], '', 24, false);

				for (z in ['idle', 'singUP', 'singRIGHT', 'singLEFT', 'singDOWN', 'NOOMYPHNOES'])
				{
					addOffset(z, 0, 350 * 0.85);
					addOffset('$z-alt', 0, 350 * 0.85);
				}

				globaloffset[0] = 150;
				globaloffset[1] = 450;

				scale.set(0.85, 0.85);
				updateHitbox();

				antialiasing = false;

				iconName = 'bandu';

				iconRPC = 'icon_bandu';

				playAnim('idle');
			case 'bandu-sad':
				tex = StolenFromTrickyMod.cachedInstance.fromSparrow('bandusad', 'characters/bandu_sad');

				frames = tex;

				animation.addByPrefix('idle', 'phones fall', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);

				animation.addByIndices('idle-alt', 'phones fall', [17], '', 24, false);
				animation.addByPrefix('singUP-alt', 'sad up', 24, false);
				animation.addByPrefix('singRIGHT-alt', 'sad right', 24, false);
				animation.addByPrefix('singDOWN-alt', 'sad down', 24, false);
				animation.addByPrefix('singLEFT-alt', 'sad left', 24, false);

				animation.addByIndices('NOOMYPHONES', 'phones fall', [0, 2, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 17], '', 24, false);

				for (z in ['idle', 'singUP', 'singRIGHT', 'singLEFT', 'singDOWN', 'NOOMYPHNOES'])
				{
					addOffset(z, 0, 350 * 0.8);
					addOffset('$z-alt', 0, 350 * 0.8);
				}

				globaloffset[0] = 150;
				globaloffset[1] = 450;

				scale.set(0.8, 0.8);
				updateHitbox();

				antialiasing = false;

				iconName = 'bandu';

				iconRPC = 'icon_bandu';

				playAnim('idle');
			case 'bandu-lullaby':
				frames = Paths.getSparrowAtlas('characters/lullabandu');

				animation.addByPrefix('idle', 'IDLE', 24, false);
				animation.addByPrefix('singUP', 'UP', 24, false);
				animation.addByPrefix('singRIGHT', 'RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'LEFT', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");

				setGraphicSize(Std.int(width / furiosityScale));
				updateHitbox();

				antialiasing = false;

				flipX = true;
				nativelyPlayable = true;

				iconName = 'lullabandu';

				iconRPC = 'icon_bandu';

				playAnim('idle');
			case 'dave-unchecked':
				frames = Paths.getSparrowAtlas('characters/decimated_lullaby');

				animation.addByPrefix('idle', 'IDLE', 24, true);
				animation.addByPrefix('singUP', 'UP', 24, false);
				animation.addByPrefix('singRIGHT', 'RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'LEFT', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");

				scale.set(1.25, 1.25);
				updateHitbox();

				antialiasing = false;

				iconName = 'dave-unchecked';

				iconRPC = 'icon_tunnel_dave';

				playAnim('idle');
			case 'shoulder-3d-bf':
				frames = Paths.getSparrowAtlas('characters/shoulder_3d_bf');

				animation.addByPrefix('idle', 'IDLE', 24, false);
				animation.addByPrefix('singUP', 'UP', 24, false);
				animation.addByPrefix('singRIGHT', 'RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'LEFT', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");

				flipX = !flipX;
				nativelyPlayable = true;

				setGraphicSize(Std.int(width / furiosityScale));
				updateHitbox();

				scale.set(1.1, 1.1);
				updateHitbox();

				antialiasing = false;

				iconName = '3d-bf';

				playAnim('idle');
			case 'bandu-candy':
				frames = Paths.getSparrowAtlas('characters/bandu_crazy');

				animation.addByIndices('danceLeft', 'IDLE', [0, 1, 2, 3, 4, 5], '', 24, false);
				animation.addByIndices('danceRight', 'IDLE', [9, 8, 7, 6, 5, 4], '', 24, false);
				animation.addByPrefix('singUP', 'UP', 24, false);
				animation.addByPrefix('singRIGHT', 'RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'LEFT', 24, false);
				animation.addByPrefix('singUP-alt', 'ALT-UP', 24, false);
				animation.addByPrefix('singRIGHT-alt', 'ALT-RIGHT', 24, false);
				animation.addByPrefix('singDOWN-alt', 'ALT-DOWN', 24, false);
				animation.addByPrefix('singLEFT-alt', 'ALT-LEFT', 24, false);

				addOffset('danceLeft');
				addOffset('danceRight');
				addOffset("singUP");
				addOffset("singRIGHT", 120);
				addOffset("singLEFT", -63);
				addOffset("singDOWN");
				addOffset("singUP-alt");
				addOffset("singRIGHT-alt");
				addOffset("singLEFT-alt");
				addOffset("singDOWN-alt");

				setGraphicSize(Std.int(width / furiosityScale));
				updateHitbox();

				antialiasing = false;

				iconName = 'bandu';

				iconRPC = 'icon_bandu';

				playAnim('danceLeft');
			case 'ticking':
				frames = Paths.getSparrowAtlas('characters/ticking_dude');

				animation.addByPrefix('idle', 'IDLE'.toLowerCase(), 24, false);
				animation.addByPrefix('singUP', 'UP'.toLowerCase(), 24, false);
				animation.addByPrefix('singRIGHT', 'RIGHT'.toLowerCase(), 24, false);
				animation.addByPrefix('singDOWN', 'DOWN'.toLowerCase(), 24, false);
				animation.addByPrefix('singLEFT', 'LEFT'.toLowerCase(), 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");

				setGraphicSize(Std.int(width / furiosityScale));
				updateHitbox();

				antialiasing = false;

				iconName = 'ouch';

				iconRPC = 'icon_ouch';

				playAnim('idle');
			case 'bambi-good':
				frames = Paths.getSparrowAtlas('characters/bambiShip');
				animation.addByPrefix('idle', 'IDLE', 24, false);
				animation.addByPrefix('singDOWN', 'DOWN', 24, false);
				animation.addByPrefix('singUP', 'UP', 24, false);
				animation.addByPrefix('singLEFT', 'LEFT', 24, false);
				animation.addByPrefix('singRIGHT', 'RIGHT', 24, false);
				animation.addByPrefix('talk', 'TALK', 24, false);
				animation.addByPrefix('holyshit', 'HOLYSHIT', 24, false);
				animation.addByPrefix('singSmash', 'SMASH', 24, false);

				addOffset('idle');
				addOffset("singUP", -10, 10);
				addOffset("singRIGHT", 6);
				addOffset("singLEFT", -4, -2);
				addOffset("singDOWN", 16, -6);
				addOffset("talk", -5, 15);
				addOffset("holyshit", 0, 7);
				addOffset("singSmash", 20);

				playAnim('idle');

				iconName = 'bambi-ship';

				iconRPC = 'icon_super';
			case 'dave-good':
				tex = Paths.getSparrowAtlas('characters/daveShip');
				frames = tex;
				animation.addByPrefix('idle', 'IDLE', 24, false);
				animation.addByPrefix('singUP', 'UP', 24, false);
				animation.addByPrefix('singRIGHT', 'RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'LEFT', 24, false);
				animation.addByPrefix('talk', 'TALK', 24, false);

				addOffset('idle');
				addOffset("singUP", 64, 10);
				addOffset("singRIGHT", 1, -2);
				addOffset("singLEFT", -8, -7);
				addOffset("singDOWN", 9, -5);
				addOffset("talk", 0, 6);

				playAnim('idle');

				flipX = true;
				nativelyPlayable = true;

				iconName = 'dave-ship';

				iconRPC = 'icon_dave';

			case 'dave-wide':
				tex = Paths.getSparrowAtlas('characters/daveShip');
				frames = tex;
				animation.addByPrefix('idle', 'IDLE', 24, false);
				animation.addByPrefix('singUP', 'UP', 24, false);
				animation.addByPrefix('singLEFT', 'RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'DOWN', 24, false);
				animation.addByPrefix('singRIGHT', 'LEFT', 24, false);
				animation.addByPrefix('talk', 'TALK', 24, false);

				scale.set(1.5, 1);
				updateHitbox();

				addOffset('idle');
				addOffset("singUP", (64 * 1.5) * -1, 10);
				addOffset("singLEFT", (1 * 1.5) * -1, -2);
				addOffset("singRIGHT", (-8 * 1.5) * -1, -7);
				addOffset("singDOWN", (9 * 1.5) * -1, -5);
				addOffset("talk", 0, 6);

				playAnim('idle');

				flipX = true;

				iconName = 'dave';

				iconRPC = 'icon_dave';
			case 'unfair-junker':
				frames = Paths.getSparrowAtlas('characters/UNFAIR_GUY_FAICNG_FORWARD');
				animation.addByPrefix('idle', 'idle', 48, false);
				for (anim in ['left', 'down', 'up', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim, 48, false);
				}
				animation.addByIndices('inhale', 'INHALE', [
					0, 1, 2, 3, 4, 0, 1, 2, 3, 4, 0, 1, 2, 3, 4, 0, 1, 2, 3, 4, 0, 1, 2, 3, 4, 0, 1, 2, 3, 4, 0, 1, 2, 3, 4, 0, 1, 2, 3, 4
				], '', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				addOffset('inhale');
				globaloffset[0] = 150 * 0.85;
				globaloffset[1] = 450 * 0.85; // this is the y
				setGraphicSize(Std.int((width * 0.85) / furiosityScale));
				updateHitbox();
				antialiasing = false;

				iconName = 'unfair';

				iconRPC = 'icon_unfair_junker';

				playAnim('idle');
			case 'bf':
				var tex = Paths.getSparrowAtlas('characters/BOYFRIEND');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, false);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);
				animation.addByPrefix('dodge', "boyfriend dodge", 24, false);
				animation.addByPrefix('scared', 'BF idle shaking', 24);
				animation.addByPrefix('hit', 'BF hit', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);

				playAnim('idle');

				nativelyPlayable = true;

				flipX = true;

				iconName = 'bf';

			case 'cynda':
				var tex = Paths.getSparrowAtlas('characters/cyna');
				frames = tex;
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);

				addOffset('idle');
				addOffset("singUP", 120, 130);
				addOffset("singRIGHT", 6, 5);
				addOffset("singLEFT", 50, 10);
				addOffset("singDOWN", 119, -162);

				playAnim('idle');

				iconName = 'cynda';

			case 'underscore':
				var tex = Paths.getSparrowAtlas('characters/underscore');
				frames = tex;
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);

				addOffset('idle');
				addOffset("singUP", 17, 1);
				addOffset("singRIGHT", -30, -12);
				addOffset("singLEFT", 12, 10);
				addOffset("singDOWN", -25, -16);

				playAnim('idle');

				nativelyPlayable = true;

				flipX = true;

				iconName = 'underscore';

			case 'tunnel-bf':
				var tex = Paths.getSparrowAtlas('characters/tunnel_bf');
				frames = tex;

				animation.addByPrefix('idle', 'IDLE', 24, false);
				animation.addByPrefix('singUP', 'UP', 24, false);
				animation.addByPrefix('singLEFT', 'LEFT', 24, false);
				animation.addByPrefix('singRIGHT', 'RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'DOWN', 24, false);
				animation.addByPrefix('turn', 'TURN', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT", 57);
				addOffset("singDOWN");
				addOffset('turn');

				playAnim('idle');

				flipX = true;

				nativelyPlayable = true;

				iconName = 'bf';
		}
		dance();

		if (isPlayer)
		{
			flipX = !flipX;
		}
	}

	public function addAnim(name:String, xmlName:String, framerate:Int = 24, loop:Bool = false)
	{
		animation.addByPrefix(name, xmlName, framerate, loop);
	}

	public var POOP:Bool = false; // https://cdn.discordapp.com/attachments/902006463654936587/906412566534848542/video0-14.mov

	override function update(elapsed:Float)
	{
		if (animation == null)
		{
			super.update(elapsed);
			return;
		}
		else if (animation.curAnim == null)
		{
			super.update(elapsed);
			return;
		}
		if (!nativelyPlayable && !isPlayer)
		{
			if (animation.curAnim.name.startsWith('sing'))
			{
				holdTimer += elapsed;
			}

			var dadVar:Float = 4;

			if (curCharacter == 'dad' || curCharacter == 'diamond-man-mugen')
				dadVar = 6.1;
			if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001)
			{
				dance(POOP);
				holdTimer = 0;
				if (PlayState.instance != null && PlayState.instance.sonicAllAmericanHotdogCombo)
					PlayState.instance.doThatOneJunk();
			}
		}

		switch (curCharacter)
		{
			case 'gf':
				if (animation.curAnim.name == 'hairFall' && animation.curAnim.finished)
					playAnim('danceRight');
		}

		super.update(elapsed);
	}

	private var danced:Bool = false;

	/**
	 * FOR DANCING SHIT
	 */
	public function dance(alt:Bool = false)
	{
		curCamOffsetX = 0;
		curCamOffsetY = 0;
		var poopInPants:String = alt ? '-alt' : '';
		if (curCharacter == 'crazed' && alt)
		{
			poopInPants = '-alt';
		}
		if (!debugMode && canDance)
		{
			switch (curCharacter)
			{
				case 'gf' | 'gf-christmas' | 'gf-pixel' | 'gf-pixel-white' | 'bandu-candy' | 'bambi-piss-3d' | 'gf-only' | 'dave-wheels' | 'david' |
					'future-dave' | 'garrett-animal' | 'playtime-2' | 'garrett-piss' | 'playrobot' | 'playrobot-crazy' | 'bamb-root' | 'wtf-lmao':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight' + poopInPants, true);
						else
							playAnim('danceLeft' + poopInPants, true);
					}
				default:
					playAnim('idle' + poopInPants, true);
			}
		}
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		if (animation.getByName(AnimName) == null)
		{
			// WHY THE FUCK WAS THIS TRACE HERE
			// trace(AnimName);
			return; // why wasn't this a thing in the first place
		}
		if (AnimName.toLowerCase().startsWith('idle') && !canDance)
		{
			return;
		}

		if (AnimName.toLowerCase().startsWith('sing') && !canSing)
		{
			return;
		};

		if (curCharacter != 'bandu' && curCharacter != '144p' && curCharacter != 'gotta-sleep')
		{
			if (/*(isPlayer && !nativelyPlayable) || */ (nativelyPlayable && !isPlayer))
			{
				switch (AnimName)
				{
					case 'singRIGHT' | 'singRIGHT-alt' | 'singRIGHT-hold':
						curCamOffsetX = -25;
						curCamOffsetY = 0;
					case 'singLEFT' | 'singLEFT-alt' | 'scream' | 'singLEFT-hold':
						curCamOffsetX = 25;
						curCamOffsetY = 0;
					case 'singUP' | 'singUP-alt' | 'singUP-hold':
						curCamOffsetY = -25;
						curCamOffsetX = 0;
					case 'singDOWN' | 'singDOWN-alt' | 'singSmash' | 'singDOWN-hold':
						curCamOffsetY = 25;
						curCamOffsetX = 0;
					default:
						curCamOffsetX = 0;
						curCamOffsetY = 0;
				}
			}
			else
			{
				switch (AnimName)
				{
					case 'singLEFT' | 'singLEFT-alt' | 'singLEFT-hold':
						curCamOffsetX = -25;
						curCamOffsetY = 0;
					case 'singRIGHT' | 'singRIGHT-alt' | 'scream' | 'singRIGHT-hold':
						curCamOffsetX = 25;
						curCamOffsetY = 0;
					case 'singUP' | 'singUP-alt' | 'singUP-hold':
						curCamOffsetY = -25;
						curCamOffsetX = 0;
					case 'singDOWN' | 'singDOWN-alt' | 'singSmash' | 'singDOWN-hold':
						curCamOffsetY = 25;
						curCamOffsetX = 0;
					default:
						curCamOffsetX = 0;
						curCamOffsetY = 0;
				}
			}
		}

		animation.play(AnimName, Force, Reversed, Frame);

		var daOffset = animOffsets.get(AnimName);
		if (animOffsets.exists(AnimName))
		{
			if (isPlayer)
			{
				offset.set((daOffset[0] + globaloffset[0]) * offsetScale, (daOffset[1] + globaloffset[1]) * offsetScale);
			}
			else
			{
				offset.set(daOffset[0] * offsetScale, daOffset[1] * offsetScale);
			}
		}
		else
			offset.set(0, 0);

		if (curCharacter == 'gf')
		{
			if (AnimName == 'singLEFT')
			{
				danced = true;
			}
			else if (AnimName == 'singRIGHT')
			{
				danced = false;
			}

			if (AnimName == 'singUP' || AnimName == 'singDOWN')
			{
				danced = !danced;
			}
		}
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		/*var multiplier:Float = 1;
			if((!isPlayer && nativelyPlayable) || (isPlayer && !nativelyPlayable))
			{
				multiplier = -1;
		}*/
		animOffsets[name] = [x /* * multiplier*/, y];
	}
}
