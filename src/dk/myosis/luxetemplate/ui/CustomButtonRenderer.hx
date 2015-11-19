package dk.myosis.luxetemplate.ui;

import luxe.Color;
import luxe.NineSlice;
import luxe.Vector;

import mint.Button;
import mint.render.Render;
import mint.render.Rendering;

import dk.myosis.luxetemplate.Constants;

class CustomButtonRenderer extends Render {
    var _button:Button;
    var _visual:NineSlice;

    public function new(rendering:Rendering, button:Button) {
        super(rendering, button);
        _button = button;

        _visual = new luxe.NineSlice({
            name: button.name + '.visual',
            texture : Luxe.resources.texture('assets/img/ui/gb_button.png'),
            top : 5, left : 5, right : 5, bottom : 5,
            color : Constants.GAME_BOY_COLOR_LIGHT
        });

        _visual.create(new Vector(_button.x, _button.y), _button.w, _button.h);
    }

    override function onvisible(_visible:Bool) {
        _visual.visible = _visible;
    }

    override function ondepth(_depth:Float) {
        _visual.depth = _depth;
    }

    override function ondestroy() {
        _visual.destroy();
        _visual = null;
    }

}
