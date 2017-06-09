package components;

import luxe.Log.*;
import luxe.Sprite;

import luxe.options.ComponentOptions;

class Fader extends luxe.Component 
{
    private var _sprite:Sprite;

    public function new(?options:ComponentOptions) 
    {
        _debug("---------- Fader.new ----------");  

        def(options, { name : 'fade'});
        def(options.name, 'fade');      

        super(options);
    }

    override function onadded() 
    {
        _debug("---------- Fader.onadded ----------");

        _sprite = cast entity;
    }

    public function fade_in(?t = 0.15, ?fn:Void->Void) 
    {
        _debug("---------- Fader.fade_in ----------");

        _sprite.color.tween(t, { a : 0 }).onComplete(fn);
    }

    public function fade_out(?t = 0.15, ?fn:Void->Void) 
    {
        _debug("---------- Fader.fade_out ----------");
                
        _sprite.color.tween(t, { a : 1 }).onComplete(fn);
    }

    override function onremoved()
    {
        _debug("---------- Fader.onremoved ----------");
        _debug(entity);
    }

    override function ondestroy() 
    {
        _debug("---------- Fader.ondestroy ----------");
        _debug(entity);        
    }
}
