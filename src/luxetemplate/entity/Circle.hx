package luxetemplate.entity;

import luxe.Color;
import luxe.Log.*;
import luxe.Sprite;
import luxe.Vector;
import luxe.Visual;

import luxe.options.VisualOptions;

class Circle extends Visual 
{
    public function new(?_options:VisualOptions, _radius:Float = 10) 
    {   
        _debug("---------- Circle.new ----------");

        if (_options == null) 
        {
            _debug(Main.w);
            _debug(Main.h);            
            _debug(Luxe.screen.w);
            _debug(Luxe.screen.h);       
            _options = { 
                name : "circle",
                // pos : new Vector(Luxe.screen.w / 2, Luxe.screen.h / 2),
                pos : new Vector(0.5 * Main.w, 0.5 * Main.h),             
                // pos : new Vector(0, 0),                
                color : new Color(1, 1, 1, 1)
            };
        } 
        else if (_options.name == null)
        {
            _options.name = "circle";
        }

        _options.geometry = Luxe.draw.circle({
            r : Main.w * 0.1,
            color : _options.color
        });   

        super(_options);
    }
}
