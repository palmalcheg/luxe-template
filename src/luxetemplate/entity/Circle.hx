package luxetemplate.entity;

import luxe.Color;
import luxe.Log.*;
import luxe.Sprite;
import luxe.Vector;
import luxe.Visual;

import luxe.options.VisualOptions;

class Circle extends Visual 
{
    public var radius:Float;

    public function new(?_options:VisualOptions, _radius:Float = 10) 
    {   
        _debug("---------- Circle.new ----------");

        radius = _radius;

        if (_options == null) 
        {
            _options = { 
                name : "circle",
                pos : new Vector(0.5 * Main.w, 0.5 * Main.h),
                color : new Color(1, 1, 1, 1)
            };
        } 
        else if (_options.name == null)
        {
            _options.name = "circle";
        }

        _options.geometry = Luxe.draw.circle({
            r : radius,
            color : _options.color
        });   

        super(_options);
    }
}
