package dk.miosis.luxetemplate.state;

import luxe.Color;
import luxe.components.sprite.SpriteAnimation;
import luxe.Entity;
import luxe.Input;
import luxe.Log.*;
import luxe.Sprite;
import luxe.States;
import luxe.Vector;
import luxe.resource.Resource;

import luxe.Parcel;
import luxe.ParcelProgress;

import snow.api.Promise;

class Load extends BaseState 
{
	public function new() 
	{
        _debug("---------- Load.new ----------");

        super({ name:'load', fade_in_time:0.0, fade_out_time:0.0 });
    }

	override function onenter<T>(_:T) 
	{
        _debug("---------- Load.onenter ----------");     

		// Set background color
	    Luxe.renderer.clear_color = Constants.GAME_BOY_COLOR_DARK;

        var promise_json:Promise = Luxe.resources.load_json("assets/parcel.json");
        promise_json.then(load_assets);
               
        super.onenter(_);		
    }

   function load_assets(json:JSONResource) 
    {
        _debug("---------- Load.load_assets ----------");

        var parcel:Parcel = new Parcel();
        parcel.from_json(json.asset.json);

        new ParcelProgress({
            parcel: parcel,
            bar : Constants.GAME_BOY_COLOR_OFF,
            bar_border  : Constants.GAME_BOY_COLOR_MEDIUM,            
            background  : Constants.GAME_BOY_COLOR_DARK,
            oncomplete: on_parcel_loaded
        });
        
        parcel.load();        
    }

    function on_parcel_loaded(e)
    {
        _debug("---------- Load.on_anim_done ----------");

        Luxe.events.fire('change_state', { state : 'game', fade_in_time : fade_in_time, fade_out_time : fade_out_time });
    } 
}
