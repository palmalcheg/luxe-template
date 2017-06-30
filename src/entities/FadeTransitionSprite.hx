package entities;

import luxe.Color;
import luxe.Log.*;
import luxe.Sprite;

import definitions.Enums;

class FadeTransitionSprite extends Sprite 
{
    public function new() 
    {   
        _debug("---------- FadeTransitionSprite.new ----------");

    	super({
            name :'fade-transition-sprite',
            batcher :Main.foreground_batcher,
            parent :Luxe.camera,
            size :Luxe.screen.size,
            color :new Color().rgb(GameBoyPalette2.Dark),
            centered :false
        });
    }
}
