package;

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

class ExtraCategorySelect extends MusicBeatState
{
	public static var cats:Array<String> = ['extra', 'ocs', 'joke', 'iykyk', 'secret', 'awesome', 'covers' /*, 'minus'*/];

	public static var curCat:Int = 0;

	var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('backgrounds/SUSSUS AMOGUS'));

	var catIcon:FlxSprite = new FlxSprite().loadGraphic(Paths.image('categories/extra'));

	var curSelected:Int = 0;

	var skyMod:FlxSprite;

	override function create()
	{
		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
			Conductor.changeBPM(150);
		}

		skyMod = new FlxSprite().makeGraphic(1280, 720, FlxColor.BLACK);
		skyMod.visible = false;
		skyMod.scale.set(2.4, 2.4);
		skyMod.angle = 25;
		skyMod.x = 1280 * 1.7;

		#if desktop DiscordClient.changePresence("In the Extra Song Category Select Menu", null); #end

		bg.loadGraphic(MainMenuState.randomizeBG());
		bg.color = FlxColor.LIME;
		add(bg);

		changeSelection();

		add(catIcon);

		add(skyMod);

		super.create();
	}

	override function update(p:Float)
	{
		Conductor.songPosition = FlxG.sound.music.time;

		super.update(p);

		if (controls.LEFT_P)
			changeSelection(-1);

		if (controls.RIGHT_P)
			changeSelection(1);

		if ((controls.BACK || FlxG.keys.justPressed.BACKSPACE))
			FlxG.switchState(new PlayMenuState());

		if (controls.ACCEPT || FlxG.keys.justPressed.ENTER)
		{
			FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
			// stupidest bullshit ive ever done
			FlxTween.tween(bg, {"scale.x": 0, "scale.y": 0}, 1, {ease: FlxEase.expoIn});
			FlxTween.tween(catIcon, {"scale.x": catIcon.scale.x * 11, "scale.y": catIcon.scale.y * 11}, 1, {
				ease: FlxEase.expoIn,
				onComplete: function(twn:FlxTween)
				{
					skyMod.visible = true;
					FlxTween.tween(skyMod, {x: 0}, 0.05, {
						onComplete: function(twn2:FlxTween)
						{
							curCat = curSelected;
							PlayState.ohMyFuckingFuckingFuckingGod(cats[curSelected]);
						}
					});
				}
			});
		}
	}

	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		curSelected += change;

		if (curSelected < 0)
			curSelected = cats.length - 1;

		if (curSelected >= cats.length)
			curSelected = 0;

		catIcon.loadGraphic(Paths.image('categories/' + cats[curSelected]));
		catIcon.setGraphicSize(0, 710);
		catIcon.updateHitbox();
		catIcon.screenCenter();
	}
}
