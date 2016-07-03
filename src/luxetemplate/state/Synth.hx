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

        Modiqus.setControlChannel('1.000001.NoteAmplitude', 0.2);
        Modiqus.sendMessage("i 1.000001 0 1 1 261.63");

		// Set background color
	    Luxe.renderer.clear_color = new Color().rgb(Constants.COLOR_GB_2_DARK);

        _circles = new Array<Circle>();

        for (i in 0...16)
        {
            var scaleMax:Float = 1.2 + Math.random() * 0.2;
            var circle:Circle = get_circle(scaleMax);
            _circles.push(circle);

            Actuate.tween(circle.scale, 1, {x : scaleMax * circle.scale.x, y : scaleMax * circle.scale.y} )
            .delay(2 + Math.random() * 2)        
            .repeat()
            .reflect()
            // .onRepeat(function(){ Modiqus.test(); })
            .ease(luxe.tween.easing.Elastic.easeIn);
        }
               
        super.onenter(_);		
    }

    private function get_circle(scale_max:Float):Circle
    {
        // TODO: use scaleMax when setting position
        var radius = Main.h * 0.05 + Math.random() * Main.h * 0.05;
        radius = Math.ffloor(radius);
        var position:Vector = new Vector();        
        var distance:Float = 0.0;
        var position_found:Bool = false;

        while (!position_found)
        {
            position.x = radius + Math.random() * (Main.w - 2 * radius);
            position.x = Math.ffloor(position.x);
            position.y = radius + Math.random() * (Main.h - 2 * radius);
            position.y = Math.ffloor(position.y);

            // log(position);
            position_found = true;

            for (i in 0..._circles.length)
            {
                distance = Vector.Subtract(_circles[i].pos, position).length;

                // log("distance1 -- " + distance);
                // log("distance2 -- " + (_circles[i].radius + radius));

                if (distance < _circles[i].radius + radius)
                {
                    position_found = false;
                    continue;
                }
            }
        }

        var color = Color.random();
        color.a = 0.4 + Math.random() * 0.2;

        var circle = new Circle({
            pos : position,
            color : color
        }, radius);

        return circle;
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
