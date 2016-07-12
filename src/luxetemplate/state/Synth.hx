package luxetemplate.state;

import luxe.Color;
import luxe.Log.*;
import luxe.Sprite;
import luxe.Vector;
import luxe.tween.Actuate;
import luxe.tween.actuators.GenericActuator;

import luxetemplate.entity.Circle;

import modiqus.Modiqus;

class Synth extends BaseState 
{
    var _circles:Array<Circle>;
    var _circleDelays:Array<Float>;
    var _circleTweenTimes:Array<Float>;
    var _circleTweenActive:Array<Bool>;    
    var _tweens:Array<IGenericActuator>;

    var _objectCount:Int;

	public function new() 
	{
        _debug("---------- Synth.new ----------");

        _objectCount = 30;

        super({ name:'synth', fade_in_time:0.5, fade_out_time:0.5 });
    }

	override function onenter<T>(_:T) 
	{
        _debug("---------- Synth.onenter ----------");

        Modiqus.setControlChannel('1.000001.NoteAmplitude', 0.2);
        Modiqus.sendMessage("i 1.000001 0 1 1 261.63");

		// Set background color
	    Luxe.renderer.clear_color = new Color().rgb(Constants.COLOR_GB_2_LIGHT);

        _circles = new Array<Circle>();
        _circleDelays = new Array<Float>();
        _circleTweenTimes = new Array<Float>();
        _tweens = new Array<IGenericActuator>();
        _circleTweenActive = new Array<Bool>();

        for (i in 0..._objectCount)
        {
            var scaleMax:Float = 1 + Math.random();

            _circles.push(get_circle(i, scaleMax));

            var tween = Actuate.tween(_circles[i].scale, 0.5 + Math.random(), {x : scaleMax * _circles[i].scale.x, y : scaleMax * _circles[i].scale.y} )
            .reflect()
            .repeat()
            .onRepeat(on_tween_repeat, [ i ])
            .ease(luxe.tween.easing.Elastic.easeIn);
            // .ease(luxe.tween.easing.Linear.easeNone);            
            // .ease(luxe.tween.easing.Cubic.easeIn);                        

            Actuate.pause(tween);
            _tweens.push(tween);

            _circleDelays.push(Math.random() * 2);
            _circleTweenTimes.push(0);
            _circleTweenActive[i] = false;

            _debug(_circles[i].scale);          
        }

        super.onenter(_);		
    }

    private function get_circle(i:Int, scale_max:Float):Circle
    {
        // TODO: use scaleMax when setting position
        var radius = Main.h * 0.05 + Math.random() * Main.h * 0.05;
        // var radius = Main.h * 0.05;        
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

            position_found = true;

            for (i in 0..._circles.length)
            {
                distance = Vector.Subtract(_circles[i].pos, position).length;

                // log("distance1 -- " + distance);
                // log("distance2 -- " + (_circles[i].radius + radius));

                if (distance < radius)
                {
                    position_found = false;
                    continue;
                }
            }
        }

        var color = Color.random();
        color.a = 0.5 + Math.random() * 0.2;

        var circle = new Circle({
            name : "circle" + i,
            pos : position,
            color : color
        }, radius);

        return circle;
    }

    private function on_tween_repeat(i:Int)
    {
        Actuate.pause(_tweens[i]);
        _circleTweenActive[i] = false;
        var color = Color.random();
        // _circles[i].color = color;
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

    public override function update(dt:Float) 
    {
        for (i in 0..._objectCount)
        {
            if (_circleTweenActive[i])
            {
                // Tweak audio params
                // log(_circles[i].scale);
            }
            else
            {
                _circleTweenTimes[i] += dt;                
            }

            if (_circleTweenTimes[i] >= _circleDelays[i])
            {
                Actuate.resume(_tweens[i]);
                _circleTweenTimes[i] = Math.random() * 8;
                _circleTweenActive[i] = true;
            }
        }
    }
}
