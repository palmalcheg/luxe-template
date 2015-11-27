package dk.miosis.luxetemplate.entities;

import luxe.Color;
import luxe.Sprite;
import luxe.Vector;

class Overlay extends Sprite {

    public function new() {    	
    	super({
            texture:Luxe.resources.texture('assets/img/pixel.png'),
            pos:new Vector(Main.w * 0.5, Main.h * 0.5),
            color:new Color(0, 0 ,0, 0.5),
            size: new Vector(Main.w - 10, Main.h - 10, 1),
            depth:20
        });
    }
}