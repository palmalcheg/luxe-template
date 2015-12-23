package dk.miosis.luxetemplate.state;

import luxe.States;
import luxe.Input;
import luxe.Entity;
import luxe.Vector;
import luxe.Color;

class Splash extends State {

	public function new() {
        super({ name:'splash' });
    }

	override function onenter<T>(_:T) {
		// Set background color
        Luxe.renderer.clear_color = new Color().rgb(0x000000);
    }
    
}