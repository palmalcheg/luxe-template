package system;

import luxe.Color;

import definitions.Enums;

class GameBoyPalette
{
    private var _paletteType:GameBoyPaletteType;
    private static var _palette:haxe.ds.Vector<Color>;

	public function new(type:GameBoyPaletteType) 
	{
        _palette = new haxe.ds.Vector<Color>(4);
        set_palette_type(type);
    }

    public function get_palette_type()
    {
        return _paletteType;
    }
    
    public function set_palette_type(type:GameBoyPaletteType)
    {
        _paletteType = type;
        
        switch (type)
        {
            case GB1:
            {
                _palette[0] = new Color().rgb(GameBoyPalette1.Off);
                _palette[1] = new Color().rgb(GameBoyPalette1.Light);
                _palette[2] = new Color().rgb(GameBoyPalette1.Medium);                
                _palette[3] = new Color().rgb(GameBoyPalette1.Dark);
            } 
            case GB2:
            {
                _palette[0] = new Color().rgb(GameBoyPalette2.Off);
                _palette[1] = new Color().rgb(GameBoyPalette2.Light);
                _palette[2] = new Color().rgb(GameBoyPalette2.Medium);                
                _palette[3] = new Color().rgb(GameBoyPalette2.Dark);
            }                                   
            default :
            {
                throw "Unknown Game Boy palette type " + type;
            }
        }
    }

    public static function get_color(index:Int)
    {
        return _palette[index];
    }
}