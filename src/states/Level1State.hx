package states;

import luxe.Color;
import luxe.Log.*;
import luxe.resource.Resource.AudioResource;

import mint.Button;

import definitions.Enums;

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
            name:'button', 
            text:'one',
            rendering:Main.mint_renderer,
            x:0.1 * Main.w, 
            y:0.1 * Main.h, 
            w:30, 
            h:20,
            onclick:function(e,c) { on_button_click(); }
        });

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

        super.onleave(_data);
        
        // Luxe.audio.stop(music_handle);
    }

    override function post_fade_in()
    {
        _debug("---------- Level1State.post_fade_in ----------");

        // DO STUFF
    }
}
