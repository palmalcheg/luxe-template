package dk.myosis.luxetemplate.ui;

import luxe.options.RenderProperties;
import luxe.Log.*;

import mint.Button;
import mint.Control;
import mint.render.Rendering;

class MyosisMintRendering extends Rendering {

	public var options:RenderProperties;

    public function new(?_options:RenderProperties) {
        super();

        options = def(_options, {});
        def(options.batcher, Luxe.renderer.batcher);
        def(options.depth, 0);
        def(options.immediate, false);
        def(options.visible, true);
    }

    override function get<T:Control, T1>( _type:Class<T>, _control:T ) : T1 {
        return cast switch(_type) {
            case Button: new MyosisButtonRender(this, cast _control);
            case _: null;
        }
    }

}