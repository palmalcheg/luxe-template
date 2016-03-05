package dk.miosis.luxetemplate.state;

import luxe.Color;
import luxe.Entity;
import luxe.options.StateOptions;
import luxe.Sprite;
import luxe.States;

import dk.miosis.luxetemplate.component.FadeOverlay;

class BaseState extends State 
{
    var fade_overlay:FadeOverlay;    

    public function new(options:StateOptions) 
    {
        super(options);
    }

    override function onenter<T>(_:T) 
    {
        var fade_overlay_sprite = new Sprite({
            size: Luxe.screen.size,
            color: new Color(0,0,0,1),
            centered: false,
            depth:99
        });

        fade_overlay = fade_overlay_sprite.add(new FadeOverlay({ name:'fade' }));
    }    
}
