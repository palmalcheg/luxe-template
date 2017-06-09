package states;

import luxe.Log.*;
import luxe.options.StateOptions;
import luxe.States;

import definitions.Enums;

typedef BaseStateOptions = 
{
    > StateOptions,
    @:optional var fade_in_time:Float;
    @:optional var fade_out_time:Float;
}

class BaseState extends State 
{
    public var fade_in_time:Float;
    public var fade_out_time:Float;    

    public function new(_options:BaseStateOptions) 
    {
        _debug("---------- BaseState.new ----------");

        if (_options.fade_in_time != null)
        {
            fade_in_time = _options.fade_in_time;
        }
        else
        {
            fade_in_time = 1;
        }

        if (_options.fade_out_time != null)
        {
            fade_out_time = _options.fade_out_time;
        }
        else
        {
            fade_out_time = 1;
        }        

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
