package luxetemplate.state;

import luxe.Color;
import luxe.Log.*;
import luxe.Sprite;
import luxe.Vector;

class Level1 extends BaseState 
{
	var circle:Sprite;

	public function new() 
	{
        _debug("---------- Level1.new ----------");

        super({ name:'level1', fade_in_time:0.0, fade_out_time:0.5 });

    }

	override function onenter<T>(_:T) 
	{
        _debug("---------- Level1.onenter ----------");

		// Set background color
	    Luxe.renderer.clear_color = new Color().rgb(Constants.COLOR_GB_1_LIGHT);
               
        super.onenter(_);		
    }

    override function onleave<T>( _data:T ) 
    {
        _debug("---------- Level1.onleave ----------");

        // CLEAN UP
        
        super.onleave(_data);
    }

    override function post_fade_in()
    {
        _debug("---------- Splash.post_fade_in ----------");

        // DO STUFF
    }
}
