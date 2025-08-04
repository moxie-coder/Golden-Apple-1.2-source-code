package;

import cpp.vm.Debugger.ThreadInfo;
import flixel.graphics.FlxGraphic;
import openfl.display.Bitmap;
import lime.app.Application;
#if FEATURE_DISCORD
import Discord.DiscordClient;
#end
import openfl.display.BlendMode;
import openfl.text.TextFormat;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxState;
import openfl.Assets;
import openfl.Lib;
import openfl.display.FPS;
import openfl.display.Sprite;
import openfl.events.Event;

class Main extends Sprite
{
	var gameWidth:Int = 1280; // Width of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var gameHeight:Int = 720; // Height of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var initialState:Class<FlxState> = StartupState; // The FlxState the game starts with.
	var zoom:Float = -1; // If -1, zoom is automatically calculated to fit the window dimensions.
	var framerate:Int = 144; // How many frames per second the game should run at.
	var skipSplash:Bool = true; // Whether to skip the flixel splash screen that appears in release mode.
	var startFullscreen:Bool = false; // Whether to start the game in fullscreen on desktop targets

	// You can pretty much ignore everything from here on - your code should go in your states.

	public static function main():Void
	{
		Lib.current.addChild(new Main());
	}

	public function new()
	{
		super();

		if (stage != null)
		{
			init();
		}
		else
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
	}

	private function init(?E:Event):Void
	{
		if (hasEventListener(Event.ADDED_TO_STAGE))
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}

		setupGame();
	}

	private function setupGame():Void
	{
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		if (zoom == -1)
		{
			var ratioX:Float = stageWidth / gameWidth;
			var ratioY:Float = stageHeight / gameHeight;
			zoom = Math.min(ratioX, ratioY);
			gameWidth = Math.ceil(stageWidth / zoom);
			gameHeight = Math.ceil(stageHeight / zoom);
		}

		addChild(new FlxGame(gameWidth, gameHeight, initialState, zoom, framerate, framerate, skipSplash, startFullscreen));

		#if !mobile
		fpsCounter = new FPS(10, 3, 0xFFFFFF);
		fpsCounter.defaultTextFormat = new TextFormat("Comic Sans MS Bold", 20, 0xFFFFFF, true);
		addChild(fpsCounter);

		// no
		/*
		memoryCounter = new MemoryCounter(10, fpsCounter.y + 13, 0xffffff);
		memoryCounter.defaultTextFormat = new TextFormat("Comic Sans MS Bold", 14, 0xFFFFFF, true);
		addChild(memoryCounter);
		*/
		#end
	}

	public static var memoryCounter:MemoryCounter;

	public static var fpsCounter:FPS;

	public static function dumpCache()
	{
		if(!FlxG.save.data.preloadAtAll)
		{
			Assets.cache.clear();
		}
	}

	public static function toggleCounterVisible(status:Bool = true)
	{
		switch(status)
		{
			case false:
			{
				fpsCounter.visible = false;
				//memoryCounter.visible = false;
			}
			default:
			{
				fpsCounter.visible = true;
				//memoryCounter.visible = true;
			}
		}
	}
}

/**
 * dont even know if this is needed but im keeping it cuz im a paranoid bitch
 */
class GameDimensions
{
	public static var width:Int = 1280;
	public static var height:Int = 720;
}