package states;

import luxe.Color;
import luxe.Log.*;
import luxe.Sprite;
import luxe.Text;
import luxe.Vector;
import luxe.resource.Resource.AudioResource;

import mint.Button;

import definitions.Enums;
import ui.MiosisMintRendering;

class Level2 extends BaseState 
{
	var circle:Sprite;
    var button:Button;
    var music: AudioResource;
    var music_handle: luxe.Audio.AudioHandle;

	public function new() 
	{
        _debug("---------- Level2.new ----------");

        super({ name:'level2' });
    }

	override function onenter<T>(_:T) 
	{
        _debug("---------- Level2.onenter ----------");

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
            h : 20,
            onclick: function(e,c) { on_button_click(); }
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

        // Set up level music
        music = Luxe.resources.audio('assets/sound/BeatLoop_110bpm024_8BitBeats_LoopCache.ogg');        
        music_handle = Luxe.audio.loop(music.source);
               
        super.onenter(_);		
    }

    private function on_button_click()
    {
        Luxe.events.fire(EventTypes.ChangeState, { state : "level1" });
    }

    override function onleave<T>( _data:T ) 
    {
        _debug("---------- Level2.onleave ----------");

        // CLEAN UP
        Luxe.audio.stop(music_handle);
        
        super.onleave(_data);
    }

    override function post_fade_in()
    {
        _debug("---------- Level2.post_fade_in ----------");

        // DO STUFF
    }
}
