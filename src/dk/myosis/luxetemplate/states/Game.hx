package dk.myosis.luxetemplate.states;

import luxe.Color;
import luxe.Input;
import luxe.Log.*;
import luxe.Sprite;
import luxe.States;
import luxe.Vector;

import phoenix.Batcher;
import phoenix.Texture;

import dk.myosis.luxetemplate.Constants;

class Game extends State {

	public function new() {
        super({ name:'game' });
    }

	override function onenter<T>(_:T) {
        // Set background color
        Luxe.renderer.clear_color = Constants.GAME_BOY_COLOR_OFF;
    }

	override function onkeyup(e:KeyEvent) {
        if(e.keycode == Key.escape) {
            Luxe.shutdown();
        }
    }
    
}
