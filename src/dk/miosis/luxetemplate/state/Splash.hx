package dk.miosis.luxetemplate.state;

import luxe.Color;
import luxe.Entity;
import luxe.Input;
import luxe.Log.*;
import luxe.Sprite;
import luxe.States;
import luxe.Vector;


class Splash extends State 
{
	var letters:Array<Sprite>;

	public function new() 
	{
        super({ name:'splash' });
        letters = new Array<Sprite>();

    }

	override function onenter<T>(_:T) 
	{
		// Set background color
	    Luxe.renderer.clear_color = Constants.GAME_BOY_COLOR_DARK;

		_debug("BOOM");

		// Compute character sprite positions
		var halfscreen_width = Main.w * 0.5;
		var distance = 4;
		var width_total = 3 * 16 + 2 * 4 + 32 + 5 * distance;
		var width_total_half = 0.5 * width_total;

		// M
		var pos_x = halfscreen_width - width_total_half + 8;

	    letters.push(new Sprite({
            texture:Luxe.resources.texture('assets/img/logo/miosis_m.png'),
            pos:new Vector(pos_x, Main.h * 0.5),
            color: Constants.GAME_BOY_COLOR_OFF,
            depth:4
        }));

		// I
		pos_x += 8 + distance + 2;

	    letters.push(new Sprite({
            texture:Luxe.resources.texture('assets/img/logo/miosis_i.png'),
            pos:new Vector(pos_x, Main.h * 0.5),
            color: Constants.GAME_BOY_COLOR_OFF,
            depth:4
        }));

		// O
		pos_x += 2 + distance + 16;

	    letters.push(new Sprite({
            texture:Luxe.resources.texture('assets/img/logo/miosis_o_1.png'),
            pos:new Vector(pos_x, Main.h * 0.5),
            color: Constants.GAME_BOY_COLOR_OFF,
            depth:4
        }));

		// S
		pos_x += 16 + distance + 8;

	    letters.push(new Sprite({
            texture:Luxe.resources.texture('assets/img/logo/miosis_s.png'),
            pos:new Vector(pos_x, Main.h * 0.5),
            color: Constants.GAME_BOY_COLOR_OFF,
            depth:4
        }));

		// I
		pos_x += 8 + distance + 2;

	    letters.push(new Sprite({
            texture:Luxe.resources.texture('assets/img/logo/miosis_i.png'),
            pos:new Vector(pos_x, Main.h * 0.5),
            color: Constants.GAME_BOY_COLOR_OFF,
            depth:4
        }));

		// S
		pos_x += 2 + distance + 8;

	    letters.push(new Sprite({
            texture:Luxe.resources.texture('assets/img/logo/miosis_s.png'),
            pos:new Vector(pos_x, Main.h * 0.5),
            color: Constants.GAME_BOY_COLOR_OFF,
            depth:4
        }));

    }   
}
