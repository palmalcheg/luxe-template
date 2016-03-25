package dk.miosis.luxetemplate.state;

import luxe.Log.*;

import dk.miosis.luxetemplate.utility.Bjorklund;

class Euclido extends BaseState
{
	public function new() 
    {
        _debug("---------- Euclido.new ----------");
                
        super({ name:'euclido', fade_in_time:0.5, fade_out_time:0.5 });
    }

	override function onenter<T>(_:T) 
    {
        _debug("---------- GameState.onenter ----------");

        var b  = new Bjorklund();
        b.run(16, 5);
    }
}