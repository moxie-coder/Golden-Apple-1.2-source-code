package;

import flixel.FlxSprite;
import flixel.math.FlxMath;

class HealthIcon extends FlxSprite
{
	/**
	 * Used for FreeplayState! If you use it elsewhere, prob gonna annoying
	 */
	public var sprTracker:FlxSprite;

	public var isPlayer:Bool = false;

	
	//LIST ICON NAME HERE NOT CHARACTER
	public var noAaChars:Array<String> = [
		'unfair',
		'disrupt',
		'bandu',
		'junkers',
		'decdave',
		'disability',
		'og-dave',
		'garrett',
		'badai',
		'3d-bf',
		'recovered',
		'bandu-origin',
		'sart-producer',
		'bambom',
		'ringi',
		'bendu',
		'wheels',
		'gary',
		'alge',
		'bad',
		'butch',
		'dale',
		'dingle',
		'epic',
		'brob',
		'barbu',
		'david',
		'garrett-animal',
		'playtime-2',
		'paloose-men',
		'wizard',
		'do-you-accept',
		'mr-music',
		'epic',
		'froing',
		'action',
		'future',
		'smartass',
		'doll',
		'testicles',
		'gunk',
		'gross',
		'bf-pixel',
		'gotta',
		'awesomePlayer',
		'awesomeEnemy',
		'do-you-accept-player',
		'bambroot',
		'shitter',
		'jambi',
		'dave-unchecked',
		'cheaty',
		'cell',
		'cellangry',
		'lullabandu',
		'ouch',
		'corrupt',
		'blogblez',
		'bormp',
		'sus',
		'longbrob',
		'zambi',
		'awesome-son',
		'badrum',
		'3d-tristan',
		'bambop',
		'sammy',
		'leak-gf',
		'leak-wtf',
		'leak-ringonal',
		'leak-encrypted',
		'bweasal',
		'sillycon-min-removebg-preview',
		'peashooter',
		'dambai',
		'dambu',
		'donk',
		'dingle-donk-duo',
		'bf-pixel-white',
		'chipper'
	];

	public var charPublic:String = 'bf';

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();

		this.isPlayer = isPlayer;

		changeIcon(char);

		scrollFactor.set();
	}

	function addIcon(char:String, startFrame:Int, singleIcon:Bool = false, flipOpposite:Bool = false)
	{
		var flip:Bool = isPlayer;
		if(flipOpposite){flip = !flip;};
		animation.add(char, !singleIcon ? [startFrame, startFrame + 1] : [startFrame], 0, false, flip);
	}

	function addAwesomeIcon(char:String, startFrame:Int, singleIcon:Bool = false, flipOpposite:Bool = false)
	{
		var flip:Bool = isPlayer;
		if(flipOpposite){flip = !flip;};
		if(char == 'awesomePlayer')
		{
			animation.add(char, [5, 1, 3], 0, false, !isPlayer);
		}
		else
		{
			animation.add(char, [4, 0, 2], 0, false, isPlayer);
		}
	}

	public function changeIcon(char:String = 'face')
	{
		charPublic = char;

		if(char == 'awesomePlayer' || char == 'awesomeEnemy')
		{
			loadGraphic(Paths.image('icons/top-ten-awesome'), true, 150, 150);
			addAwesomeIcon(char, 0, false, false);
		}
		else if(char != 'bandu-origin' && char != 'ohungi' && char != 'dave-unchecked')
		{
			loadGraphic(Paths.image('icons/' + char), true, 150, 150);

			if(char == 'dale' || char == 'dingle' || char == 'froing' || char == 'testicles' || char == 'epic' || char == 'lullabandu' || char == 'do-you-accept-player')
			{
				addIcon(char, 0, false, true);
			}
			else
			{
				addIcon(char, 0);
			}
		}
		else if(char == 'bandu-origin')
		{
			frames = Paths.getSparrowAtlas('icons/bandu_origin_icon');
			animation.addByPrefix(char, char, 24, false, isPlayer, false);
		}
		else
		{
			frames = Paths.getSparrowAtlas('icons/unchecked_icon');
			animation.addByPrefix(char, char, 24, true, isPlayer, false);
		}

		antialiasing = !noAaChars.contains(char);

		if(char == 'ohungi')
		{
			animation.play('good');
		}
		else
		{
			animation.play(char);
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		var xOffsetPenis:Float = 0;
		var yOffsetPenis:Float = 0;

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);

		offset.set(Std.int(FlxMath.bound(width - (150 * scale.x),0)) + xOffsetPenis,Std.int(FlxMath.bound(height - (150 * scale.y),0)) + yOffsetPenis);
	}
}
