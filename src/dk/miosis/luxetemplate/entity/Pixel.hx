package dk.miosis.luxetemplate.entity;

import luxe.Sprite;
import luxe.Vector;

class Player extends Sprite 
{
    public function new() 
    {    	
    	super({
    		name:"pixel"
            texture:Luxe.resources.texture('assets/img/pixel.png'),
            depth:4
        });
    }
}
