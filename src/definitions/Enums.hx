package definitions;

@:enum abstract EventTypes(String) to String
{
    var ChangeState = "change_state";
    var ParcelLoadFailed = "parcel_load_failed";
}

@:enum abstract GameBoyPalette2(Int) to Int
{
    var Off = 0xefefef;
    var Light = 0xb2b2b2;
	var Medium = 0x757575;    
	var Dark = 0x383838;	
}