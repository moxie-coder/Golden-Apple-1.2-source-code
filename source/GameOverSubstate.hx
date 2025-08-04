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

	var sarters:Array<String> = ['sart-producer', 'sart-producer-night'];

	var dave:FlxSprite;

	var fuckery:FlxSprite;

	var pissy:FlxSprite;

	public function new(x:Float, y:Float,char:String)
	{
		// you should be able to skip dave's long drawn out dialogue if youve already seen it
		if (PlayState.SONG.song.toLowerCase() == 'irreversible-action' && !SaveFileState.saveFile.data.elfDiscovered) canSelect = false;

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
		if(char == '3d-bf' || char == 'shoulder-3d-bf' || char == 'bf-pad')
		{
			if(daStage == 'sunshine' && FlxG.save.data.sensitiveContent)
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

		if(sarters.contains(PlayState.dadChar))
		{
			stageSuffix = '-sart';
		}

		super();

		dave = new FlxSprite().loadGraphic(Paths.image('dave/dave'));
		dave.setPosition(1280 - dave.width, 720 - dave.height);
		dave.scrollFactor.set(0, 0);
		dave.alpha = 0;
		add(dave);

		Conductor.songPosition = 0;

		bf = new Boyfriend(x, y, char);
		if(bf.animation.getByName('firstDeath') == null)
		{
			bf = new Boyfriend(x, y, "bf");
		}
		add(bf);

		camFollow = new FlxObject(bf.getGraphicMidpoint().x, bf.getGraphicMidpoint().y, 1, 1);
		add(camFollow);
		
		if(char == 'hang-bf')
		{
			bf.scrollFactor.set();
			bf.screenCenter();
			FlxG.camera.follow(camFollow, LOCKON, 0.01);
		}

		FlxG.sound.play(Paths.sound('fnf_loss_sfx' + stageSuffix), volumese).onComplete = function baldiDick(){if(!isEnding && PlayState.SONG.song.toLowerCase() != 'irreversible-action'){FlxG.sound.playMusic(Paths.music('gameOver' + stageSuffix), volumese); canBop = true;}};

		Conductor.changeBPM(100);

		fuckery = new FlxSprite();
		fuckery.frames = Paths.getSparrowAtlas('jumpscray');
		fuckery.animation.addByPrefix('jump', 'SCRAY', 24, false);
		fuckery.scrollFactor.set();

		pissy = new FlxSprite().loadGraphic(Paths.image('that died'));
		pissy.screenCenter();
		pissy.scrollFactor.set();

		if(sarters.contains(PlayState.dadChar))
		{
			Conductor.changeBPM(50);
			bf.visible = false;
			add(pissy);
			pissy.alpha = 0;
			pissy.screenCenter();
			add(fuckery);
			fuckery.animation.play('jump', true);
			fuckery.screenCenter();

			FlxG.camera.shake(0.05, 2.94, function myDick() 
			{
				fuckery.alpha = 0;
				pissy.alpha = 1;
				FlxG.camera.flash(FlxColor.WHITE, 0.15);
			});
		}

		// FlxG.camera.followLerp = 1;
		// FlxG.camera.focusOn(FlxPoint.get(FlxG.width / 2, FlxG.height / 2));
		FlxG.camera.scroll.set();
		FlxG.camera.target = null;

		bf.playAnim('firstDeath');

		if (PlayState.SONG.song.toLowerCase() == 'disability' && SaveFileState.saveFile.data.elfMode) {
			bf.visible = false;
			var elf = new FlxSprite();
			elf.frames = Paths.getSparrowAtlas('THE BEST EVER/untitled');
			elf.animation.addByPrefix('idle', 'MY BALDI BASICS PLUS PRO GAMES', 24, true);
			elf.animation.play('idle');
			elf.scale.set(2.5, 2.5);
			elf.scrollFactor.set(0, 0);
			elf.screenCenter();
			elf.antialiasing = false;
			elf.alpha = 0;
			add(elf);
			FlxTween.tween(elf, {alpha: 1}, 2.5, {startDelay: 0.5});
		}

		if (PlayState.SONG.song.toLowerCase() == 'cycles') {
			var img = new FlxSprite().loadGraphic(Paths.image('sart/RobloxScreenShot20220213_202053230'));
			img.setGraphicSize(1280);
			img.screenCenter();
			img.scrollFactor.set(0, 0);
			img.alpha = 0;
			add(img);
			FlxTween.tween(img, {alpha: 1}, 1);
		}

		if (PlayState.SONG.song.toLowerCase() == 'irreversible-action') {
			bf.visible = false;
			FlxTween.tween(dave, {alpha: 1}, 3.25, {startDelay: 1, onComplete: function(twn:FlxTween){
				FlxG.sound.play(Paths.sound('speech'));

				// im a pro codder :nerd:
				dave.loadGraphic(Paths.image('dave/dvae'));
				new FlxTimer().start(0.8, function(tmr:FlxTimer){
					dave.loadGraphic(Paths.image('dave/dave'));
					new FlxTimer().start(0.35, function(tmr2:FlxTimer){
						dave.loadGraphic(Paths.image('dave/dvae'));
						new FlxTimer().start(0.81, function(tmr3:FlxTimer){
							dave.loadGraphic(Paths.image('dave/dave'));
							new FlxTimer().start(0.46, function(tmr4:FlxTimer){
								dave.loadGraphic(Paths.image('dave/dvae'));
								new FlxTimer().start(3.11, function(tmr5:FlxTimer){
									dave.loadGraphic(Paths.image('dave/dave'));
									new FlxTimer().start(0.47, function(tmr6:FlxTimer){
										dave.loadGraphic(Paths.image('dave/dvae'));
										new FlxTimer().start(1.96, function(tmr7:FlxTimer){
											dave.loadGraphic(Paths.image('dave/dave'));
											new FlxTimer().start(0.57, function(tmr8:FlxTimer){
												dave.loadGraphic(Paths.image('dave/dvae'));
												new FlxTimer().start(0.93, function(tmr9:FlxTimer){
													dave.loadGraphic(Paths.image('dave/dave'));
													new FlxTimer().start(2.3, function(tmr10:FlxTimer){
														dave.loadGraphic(Paths.image('dave/dvae'));
														new FlxTimer().start(3, function(tmr11:FlxTimer){
															dave.loadGraphic(Paths.image('dave/dave'));
															new FlxTimer().start(0.93, function(tmr12:FlxTimer){
																dave.loadGraphic(Paths.image('dave/dvae'));
																new FlxTimer().start(2.77, function(tmr13:FlxTimer){
																	dave.loadGraphic(Paths.image('dave/dave'));
																	new FlxTimer().start(0.57, function(tmr14:FlxTimer){
																		dave.loadGraphic(Paths.image('dave/dvae'));
																		new FlxTimer().start(1.04, function(tmr15:FlxTimer){
																			dave.loadGraphic(Paths.image('dave/dave'));
																			new FlxTimer().start(0.23, function(tmr16:FlxTimer){
																				dave.loadGraphic(Paths.image('dave/dvae'));
																				new FlxTimer().start(1.5, function(tmr17:FlxTimer){
																					dave.loadGraphic(Paths.image('dave/dave'));
																					FlxTween.tween(dave, {alpha:0}, 3.25, {onComplete: function(twn2:FlxTween){
																						canSelect = true;
																					}});
																				});
																			});
																		});
																	});
																});
															});
														});
													});
												});
											});
										});
									});
								});
							});
						});
					});
				});
			}});
		}
	}

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

			if (PlayState.SONG.song.toLowerCase() == 'disability') {
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
			/*else if (PlayState.SONG.song.toLowerCase() == 'recovered-project') {
				trace("WUH OH!!!");

				SaveFileState.saveFile.data.foundCorrupt = true;

				PlayState.practicing = false;
			
				PlayState.fakedScore = false;
		
				PlayState.deathCounter = 0;

				var poop:String = Highscore.formatSong('corrupted-file', 1);

				trace(poop);

				PlayState.SONG = Song.loadFromJson(poop, 'corrupted-file');
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = 1;

				PlayState.storyWeek = 1;
				LoadingState.loadAndSwitchState(new PlayState());
			}*/
			else if (PlayState.SONG.song.toLowerCase() == 'corrupted-file') {
				trace("WUH OH!!!");

				SaveFileState.saveFile.data.foundAction = true;

				PlayState.practicing = false;
			
				PlayState.fakedScore = false;
		
				PlayState.deathCounter = 0;

				var poop:String = Highscore.formatSong('irreversible-action', 1);

				trace(poop);

				PlayState.SONG = Song.loadFromJson(poop, 'irreversible-action');
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = 1;

				PlayState.storyWeek = 1;
				LoadingState.loadAndSwitchState(new PlayState());
			}
			else if (PlayState.SONG.song.toLowerCase() == 'irreversible-action') {
				trace("https://cdn.discordapp.com/attachments/515627811621437441/938007191254859796/unknown.png");

				SaveFileState.saveFile.data.elfDiscovered = true;

				SaveFileState.saveFile.data.elfMode = true;

				PlayState.practicing = false;
			
				PlayState.fakedScore = false;
		
				PlayState.deathCounter = 0;

				var poop:String = Highscore.formatSong('penis', 1);

				trace(poop);

				PlayState.SONG = Song.loadFromJson(poop, 'penis');
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = 1;

				PlayState.storyWeek = 1;
				LoadingState.loadAndSwitchState(new PlayState());
			}
			else if (PlayState.SONG.song.toLowerCase() == 'penis')
				FlxG.switchState(new GetBackState());
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

		if(curBeat % 2 == 0 && canBop && !isEnding)
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
