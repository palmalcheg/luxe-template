package states;

import luxe.Log.*;
import luxe.options.StateOptions;
import luxe.Scene;
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

    private var _scene :Scene;

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

        super.onenter(_);       

        _scene = new Scene(this.name);  

        Luxe.events.fire(EventTypes.StateReady, { state :name });
    }

    override function onleave<T>(_:T) 
    {
        _debug("---------- BaseState.onleave ----------");

        if (Luxe.core.shutting_down)
        {
            return;
        }

        _scene.empty();

        if (!_scene.destroyed)
        {
            _scene.destroy();
        }

        _scene = null;
    }

    public function post_fade_in()
    {
        // DO STUFF
    }
}
