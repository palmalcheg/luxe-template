package states;

import luxe.Color;
import luxe.Log.*;
import luxe.Sprite;
import luxe.Text;
import luxe.Vector;

import mint.Button;

import definitions.Enums;
import ui.MiosisMintRendering;

class Level1 extends BaseState 
{
	var circle:Sprite;
    var button:Button;

	public function new() 
	{
        _debug("---------- Level1.new ----------");

        super({ name:'level1', fade_in_time:0.0, fade_out_time:0.5 });

    }

	override function onenter<T>(_:T) 
	{
        _debug("---------- Level1.onenter ----------");

		// Set background color

	    Luxe.renderer.clear_color = new Color().rgb(GameBoyPalette2.Light);
        button = new Button({
            parent : Main.canvas, 
            name : 'testbutton', 
            text : 'test',
            rendering : new MiosisMintRendering({ batcher: Main.ui_batcher }),
            x : 0.1 * Main.w, 
            y : 0.1 * Main.h, 
            w : 30, 
            h : 20
        });

        var labelRenderer:mint.render.luxe.Label = cast button.label.renderer;
        Luxe.scene.add(labelRenderer.text);

        var txt:Text = Luxe.scene.get('testbutton.label.text');    
        log('Text obj : ' + txt);  
        txt.font = Luxe.resources.font('assets/font/justabit/justabit32.fnt');
        txt.color = new Color().rgb(GameBoyPalette2.Dark);
        txt.geom.letter_snapping = true;        
        txt.geom.texture = txt.font.pages[0];
        txt.geom.texture.filter_mag = nearest;
        txt.geom.texture.filter_min = nearest;
        txt.point_size = 16;

               
        super.onenter(_);		
    }

    override function onleave<T>( _data:T ) 
    {
        _debug("---------- Level1.onleave ----------");

        // CLEAN UP
        
        super.onleave(_data);
    }

    override function post_fade_in()
    {
        _debug("---------- Splash.post_fade_in ----------");

        // DO STUFF
    }
}
