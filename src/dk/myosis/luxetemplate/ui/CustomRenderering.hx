package dk.myosis.luxetemplate.ui;

import mint.Button;
import mint.Control;
import mint.render.Rendering;

class CustomRendering extends Rendering {

    override function get<T:Control, T1>( type:Class<T>, control:T ) : T1 {
        return cast switch(type) {
            case Button: new CustomButtonRenderer(this, cast control);
            case _: null;
        }
    }

}