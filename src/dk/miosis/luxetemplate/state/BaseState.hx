package dk.miosis.luxetemplate.state;

import luxe.Color;
import luxe.Entity;
import luxe.Input;
import luxe.options.StateOptions;
import luxe.States;
import luxe.Vector;


import dk.miosis.luxetemplate.component.FadeOverlay;

class BaseState extends State 
{
    var overlay:FadeOverlay;

    public function new(options:StateOptions) 
    {
        super(options);
    }

    override function onenter<T>(_:T) 
    {
        overlay = Luxe.camera.add(new FadeOverlay({ name:'fade' }));
        overlay.fade_in(0.5);
    }    
}
