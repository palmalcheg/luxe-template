package luxetemplate.component;

import luxe.Component;
// import luxe.Input;
// import luxe.Log.*;
// import luxe.Sprite;
// import luxe.Vector;

import luxe.options.ComponentOptions;

class SynthObject extends Component
{
	public var sprite:Sprite;

    public function new(?_options:ComponentOptions) 
    {
        _debug("---------- SynthObject.new ----------");        

        if (_options == null) 
        {
			_options = { name : "synthobject"};
        } 
        else if (_options.name == null)
        {
            _options.name = "synthobject";
        }

        super(_options);
    }

	public override function init() 
	{
		_debug("---------- SynthObject.init ----------");   
		
	    // Bind keys
	    Luxe.input.bind_key('reset', Key.key_r);
	}

	public override function update(dt:Float) 
	{
		if(Luxe.input.inputdown('reset')) 
		{
			// Re-initialise
		}
	}
}