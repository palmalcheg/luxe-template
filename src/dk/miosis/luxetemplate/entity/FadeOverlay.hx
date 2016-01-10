package dk.miosis.luxetemplate.entity;

import luxe.Color;
import luxe.Sprite;
import luxe.Vector;

class FadeOverlay extends Sprite 
{
    public function new() 
    {    	
    	super({
            size: Luxe.screen.size,
            color: new Color(0,0,0,1),
            centered: false,
            depth:99
        });
    }
}
