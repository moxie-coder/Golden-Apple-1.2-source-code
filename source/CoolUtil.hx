package;

import flixel.FlxG;
import sys.io.File;
import openfl.system.System;
import lime.utils.Assets;

using StringTools;

class CoolUtil
{
	public static var difficultyArray:Array<String> = ['EASY', "NORMAL", "HARD","LEGACY"];

	public static function isSecretSong(song:String) 
	{
		switch(song.toLowerCase())
		{
			case 'dave-x-bambi-shipping-cute' | 'recovered-project' | 'corrupted-file' | 'cell' | 'ticking' | 'penis' | 'cheating-not-cute':
				return true;
		}
		return false;
	}

	public static function cheatersNeverProsper()
	{
		FlxG.save.flush();
		SaveFileState.saveFile.flush();
		Sys.command("start assets/data/caught.txt");
		System.exit(0);
	}


	public static function difficultyString():String
	{
		switch (PlayState.storyWeek)
		{
			case 3:
				return 'FINALE';
			default:
				return difficultyArray[PlayState.storyDifficulty];
		}
	}

	public static function boundTo(value:Float, min:Float, max:Float):Float
	{
		var newValue:Float = value;
		if(newValue < min) newValue = min;
		else if(newValue > max) newValue = max;
		return newValue;
	}

	public static function songDiffRating(song:String)
	{
		var diff:String = 'unknown';
		switch(song.toLowerCase())
		{
			case 'applecore' | 'penis' | 'wednesday' | 'among-us-penis-sex':
				diff = 'extreme';
			case 'disruption' | 'jambino' | 'sugar-rush' | 'ferocious' | 'gift-card' | 'og' | 'deformation' | 'algebra' | 'slices' | 'left-unchecked' | 'collision' | 'ready-loud' | 'poopers' | 'amongfairness' | 'the-boopadoop-song' | 'sweaty-workout' | 'clit' | 'sit-on-my-face' | 'gobbledegook' | 'generic' | 'encrypted' | 'bandu-radical' | 'locked-lips':
				diff = 'hard';
			case 'bookworm' | 'disability' | 'dale' | 'recovered-project' | 'metallic' | 'keyboard' | 'chippy' | 'cell' | 'wireframe' | 'ticking' | 'unhinged' | 'sunshine' | 'cuberoot' | 'thunderstorm' | 'too-shiny' | 'apprentice' | 'ny-tristan' | 'pee-shooter' | 'second-coming-of-the-' | 'i-am-canonically-trans' | 'fl-keys' | 'fuckity' | 'bug-eyed-bitch' | 'jerry-the-mouse' | 'threesome' | 'the-100th-ruby-song' | 'my-home' | 'tantalum' | 'sillier':
				diff = 'normal';
			case 'origin' | 'strawberry' | 'ugh' | 'sart-producer' | 'theft' | 'the-big-dingle' | 'corrupted-file' | 'sick-tricks' | 'galactic' | 'dave-x-bambi-shipping-cute' | 'production' | 'wheels' | 'alternate' | 'cycles' | 'resumed' | 'impregnate' | 'chilli-powder' | 'trampoline-accident' | 'pink-bandu' | 'the-willy-walter-rap' | 'third-chance' | 'reflection' | '2-spheres' | 'balls':
				diff = 'easy';
			case 't4-player':
				diff = 'uncharted';
			default:
				diff = 'unknown';
		}
		return diff;
	}

	public static function coolTextFile(path:String):Array<String>
	{
		var daList:Array<String> = Assets.getText(path).trim().split('\n');

		for (i in 0...daList.length)
		{
			daList[i] = daList[i].trim();
		}

		return daList;
	}
	
	public static function coolStringFile(path:String):Array<String>
		{
			var daList:Array<String> = path.trim().split('\n');
	
			for (i in 0...daList.length)
			{
				daList[i] = daList[i].trim();
			}
	
			return daList;
		}

	public static function dominantColor(sprite:flixel.FlxSprite):Int
	{
		var countByColor:Map<Int, Int> = [];
		for(col in 0...sprite.frameWidth){
			for(row in 0...sprite.frameHeight){
			  var colorOfThisPixel:Int = sprite.pixels.getPixel32(col, row);
			  if(colorOfThisPixel != 0){
				  if(countByColor.exists(colorOfThisPixel)){
				    countByColor[colorOfThisPixel] =  countByColor[colorOfThisPixel] + 1;
				  }else if(countByColor[colorOfThisPixel] != 13520687 - (2*13520687)){
					 countByColor[colorOfThisPixel] = 1;
				  }
			  }
			}
		 }
		var maxCount = 0;
		var maxKey:Int = 0;//after the loop this will store the max color
		countByColor[flixel.util.FlxColor.BLACK] = 0;
			for(key in countByColor.keys()){
			if(countByColor[key] >= maxCount){
				maxCount = countByColor[key];
				maxKey = key;
			}
		}
		return maxKey;
	}

	public static function numberArray(max:Int, ?min = 0):Array<Int>
	{
		var dumbArray:Array<Int> = [];
		for (i in min...max)
		{
			dumbArray.push(i);
		}
		return dumbArray;
	}
	public static function formatString(string:String):String
		{
			 var split:Array<String> = string.split('-');
			 var formattedString:String = '';
			 for (i in 0...split.length) 
			 {
				  var piece:String = split[i];
				  var allSplit = piece.split('');
				  var firstLetterUpperCased = allSplit[0].toUpperCase();
				  var substring = piece.substr(1, piece.length - 1);
				  var newPiece = firstLetterUpperCased + substring;
				  if (i != split.length - 1)
				  {
						newPiece += " ";
				  }
				  formattedString += newPiece;
			 }
			 return formattedString;
		}
}
