package;

import flixel.group.FlxSpriteGroup;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.FlxObject;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.math.FlxMath;

class CreditPopup extends FlxSpriteGroup
{
    public var bitchyBalls:FlxSprite;

    public function new(x:Float, y:Float, songy:String)
    {
        super(x, y);
        bitchyBalls = new FlxSprite().makeGraphic(300, 50, FlxColor.WHITE);
        bitchyBalls.alpha = 0.6;
        add(bitchyBalls);

        var funnyText:FlxText = new FlxText(1, 0, 650, 'Placeholder', 16);
        funnyText.setFormat('Comic Sans MS Bold', 32, FlxColor.BLACK, LEFT);
        switch(songy.toLowerCase())
        {
            case 'disruption' | 'applecore' | 'disability' | 'algebra' | 'future' | 'nice' | 'resumed' | 'sugar-rush' | 'recovered-project' | 'dave-x-bambi-shipping-cute' | 'bookworm' | 'the-big-dingle':
                funnyText.text = 'Song by Grantare';
            case 'ferocious':
                funnyText.text = 'Song by Grantare\nOriginal Mod by Jumpman25';
                bitchyBalls.scale.set(1.75, 2);
                bitchyBalls.y += 35;
                bitchyBalls.x += 10;
            case 'wireframe' | 'origin' | 'tantalum' | 'keyboard' | 'corrupted-file' | 'genocidal' | 'krunker' | 'galactic' | 'you-cheated' | 'sick-tricks' | 'the-boopadoop-song':
                funnyText.text = 'Song by Cynda';
            case 'pool-party' | 'deformation':
                funnyText.text = 'Song by Cynda and Aadsta';
                bitchyBalls.scale.set(2.25, 1);
            case 'jambino' | 'fresh-and-toasted':
                funnyText.text = 'Song by R34D34L';
            case 'cuberoot' | 'og' | 'production' | 'cheating-not-cute' | 'dale' | 'ticking' | 'apprentice':
                funnyText.text = 'Song by Aadsta';
            case 'nft' | 'upcoming-cop' | 'enforcers' | 'cell' | 'alternate':
                funnyText.text = 'Song by Wildy';
            case 'cooking-lesson':
                funnyText.text = 'Song by Alexander Cooper 19';
                bitchyBalls.scale.set(2.25, 1);
            case 'wheels' | 'speed' | 'unhinged' | 'underscore' | 'poopers':
                funnyText.text = 'Song by Ruby';
            case 'awesome':
                funnyText.text = 'Song by Ruby and Aadsta';
            case 'theft' | 'hiccup' | 'corndog':
                funnyText.text = 'Song by NLee';
            case 'slices':
                funnyText.text = 'Song by Top 10 Awesome';
                bitchyBalls.scale.set(1.5, 1);
            case 'penis':
                funnyText.text = "Lovely Stories Told by Our Beloved Penis Elf!";
                bitchyBalls.scale.set(3, 1);
            case 'strawberry':
                funnyText.text = 'Song by Cynda and Grantare';
                bitchyBalls.scale.set(2.25, 1);
            case 'ready-loud' | 'comecful':
                funnyText.text = 'Song by MoldyGH';
            case 'grantare-sings-unfairness':
                funnyText.text = 'Song by MoldyGH\nImprovement by Grantare';
                bitchyBalls.scale.set(1.5, 2);
            case 'gift-card':
                funnyText.text = 'Song by Cval';
            case 'too-shiny' | 'kirbathon':
                funnyText.text = 'Song by Gorbini';
            case 'cycles':
                funnyText.text = 'Song by Vania';
            case 'left-unchecked':
                funnyText.text = 'Song by Adam McHummus';
                bitchyBalls.scale.set(1.25, 1);
            case 'sunshine' | 'triple-trouble':
                funnyText.text = 'Song by MarStarBro';
                bitchyBalls.scale.set(1.25, 1);
            case 'thunderstorm':
                funnyText.text = 'Song by Saruky';
            case 'the-boss':
                funnyText.text = 'Song by Pastel';
            case 'collision':
                funnyText.text = 'Song by BeastlyChip'; 
                bitchyBalls.scale.set(1.15, 1);
            case 'sillier':
                funnyText.text = 'Song by Bmv277';
        }
        add(funnyText);
    }
}