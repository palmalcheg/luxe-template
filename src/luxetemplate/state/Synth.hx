package luxetemplate.state;

import luxe.Color;
import luxe.Log.*;

import luxetemplate.entity.Circle;

import modiqus.Modiqus;

class Synth extends BaseState 
{
	public function new() 
	{
        _debug("---------- Synth.new ----------");

        // Modiqus.test();

        super({ name:'synth', fade_in_time:0.5, fade_out_time:0.5 });
    }

	override function onenter<T>(_:T) 
	{
        _debug("---------- Synth.onenter ----------");

		// Set background color
	    Luxe.renderer.clear_color = new Color().rgb(Constants.COLOR_GB_2_DARK);

        // Set up synth and objects
        var circle = new Circle();
               
        super.onenter(_);		
    }

    override function onleave<T>( _data:T ) 
    {
        _debug("---------- Synth.onleave ----------");
        
        super.onleave(_data);
    }

    override function post_fade_in()
    {
        _debug("---------- Synth.post_fade_in ----------");

        // Start synth tweens
    }
}
