package;

import Controls.Control;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

using StringTools;

class PauseSubState extends MusicBeatSubstate
{
	var grpMenuShit:FlxTypedGroup<Alphabet>;

	var menuItems:Array<String> = [
		'Resume',
		'Toggle Practice Mode', 
        'Toggle Botplay', // cuz yes
		'Restart Song',
		'Exit to menu'
	];
	var curSelected:Int = 0;

	var pauseMusic:FlxSound;

	var practiceText:FlxText;

	var bottyText:FlxText;

	public function new(x:Float, y:Float)
	{
		super();

		pauseMusic = new FlxSound().loadEmbedded(Paths.music('breakfast'), true, true);
		pauseMusic.volume = 0;
		pauseMusic.play(false, FlxG.random.int(0, Std.int(pauseMusic.length / 2)));

		FlxG.sound.list.add(pauseMusic);

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0;
		bg.scrollFactor.set();
		add(bg);

		var sucker:String = PlayState.SONG.song;
		sucker = sucker.replace('-', ' ');
		var levelInfo:FlxText = new FlxText(20, 15, 0, "", 32);
		levelInfo.text += sucker;
		levelInfo.scrollFactor.set();
		levelInfo.setFormat(Paths.font("vcr.ttf"), 32);
		levelInfo.updateHitbox();
		add(levelInfo);

		var levelDifficulty:FlxText = new FlxText(20, 15 + 32, 0, "", 32);
		levelDifficulty.text += CoolUtil.difficultyString();
		levelDifficulty.scrollFactor.set();
		levelDifficulty.setFormat(Paths.font('vcr.ttf'), 32);
		levelDifficulty.updateHitbox();
		add(levelDifficulty);

		var blueballedTxt:FlxText = new FlxText(20, 15 + 29, 0, "", 32);
		blueballedTxt.text = "Died: " + PlayState.deathCounter;
		blueballedTxt.scrollFactor.set();
		blueballedTxt.setFormat(Paths.font('vcr.ttf'), 32);
		blueballedTxt.updateHitbox();
		blueballedTxt.x = FlxG.width - (blueballedTxt.width + 20);
		add(blueballedTxt);

		practiceText = new FlxText(20, 15 + 61, 0, "PRACTICE MODE", 32);
		practiceText.scrollFactor.set();
		practiceText.setFormat(Paths.font('vcr.ttf'), 32);
		practiceText.x = FlxG.width - (practiceText.width + 20);
		practiceText.updateHitbox();
		practiceText.visible = PlayState.practicing;
		add(practiceText);
		bottyText = new FlxText(20, 15 + 88, 0, "BOTPLAY", 32);
		bottyText.scrollFactor.set();
		bottyText.setFormat(Paths.font('vcr.ttf'), 32);
		bottyText.x = FlxG.width - (practiceText.width + 20);
		bottyText.updateHitbox();
		bottyText.visible = PlayState.bottyPlay;
		add(bottyText);

		levelDifficulty.alpha = 0;
		levelInfo.alpha = 0;
		blueballedTxt.alpha = 0;
		practiceText.alpha = 0;
		bottyText.alpha = 0;

		levelInfo.x = FlxG.width - (levelInfo.width + 20);
		levelDifficulty.x = FlxG.width - (levelDifficulty.width + 20);
		levelDifficulty.visible = false;

		FlxTween.tween(bg, {alpha: 0.6}, 0.4, {ease: FlxEase.quartInOut});
		FlxTween.tween(levelInfo, {alpha: 1, y: 20}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.3});
		FlxTween.tween(blueballedTxt, {alpha: 1, y: blueballedTxt.y + 5}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.4});
		FlxTween.tween(practiceText, {alpha: 1, y: practiceText.y + 5}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.5});
		FlxTween.tween(bottyText, {alpha: 1, y: bottyText.y + 5}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.5});

		grpMenuShit = new FlxTypedGroup<Alphabet>();
		add(grpMenuShit);

		for (i in 0...menuItems.length)
		{
			var songText:Alphabet = new Alphabet(0, (70 * i) + 30, menuItems[i], true, false);
			songText.isMenuItem = true;
			songText.targetY = i;
			grpMenuShit.add(songText);
		}

		changeSelection();

		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
	}

	override function update(elapsed:Float)
	{
		if (pauseMusic.volume < 0.5)
			pauseMusic.volume += 0.01 * elapsed;

		super.update(elapsed);

		var upP = controls.UP_P;
		var downP = controls.DOWN_P;
		var accepted = controls.ACCEPT;

		if (upP)
		{
			changeSelection(-1);
		}
		if (downP)
		{
			changeSelection(1);
		}

		if (controls.ACCEPT || FlxG.keys.justPressed.ENTER)
		{
			var daSelected:String = menuItems[curSelected];

			switch (daSelected)
			{
				case "Resume":
					close();
				case 'Toggle Practice Mode':
					if (PlayState.SONG.song.toLowerCase() == 'penis')
					{
						if (grpMenuShit.members[1].alpha != 0)
						{
							FlxTween.color(grpMenuShit.members[1], 0.15, FlxColor.WHITE, FlxColor.RED);
							FlxTween.tween(grpMenuShit.members[1], {alpha: 0}, 0.25);
						}
						trace("hello");
					}
					else
					{
						PlayState.fakedScore = true;
						PlayState.practicing = !PlayState.practicing;
						practiceText.visible = PlayState.practicing;
					}
				case 'Toggle Botplay':
						PlayState.fakedScore = true;
						PlayState.bottyPlay = !PlayState.bottyPlay;
						bottyText.visible = PlayState.bottyPlay;
				case "Restart Song":
					FlxG.resetState();
				case "Exit to menu":
					if (PlayState.SONG.song.toLowerCase() == 'penis')
						FlxG.switchState(new GetBackState());
					else
					{
						PlayState.characteroverride = 'none';
						PlayState.formoverride = 'none';
						FlxG.switchState(new MainMenuState());
					}
			}
		}

		if (FlxG.keys.justPressed.J)
		{
			// for reference later!
			// PlayerSettings.player1.controls.replaceBinding(Control.LEFT, Keys, FlxKey.J, null);
		}
	}

	override function destroy()
	{
		pauseMusic.destroy();

		super.destroy();
	}

	function changeSelection(change:Int = 0):Void
	{
		curSelected += change;

		if (curSelected < 0)
			curSelected = menuItems.length - 1;
		if (curSelected >= menuItems.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grpMenuShit.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			if (item.alpha != 0)
			{
				item.alpha = 0.6;
			}
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0 && item.alpha != 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
	}
}
