package states;

import luxe.Log.*;
import luxe.options.StateOptions;
import luxe.States;

import definitions.Enums;

typedef BaseStateOptions = 
{
    > StateOptions,
    @:optional var transition_in_time:Float;
    @:optional var transition_out_time:Float;
}

class BaseState extends State 
{
    public var transition_in_time:Float;
    public var transition_out_time:Float; 

    public function new(_options:BaseStateOptions) 
    {
        _debug("---------- BaseState.new ----------");

        def(_options.transition_in_time, 1);
        def(_options.transition_out_time, 1);

        transition_in_time = _options.transition_in_time;
        transition_out_time = _options.transition_out_time;

        super(_options);
    }

    override function onenter<T>(_:T) 
    {
        _debug("---------- BaseState.onenter ----------");     

        Luxe.events.fire(EventTypes.StateReady, { state:name });
               
        super.onenter(_);       
    }

    public function post_fade_in()
    {
        // DO STUFF
    }
}
