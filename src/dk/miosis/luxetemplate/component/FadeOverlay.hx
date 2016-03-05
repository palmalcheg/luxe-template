package dk.miosis.luxetemplate.component;

import luxe.Color;
import luxe.Sprite;

class FadeOverlay extends luxe.Component 
{
    var sprite:Sprite;

    override function init() 
    {
        sprite = cast entity;
        fade_in(0.5);
    }

    public function fade_in(?t=0.15,?fn:Void->Void) 
    {
        sprite.color.tween(t, {a:0}).onComplete(fn);
    }

    public function fade_out(?t=0.15,?fn:Void->Void) 
    {
        sprite.color.tween(t, {a:1}).onComplete(fn);
    }

    override function ondestroy() 
    {
        sprite.destroy( );
    }
}
