package definitions;

@:enum abstract EventTypes(String) to String
{
    var ChangeState = "change_state";
    var ParcelLoadFailed = "parcel_load_failed";
}

@:enum abstract BasicColors(Int) to Int
{
    var Black = 0x000000;
    var White = 0xffffff;    
}

@:enum abstract GameBoyPalette2(Int) to Int
{
    var Off = 0xefefef;
    var Light = 0xb2b2b2;
	var Medium = 0x757575;    
	var Dark = 0x383838;	
}

@:enum abstract CGAPalette0Low(Int) to Int
{
    var Black = BasicColors.Black;
    var Cyan = 0x00aaaa;
	var Magenta = 0xaa00aa;    
	var Dark = 0xaaaaaa;	
}

@:enum abstract CGAPalette0High(Int) to Int
{
    var Black = BasicColors.Black;
    var Cyan = 0x55ffff;
	var Magenta = 0xff55ff;    
	var Dark = BasicColors.White;	
}