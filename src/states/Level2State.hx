package states;

import luxe.Color;
import luxe.Log.*;
import luxe.Text;
import luxe.resource.Resource.AudioResource;

import mint.Button;

import definitions.Enums;
import ui.MiosisMintRendering;

class Level2State extends BaseState 
{
    var button:Button;
    var music:AudioResource;
    var music_handle:luxe.Audio.AudioHandle;

	public function new() 
	{
        _debug("---------- Level2State.new ----------");

        super({ name:StateNames.Level2 });
    }

	override function onenter<T>(_:T) 
	{
        _debug("---------- Level2State.onenter ----------");

        Luxe.renderer.clear_color = new Color().rgb(GameBoyPalette2.Off);

        var rendering = new MiosisMintRendering({ batcher:Main.ui_batcher });
        button = new Button({
            parent:Main.canvas, 
            name:'button', 
            text:'two',
            rendering:rendering,
            x:0.1 * Main.w, 
            y:0.1 * Main.h, 
            w:30, 
            h:20,
            onclick:function(e,c) { on_button_click(); }
        });

        // Set up level music
        music = Luxe.resources.audio('assets/sound/POL-king-of-coins-short.wav');        
        // music_handle = Luxe.audio.loop(music.source);
               
        super.onenter(_);		
    }

    private function on_button_click()
    {
        Luxe.events.fire(EventTypes.ChangeState, { state:StateNames.Level1 });
    }

    override function onleave<T>( _data:T ) 
    {
        _debug("---------- Level2State.onleave ----------");

        super.onleave(_data);

        // CLEAN UP
        button.destroy();
        // Luxe.audio.stop(music_handle);
    }

    override function post_fade_in()
    {
        _debug("---------- Level2State.post_fade_in ----------");

        // DO STUFF
    }
}
