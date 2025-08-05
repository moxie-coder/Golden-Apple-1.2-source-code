package;

import flixel.math.FlxRandom;
import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
#if polymod
import polymod.format.ParseRules.TargetSignatureElement;
#end

using StringTools;

class Note extends FlxSprite
{
	public var strumTime:Float = 0;

	public var isPixelNote:Bool = false;

	public var mustPress:Bool = false;
	public var finishedGenerating:Bool = false;
	public var noteData:Int = 0;
	public var canBeHit:Bool = false;
	public var tooLate:Bool = false;
	public var wasGoodHit:Bool = false;
	public var didThing:Bool = false;
	public var prevNote:Note;
	public var LocalScrollSpeed:Float = 1;

	public var sustainLength:Float = 0;
	public var isSustainNote:Bool = false;

	public var noteScore:Float = 1;

	public static var swagWidth:Float = 160 * 0.7;
	public static var PURP_NOTE:Int = 0;
	public static var GREEN_NOTE:Int = 2;
	public static var BLUE_NOTE:Int = 1;
	public static var RED_NOTE:Int = 3;

	public var palooseNote = false;
	public var wizNote = false;
	public var is3dNote:Bool = false;

	private var notetolookfor = 0;

	public var MyStrum:FlxSprite;

	public var skyFNF = false;

	private var InPlayState:Bool = false;

	public var isRing = PlayState.isRing;

	var fuckerStyle:String = 'normal';

    public static var CharactersWith3D:Array<String> = ['bambi-unfair', 'bambi-piss-3d', 'bandu', 'tunnel-dave', 'badai', 'unfair-junker', 'og-dave', 'split-dave-3d', 'garrett', 'og-dave-angey', '3d-bf', 'bandu-candy', 'bandu-scaredy', 'sart-producer', 'ringi', 'bambom', 'bendu', 'diamond-man', 'sart-producer-night', 'bandu-origin', 'RECOVERED_PROJECT', 'RECOVERED_PROJECT_2', 'RECOVERED_PROJECT_3', 'hall-monitor', 'playrobot', 'playrobot-crazy', 'gary', 'david', 'brob', 'butch', 'bad', 'eww-bf', 'dingle', 'froing', 'doll', 'dale', 'robot-guy', 'batai', 'boxer', 'gotta-sleep', 'garrett-animal', 'playtime-2', 'wizard', 'do-you-accept', 'garrett-piss', 'car', 'do-you-accept-player', 'mr-music', 'paloose-men', 'diamond-man-mugen', 'insanidave', 'alge', 'butch', 'bad', 'hover-dude', 'bamb-root', 'shoulder-3d-bf', 'bandu-lullaby', 'dave-unchecked', 'bandu-card', 'cell', 'corrupt-file', 'cell-mad', 'ticking', 'among', 'swanki', 'badrum', 'cock-cream', 'wtf-lmao', '3d-tristan', 'dambu', 'dambai', 'facecam', 'blogblez', 'too-shiny'];

	public var rating:String = "shit";

	public var alt = false;

	public function new(strumTime:Float, noteData:Int, ?prevNote:Note, ?sustainNote:Bool = false, ?musthit:Bool = true, noteStyle:String = "normal") //had to add a new variable to this because FNF dumb
	{
		super();

		if (prevNote == null)
			prevNote = this;

		this.prevNote = prevNote;
		isSustainNote = sustainNote;

		x += 50;
		// MAKE SURE ITS DEFINITELY OFF SCREEN?
		y -= 2000;
		this.strumTime = strumTime + FlxG.save.data.offset;

		if (this.strumTime < 0 )
			this.strumTime = 0;

		this.noteData = noteData;
		fuckerStyle = noteStyle;

		var daStage:String = PlayState.curStage;

		if(noteStyle == 'magic')
		{
			frames = Paths.getSparrowAtlas('funnyAnimal/magicNote');

			animation.addByPrefix('greenScroll', 'dave and bambi', 24, true);
			animation.addByPrefix('redScroll', 'dave and bambi', 24, true);
			animation.addByPrefix('blueScroll', 'dave and bambi', 24, true);
			animation.addByPrefix('purpleScroll', 'dave and bambi', 24, true);

			if (isSustainNote)
			{
				makeGraphic(7 * 2, 6 * 2);

				color = FlxColor.PURPLE;
			}

			is3dNote = true;

			wizNote = true;
		}
		else if(noteStyle == 'police')
		{
			frames = Paths.getSparrowAtlas('funnyAnimal/palooseNote');

			animation.addByPrefix('greenScroll', 'JUNKING', 24, true);
			animation.addByPrefix('redScroll', 'JUNKING', 24, true);
			animation.addByPrefix('blueScroll', 'JUNKING', 24, true);
			animation.addByPrefix('purpleScroll', 'JUNKING', 24, true);

			if (isSustainNote)
			{
				makeGraphic(7 * 2, 6 * 2);

				color = FlxColor.GRAY;
			}

			is3dNote = true;

			palooseNote = true;
		}
		else if (noteStyle == 'bevel') {
			loadGraphic(Paths.image('BEVEL_NOTES'), true, 17 * 2, 17 * 2);
			
			animation.add('greenScroll', [6]);
			animation.add('redScroll', [7]);
			animation.add('blueScroll', [5]);
			animation.add('purpleScroll', [4]);
			
			if (isSustainNote)
			{
				makeGraphic(7 * 2, 6 * 2);

				color = switch (noteData){
					case 0:	FlxColor.PURPLE;
					case 1:	FlxColor.BLUE;
					case 2:	FlxColor.GREEN;
					case 3: FlxColor.RED;
					default: 0xff000000;
				}
			}
			
			setGraphicSize(Std.int(width * (PlayState.daPixelZoom / 2)));
			updateHitbox();
			antialiasing = false;

			is3dNote = true;
		}
		else if (noteStyle == '3d') {
			frames = Paths.getSparrowAtlas('NOTE_assets_3D');

			animation.addByPrefix('greenScroll', 'green0');
			animation.addByPrefix('redScroll', 'red0');
			animation.addByPrefix('blueScroll', 'blue0');
			animation.addByPrefix('purpleScroll', 'purple0');

			animation.addByPrefix('purpleholdend', 'pruple end hold');
			animation.addByPrefix('greenholdend', 'green hold end');
			animation.addByPrefix('redholdend', 'red hold end');
			animation.addByPrefix('blueholdend', 'blue hold end');

			animation.addByPrefix('purplehold', 'purple hold piece');
			animation.addByPrefix('greenhold', 'green hold piece');
			animation.addByPrefix('redhold', 'red hold piece');
			animation.addByPrefix('bluehold', 'blue hold piece');

			is3dNote = true;
		}
		else if (((CharactersWith3D.contains(PlayState.dadChar) && !musthit) || (CharactersWith3D.contains(PlayState.bfChar) && musthit)) || ((CharactersWith3D.contains(PlayState.SONG.player2) || CharactersWith3D.contains(PlayState.SONG.player1)) && ((this.strumTime / 50) % 20 > 10) && !sustainNote))
		{
			frames = Paths.getSparrowAtlas('NOTE_assets_3D');

			animation.addByPrefix('greenScroll', 'green0');
			animation.addByPrefix('redScroll', 'red0');
			animation.addByPrefix('blueScroll', 'blue0');
			animation.addByPrefix('purpleScroll', 'purple0');

			animation.addByPrefix('purpleholdend', 'pruple end hold');
			animation.addByPrefix('greenholdend', 'green hold end');
			animation.addByPrefix('redholdend', 'red hold end');
			animation.addByPrefix('blueholdend', 'blue hold end');

			animation.addByPrefix('purplehold', 'purple hold piece');
			animation.addByPrefix('greenhold', 'green hold piece');
			animation.addByPrefix('redhold', 'red hold piece');
			animation.addByPrefix('bluehold', 'blue hold piece');

			is3dNote = true;
		}
		else if(PlayState.awesomeChars.contains(PlayState.dadChar) || (PlayState.awesomeChars.contains(PlayState.bfChar) && musthit))
		{
			frames = Paths.getSparrowAtlas('awesome_notes');

			animation.addByPrefix('greenScroll', 'green0');
			animation.addByPrefix('redScroll', 'red0');
			animation.addByPrefix('blueScroll', 'blue0');
			animation.addByPrefix('purpleScroll', 'purple0');

			animation.addByPrefix('purpleholdend', 'pruple end hold');
			animation.addByPrefix('greenholdend', 'green hold end');
			animation.addByPrefix('redholdend', 'red hold end');
			animation.addByPrefix('blueholdend', 'blue hold end');

			animation.addByPrefix('purplehold', 'purple hold piece');
			animation.addByPrefix('greenhold', 'green hold piece');
			animation.addByPrefix('redhold', 'red hold piece');
			animation.addByPrefix('bluehold', 'blue hold piece');

			antialiasing = true;
		}
		else
		{
			switch (daStage)
			{
				default:
				var dumbasspath:String = 'NOTE_assets';

				    switch(noteStyle)
				    {
						case 'phone':
							dumbasspath = 'NOTE_phone';
						default:
							dumbasspath = 'NOTE_assets';
					}
					frames = Paths.getSparrowAtlas(dumbasspath);

					animation.addByPrefix('greenScroll', 'green0');
					animation.addByPrefix('redScroll', 'red0');
					animation.addByPrefix('blueScroll', 'blue0');
					animation.addByPrefix('purpleScroll', 'purple0');

					animation.addByPrefix('purpleholdend', 'pruple end hold');
					animation.addByPrefix('greenholdend', 'green hold end');
					animation.addByPrefix('redholdend', 'red hold end');
					animation.addByPrefix('blueholdend', 'blue hold end');

					animation.addByPrefix('purplehold', 'purple hold piece');
					animation.addByPrefix('greenhold', 'green hold piece');
					animation.addByPrefix('redhold', 'red hold piece');
					animation.addByPrefix('bluehold', 'blue hold piece');
					antialiasing = true;
			}
		}
		if(isRing && noteData == 2 && !sustainNote && musthit)
		{
			animation.destroyAnimations();
			frames = Paths.getSparrowAtlas('covers/gapple_notes');
			animation.addByPrefix('appleScroll', 'apple');
		}

		if (palooseNote) {
			frames = Paths.getSparrowAtlas('funnyAnimal/palooseNote');
			animation.addByPrefix('34', '', 12, true);
			animation.play('34');
			antialiasing = false;
		}
		if (wizNote) {
			frames = Paths.getSparrowAtlas('funnyAnimal/magicNote');
			animation.addByPrefix('34', '', 12, true);
			animation.play('34');
			antialiasing = false;
		}

		if(palooseNote)
		{
			switch(noteData)
			{
				case 0:
					angle = -90;
				case 1:
					angle = 180;
				case 3:
					angle = 90;
				default:
					angle = 0;
			}
		}
		
		setGraphicSize(Std.int(width * 0.7));
		updateHitbox();
		
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'cheating':
				switch (noteData)
				{
					case 0:
						x += swagWidth * 3;
						notetolookfor = 3;
						animation.play('purpleScroll');
					case 1:
						x += swagWidth * 1;
						notetolookfor = 1;
						animation.play('blueScroll');
					case 2:
						x += swagWidth * 0;
						notetolookfor = 0;
						animation.play('greenScroll');
					case 3:
						notetolookfor = 2;
						x += swagWidth * 2;
						animation.play('redScroll');
				}
				flipY = (Math.round(Math.random()) == 0); //fuck you
				flipX = (Math.round(Math.random()) == 1);

			default:
				switch (noteData)
				{
					case 0:
						x += swagWidth * 0;
						notetolookfor = 0;
						animation.play('purpleScroll');
					case 1:
						x += swagWidth * 1;
						notetolookfor = 1;
						animation.play('blueScroll');
					case 2:
						if (isRing && mustPress)
						{
							x += swagWidth * 2;
							notetolookfor = 2;
							animation.play('appleScroll');
						}
						else
						{
							x += swagWidth * 2;
							notetolookfor = 2;
							animation.play('greenScroll');
						}
					case 3:
						if (isRing && mustPress)
						{
							x += swagWidth * 3;
							notetolookfor = 3;
							animation.play('greenScroll');
						}
						else
						{
							x += swagWidth * 3;
							notetolookfor = 3;
							animation.play('redScroll');
						}
					case 4:
						if(isRing && mustPress)
						{
							x += swagWidth * 4;
							notetolookfor = 4;
							animation.play('redScroll');
						}
						
				}
		}
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'cheating' | 'unfairness' | 'applecore' | 'ripple' | 'amongfairness':
				if (Type.getClassName(Type.getClass(FlxG.state)).contains("PlayState"))
				{
					var state:PlayState = cast(FlxG.state,PlayState);
					InPlayState = true;
					if (musthit)
					{
						state.playerStrums.forEach(function(spr:FlxSprite)
						{
							if (spr.ID == notetolookfor)
							{
								x = spr.x;
								MyStrum = spr;
							}
						});
					}
					else
					{
						state.dadStrums.forEach(function(spr:FlxSprite)
						{
							if (spr.ID == notetolookfor)
							{
									x = spr.x;
									MyStrum = spr;
								}
							});
					}
				}
		}
		if (PlayState.SONG.song.toLowerCase() == 'unfairness' || PlayState.SONG.song.toLowerCase() == 'applecore' || PlayState.SONG.song.toLowerCase() == 'amongfairness')
		{
			var rng:FlxRandom = new FlxRandom();
			if (rng.int(0,120) == 1)
			{
				LocalScrollSpeed = 0.1;
			}
			else
			{
				LocalScrollSpeed = rng.float(1,3);
			}
		}
		

		// trace(prevNote);

		// we make sure its downscroll and its a SUSTAIN NOTE (aka a trail, not a note)
		// and flip it so it doesn't look weird.
		// THIS DOESN'T FUCKING FLIP THE NOTE, CONTRIBUTERS DON'T JUST COMMENT THIS OUT JESUS
		if (FlxG.save.data.downscroll && sustainNote) 
			flipY = true;

		if (isSustainNote && prevNote != null)
		{
			noteScore * 0.2;
			alpha = 0.6;

			x += width / 2;


			switch (noteData)
			{
				case 2:
					animation.play('greenholdend');
				case 3:
					animation.play('redholdend');
				case 1:
					animation.play('blueholdend');
				case 0:
					animation.play('purpleholdend');
			}

			updateHitbox();

			x -= width / 2;

			if (PlayState.curStage.startsWith('school'))
				x += 30;

			if (prevNote.isSustainNote)
			{
				switch (prevNote.noteData)
				{
					case 0:
						prevNote.animation.play('purplehold');
					case 1:
						prevNote.animation.play('bluehold');
					case 2:
						prevNote.animation.play('greenhold');
					case 3:
						prevNote.animation.play('redhold');
				}

				prevNote.scale.y *= Conductor.stepCrochet / 100 * 1.8 * PlayState.swagSpeed;
				prevNote.updateHitbox();
				// prevNote.setGraphicSize();
			}
		}

		if (skyFNF) {
			x = 788;
			x += width * noteData;
		}

		if (PlayState.SONG.song.toLowerCase() == 'ready-loud') x -= 1280 / 4;
	}

	public var isAlt:Bool = false;

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (MyStrum != null && !isAlt)
		{
			x = MyStrum.x + (isSustainNote ? width : 0);
			//angle = MyStrum.angle;
		}
		else
		{
			if (InPlayState && !isAlt)
			{
				var state:PlayState = cast(FlxG.state,PlayState);
				if (mustPress)
					{
						state.playerStrums.forEach(function(spr:FlxSprite)
						{
							if (spr.ID == notetolookfor)
							{
								x = spr.x;
								//angle = spr.angle;
								MyStrum = spr;
							}
						});
					}
					else
					{
						state.dadStrums.forEach(function(spr:FlxSprite)
							{
								if (spr.ID == notetolookfor)
								{
									x = spr.x;
									//angle = spr.angle;
									MyStrum = spr;
								}
							});
					}
			}
		}
		if (mustPress)
		{
			// The * 0.5 is so that it's easier to hit them too late, instead of too early
			if (strumTime > Conductor.songPosition - Conductor.safeZoneOffset
				&& strumTime < Conductor.songPosition + (Conductor.safeZoneOffset * 0.5))
				canBeHit = true;
			else
				canBeHit = false;

			if (strumTime < Conductor.songPosition - Conductor.safeZoneOffset && !wasGoodHit)
				tooLate = true;
		}
		else
		{
			canBeHit = false;

			if (strumTime <= Conductor.songPosition)
				wasGoodHit = true;
		}

		if (tooLate)
		{
			if (alpha > 0.3)
				alpha = 0.3;
			
		}
	}

	public function resetNote()
	{
		if (((CharactersWith3D.contains(PlayState.dadChar) && !mustPress) || (CharactersWith3D.contains(PlayState.bfChar) && mustPress)) || ((CharactersWith3D.contains(PlayState.SONG.player2) || CharactersWith3D.contains(PlayState.SONG.player1)) && ((this.strumTime / 50) % 20 > 10)))
		{
			frames = Paths.getSparrowAtlas('NOTE_assets_3D');

			animation.addByPrefix('greenScroll', 'green0');
			animation.addByPrefix('redScroll', 'red0');
			animation.addByPrefix('blueScroll', 'blue0');
			animation.addByPrefix('purpleScroll', 'purple0');

			animation.addByPrefix('purpleholdend', 'pruple end hold');
			animation.addByPrefix('greenholdend', 'green hold end');
			animation.addByPrefix('redholdend', 'red hold end');
			animation.addByPrefix('blueholdend', 'blue hold end');

			animation.addByPrefix('purplehold', 'purple hold piece');
			animation.addByPrefix('greenhold', 'green hold piece');
			animation.addByPrefix('redhold', 'red hold piece');
			animation.addByPrefix('bluehold', 'blue hold piece');

			is3dNote = true;
		}
		else
		{
			switch (PlayState.curStage)
			{
				default:
				var dumbasspath:String = 'NOTE_assets';

				    switch(fuckerStyle)
				    {
						case 'phone':
							dumbasspath = 'NOTE_phone';
						default:
							dumbasspath = 'NOTE_assets';
					}
					frames = Paths.getSparrowAtlas(dumbasspath);

					animation.addByPrefix('greenScroll', 'green0');
					animation.addByPrefix('redScroll', 'red0');
					animation.addByPrefix('blueScroll', 'blue0');
					animation.addByPrefix('purpleScroll', 'purple0');

					animation.addByPrefix('purpleholdend', 'pruple end hold');
					animation.addByPrefix('greenholdend', 'green hold end');
					animation.addByPrefix('redholdend', 'red hold end');
					animation.addByPrefix('blueholdend', 'blue hold end');

					animation.addByPrefix('purplehold', 'purple hold piece');
					animation.addByPrefix('greenhold', 'green hold piece');
					animation.addByPrefix('redhold', 'red hold piece');
					animation.addByPrefix('bluehold', 'blue hold piece');
					antialiasing = true;
			}
		}
		if(isRing && noteData == 2 && !isSustainNote && mustPress)
		{
			animation.destroyAnimations();
			frames = Paths.getSparrowAtlas('covers/gapple_notes');
			animation.addByPrefix('appleScroll', 'apple');
		}

		switch (noteData)
				{
					case 0:
						x += swagWidth * 0;
						notetolookfor = 0;
						animation.play('purpleScroll');
					case 1:
						x += swagWidth * 1;
						notetolookfor = 1;
						animation.play('blueScroll');
					case 2:
						if (isRing && mustPress)
						{
							x += swagWidth * 2;
							notetolookfor = 2;
							animation.play('appleScroll');
						}
						else
						{
							x += swagWidth * 2;
							notetolookfor = 2;
							animation.play('greenScroll');
						}
					case 3:
						if (isRing && mustPress)
						{
							x += swagWidth * 3;
							notetolookfor = 3;
							animation.play('greenScroll');
						}
						else
						{
							x += swagWidth * 3;
							notetolookfor = 3;
							animation.play('redScroll');
						}
					case 4:
						if(isRing && mustPress)
						{
							x += swagWidth * 4;
							notetolookfor = 4;
							animation.play('redScroll');
						}
						
				}

		if (FlxG.save.data.downscroll && isSustainNote) 
			flipY = true;

		
		setGraphicSize(Std.int(width * 0.7));
		updateHitbox();

		if (isSustainNote && prevNote != null)
		{
			alpha = 0.6;


			switch (noteData)
			{
				case 2:
					animation.play('greenholdend');
				case 3:
					animation.play('redholdend');
				case 1:
					animation.play('blueholdend');
				case 0:
					animation.play('purpleholdend');
			}

			updateHitbox();

			if (prevNote.isSustainNote)
			{
				switch (prevNote.noteData)
				{
					case 0:
						prevNote.animation.play('purplehold');
					case 1:
						prevNote.animation.play('bluehold');
					case 2:
						prevNote.animation.play('greenhold');
					case 3:
						prevNote.animation.play('redhold');
				}

				prevNote.scale.y *= Conductor.stepCrochet / 100 * 1.8 * PlayState.swagSpeed;
				prevNote.updateHitbox();
				// prevNote.setGraphicSize();
			}
		}
	}

	public function make2d()
	{
		is3dNote = false;

		isPixelNote = false;

		var cachedCurrentAnimation = animation.curAnim.name;

		animation.destroyAnimations();

		var dumbasspath = 'NOTE_assets';
		
		frames = Paths.getSparrowAtlas(dumbasspath);

		animation.addByPrefix('greenScroll', 'green0');
		animation.addByPrefix('redScroll', 'red0');
		animation.addByPrefix('blueScroll', 'blue0');
		animation.addByPrefix('purpleScroll', 'purple0');

		animation.addByPrefix('purpleholdend', 'pruple end hold');
		animation.addByPrefix('greenholdend', 'green hold end');
		animation.addByPrefix('redholdend', 'red hold end');
		animation.addByPrefix('blueholdend', 'blue hold end');

		animation.addByPrefix('purplehold', 'purple hold piece');
		animation.addByPrefix('greenhold', 'green hold piece');
		animation.addByPrefix('redhold', 'red hold piece');
		animation.addByPrefix('bluehold', 'blue hold piece');

		setGraphicSize(Std.int(width * 0.7));
		updateHitbox();
		antialiasing = true;

		animation.play(cachedCurrentAnimation, true);

		
		if (isSustainNote && prevNote != null)
		{
			alpha = 0.6;

			updateHitbox();

			if (prevNote.isSustainNote)
			{
				prevNote.scale.y *= Conductor.stepCrochet / 100 * 1.8 * PlayState.swagSpeed;
				prevNote.updateHitbox();
				// prevNote.setGraphicSize();
			}
		}

		switch (noteData)
				{
					case 0:
						x += swagWidth * 0;
						notetolookfor = 0;
						animation.play('purpleScroll');
					case 1:
						x += swagWidth * 1;
						notetolookfor = 1;
						animation.play('blueScroll');
					case 2:
						if (isRing && mustPress)
						{
							x += swagWidth * 2;
							notetolookfor = 2;
							animation.play('appleScroll');
						}
						else
						{
							x += swagWidth * 2;
							notetolookfor = 2;
							animation.play('greenScroll');
						}
					case 3:
						if (isRing && mustPress)
						{
							x += swagWidth * 3;
							notetolookfor = 3;
							animation.play('greenScroll');
						}
						else
						{
							x += swagWidth * 3;
							notetolookfor = 3;
							animation.play('redScroll');
						}
					case 4:
						if(isRing && mustPress)
						{
							x += swagWidth * 4;
							notetolookfor = 4;
							animation.play('redScroll');
						}
						
				}

		if (FlxG.save.data.downscroll && isSustainNote) 
			flipY = true;

		if (isSustainNote && prevNote != null)
		{
			alpha = 0.6;


			switch (noteData)
			{
				case 2:
					animation.play('greenholdend');
				case 3:
					animation.play('redholdend');
				case 1:
					animation.play('blueholdend');
				case 0:
					animation.play('purpleholdend');
			}

			updateHitbox();

			if (prevNote.isSustainNote)
			{
				switch (prevNote.noteData)
				{
					case 0:
						prevNote.animation.play('purplehold');
					case 1:
						prevNote.animation.play('bluehold');
					case 2:
						prevNote.animation.play('greenhold');
					case 3:
						prevNote.animation.play('redhold');
				}

				prevNote.scale.y *= Conductor.stepCrochet / 100 * 1.8 * PlayState.swagSpeed;
				prevNote.updateHitbox();
				// prevNote.setGraphicSize();
			}
		}
	}
	public function makePixel()
	{
		is3dNote = false;

		isPixelNote = true;

		var cachedCurrentAnimation = animation.curAnim.name;

		animation.destroyAnimations();
		
		loadGraphic(Paths.image('pixelUi/pixel_notes'), true, 17, 17);

		animation.add('greenScroll', [6]);
		animation.add('redScroll', [7]);
		animation.add('blueScroll', [5]);
		animation.add('purpleScroll', [4]);

		if (isSustainNote)
		{
			loadGraphic(Paths.image('pixelUi/ends'), true, 7, 6);

			animation.add('purpleholdend', [4]);
			animation.add('greenholdend', [6]);
			animation.add('redholdend', [7]);
			animation.add('blueholdend', [5]);

			animation.add('purplehold', [0]);
			animation.add('greenhold', [2]);
			animation.add('redhold', [3]);
			animation.add('bluehold', [1]);
		}

		setGraphicSize(Std.int(width * PlayState.daPixelZoom));
		updateHitbox();

		antialiasing = false;

		animation.play(cachedCurrentAnimation, true);

		
		if (isSustainNote && prevNote != null)
		{
			alpha = 0.6;

			updateHitbox();

			x += 30;

			if (prevNote.isSustainNote)
			{
				prevNote.scale.y *= Conductor.stepCrochet / 100 * 1.8 * PlayState.swagSpeed;
				prevNote.updateHitbox();
				// prevNote.setGraphicSize();
			}
		}
	}
}
