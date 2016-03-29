package dk.miosis.luxetemplate.state;

import luxe.Color;
import luxe.Entity;
import luxe.Log.*;
import luxe.Visual;

import dk.miosis.luxetemplate.component.EuclidianSequencer;
import dk.miosis.luxetemplate.component.EuclidianVisualiser;

class Euclido extends BaseState
{
    var rhythm_sequencer:EuclidianSequencer;
    var rhythm_visualiser:EuclidianVisualiser;

	public function new() 
    {
        _debug("---------- Euclido.new ----------");
                
        super({ name : 'euclido', fade_in_time : 4.5, fade_out_time : 0.5 });
    }

	override function onenter<T>(_:T) 
    {
        _debug("---------- Euclido.onenter ----------");

        Luxe.renderer.clear_color = new Color().rgb(Constants.COLOR_BLUE);

        var rhythm_parent = new Entity({ name: 'euclidian_rhythm'});

        rhythm_sequencer = new EuclidianSequencer(4, 110, 4);

        rhythm_visualiser = new EuclidianVisualiser({
            layer_distance : 5.0, 
            point_radius : 2.0
        });
        
        rhythm_parent.add(rhythm_sequencer);        
        rhythm_parent.add(rhythm_visualiser);

        super.onenter(_);       
    }

    override function onleave<T>( _data:T ) 
    {
        _debug("---------- Euclido.onleave ----------");
        
        // Clean up

        super.onleave(_data);
    }

    override function update(dt:Float)
    {
        

    }   
}