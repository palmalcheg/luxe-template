package states;

import luxe.Color;
import luxe.Log.*;
import luxe.Text;
import luxe.resource.Resource.AudioResource;

import mint.Button;

import definitions.Enums;
import ui.MiosisMintRendering;

class Level1State extends BaseState 
{
    var button:Button;
    var music:AudioResource;
    var music_handle:luxe.Audio.AudioHandle;

	public function new() 
	{
        _debug("---------- Level1State.new ----------");

        super({ name:StateNames.Level1 });
    }

	override function onenter<T>(_:T) 
	{
        _debug("---------- Level1State.onenter ----------");

        super.onenter(_);		

		// Set background color
        Luxe.renderer.clear_color = new Color().rgb(GameBoyPalette2.Off);

        button = new Button({
            parent:Main.canvas, 
            name:'testbutton', 
            text:'one',
            rendering:new MiosisMintRendering({ batcher:Main.ui_batcher }),
            x:0.1 * Main.w, 
            y:0.1 * Main.h, 
            w:30, 
            h:20,
            onclick:function(e,c) { on_button_click(); }
        });

        // Customize button label
        var labelRenderer:mint.render.luxe.Label = cast button.label.renderer;
        Main.main_scene.add(labelRenderer.text);
        var txt:Text = Main.main_scene.get('testbutton.label.text');    
        log('Text obj:' + txt);  
        txt.font = Luxe.resources.font('assets/font/justabit/justabit32.fnt');
        txt.color = new Color().rgb(GameBoyPalette2.Dark);
        txt.geom.letter_snapping = true;        
        txt.geom.texture = txt.font.pages[0];
        txt.geom.texture.filter_mag = nearest;
        txt.geom.texture.filter_min = nearest;
        txt.point_size = 16;

        // var buttonRender:MiosisButtonRender = cast button.renderer;
        // var mouse_pos = Luxe.screen.cursor.pos;
        // buttonRender.check_current_mouse_position(mouse_pos.x, mouse_pos.y);

        // Set up level music
        music = Luxe.resources.audio('assets/sound/POL-chubby-cat-short.wav');
        // music = Luxe.resources.audio('assets/sound/BeatLoop_110bpm016_8BitBeats_LoopCache.ogg');        
        // music_handle = Luxe.audio.loop(music.source);
    }

    private function on_button_click()
    {
        Luxe.events.fire(EventTypes.ChangeState, { state:StateNames.Level2 });
    }

    override function onleave<T>( _data:T ) 
    {
        _debug("---------- Level1State.onleave ----------");

        // CLEAN UP
        button.destroy();

        super.onleave(_data);
        
        // Luxe.audio.stop(music_handle);
    }

    override function post_fade_in()
    {
        _debug("---------- Level1State.post_fade_in ----------");

        // DO STUFF
    }
}
