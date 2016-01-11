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
    var _overlay:FadeOverlay;

    public function new(options:StateOptions) 
    {
        super(options);
    }

    override function onenter<T>(_:T) 
    {
        _overlay = Luxe.camera.add(new FadeOverlay({ name:'fade' }));
    }    
}
