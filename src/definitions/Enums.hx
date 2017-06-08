package definitions;

@:enum abstract SplashAssets(String) to String
{
    var LetterMTexture    = "assets/texture/logo/miosis_m.png";
    var LetterITexture    = "assets/texture/logo/miosis_i.png";
    var LetterOTexture    = "assets/texture/logo/miosis_o.png";    
    var LetterSTexture    = "assets/texture/logo/miosis_s.png";        
    var LogoAnimationJson = "assets/json/animation/splash_anim.json";            
}

@:enum abstract EventTypes(String) to String
{
    var ChangeState = "change_state";
    var ParcelLoadFailed = "parcel_load_failed";
}

@:enum abstract BasicColors(Int) to Int
{
    var Black = 0x000000;
    var White = 0xffffff;  
    var Red = 0xFF0000;
    var Green = 0x00FF00;
    var Blue = 0x0000FF;  
}

// 	Game Boy palette, gray 1
@:enum abstract GameBoyPaletteGray1(Int) to Int
{
    var Off = BasicColors.Black;
    var Light = 0xb2b2b2;
	var Medium = 0x757575;    
	var Dark = BasicColors.White;	
}

// 	Game Boy palette, gray 2
@:enum abstract GameBoyPalette2(Int) to Int
{
    var Off = 0xefefef;
    var Light = 0xb2b2b2;
	var Medium = 0x757575;    
	var Dark = 0x383838;	
}

// CGA Palette 0, low intensity
@:enum abstract CGAPalette0Low(Int) to Int
{
    var Black = BasicColors.Black;
    var Cyan = 0x00aaaa;
	var Magenta = 0xaa00aa;    
	var LightGray = 0xaaaaaa;	
}

// CGA Palette 0, high intensity
@:enum abstract CGAPalette0High(Int) to Int
{
    var Black = BasicColors.Black;
    var LightCyan = 0x55ffff;
	var LightMagenta = 0xff55ff;    
	var White = BasicColors.White;	
}

// CGA Palette 1, low intensity
@:enum abstract CGAPalette1Low(Int) to Int
{
    var Black = BasicColors.Black;
    var Green = 0x00aa00;
	var Red = 0xaa0000;    
	var Brown = 0xaa5500;	
}

// CGA Palette 1, high intensity
@:enum abstract CGAPalette1High(Int) to Int
{
    var Black = BasicColors.Black;
    var LightGreen = 0x55ff55;
	var LightRed = 0xff5555;    
	var Yellow = 0xffff55;	
}