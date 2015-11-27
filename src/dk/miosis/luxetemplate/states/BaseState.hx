package dk.miosis.luxetemplate.states;

import luxe.Color;
import luxe.Entity;
import luxe.Input;
import luxe.options.StateOptions;
import luxe.States;
import luxe.Vector;


import dk.miosis.luxetemplate.entities.Overlay;

class BaseState extends State {

	var _overlay:Overlay;

	public function new(options:StateOptions) {
        super(options);
    }

	override function onenter<T>(_:T) {
		_overlay = new Overlay();
    }
    
}