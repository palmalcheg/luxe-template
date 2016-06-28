package luxetemplate.state;

import luxe.Color;
import luxe.Log.*;
import luxe.Sprite;
import luxe.Vector;
import luxe.tween.Actuate;

import luxetemplate.entity.Circle;

import modiqus.Modiqus;

class Synth extends BaseState 
{
    var _circles:Array<Circle>;

	public function new() 
	{
        _debug("---------- Synth.new ----------");

        super({ name:'synth', fade_in_time:0.5, fade_out_time:0.5 });
    }

	override function onenter<T>(_:T) 
	{
        _debug("---------- Synth.onenter ----------");

		// Set background color
	    Luxe.renderer.clear_color = new Color().rgb(Constants.COLOR_GB_2_DARK);

        _circles = new Array<Circle>();

        for (i in 0...16)
        {
            var color = Color.random();
            color.a = Math.random();

            var circle = new Circle({
                pos : new Vector(Math.random() * Main.w, Math.random() * Main.h),
                color : color
            });

            _circles.push(circle);

            Actuate.tween(circle.scale, 1, {x : 1.2 * circle.scale.x, y : 1.2 * circle.scale.y} )
            .delay(2 + Math.random() * 2)        
            .repeat()
            .reflect()
            .onRepeat(function(){ Modiqus.test(); })
            .ease(luxe.tween.easing.Elastic.easeIn);
        }
               
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
    }
}
