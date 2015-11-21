package dk.myosis.luxetemplate.ui;

import luxe.Color;
import luxe.Log.*;
import luxe.NineSlice;
import luxe.Vector;

import mint.Button;
import mint.render.Render;
import mint.render.Rendering;

import dk.myosis.luxetemplate.Constants;
import dk.myosis.luxetemplate.ui.MyosisMintRendering;

private typedef MyosisButtonOptions = {
    var color: Color;
    var color_hover: Color;
    var color_down: Color;
}

class MyosisButtonRender extends Render {
    public var color: Color;
    public var color_hover: Color;
    public var color_down: Color;

    var visual:NineSlice;

    public function new(_rendering:Rendering, _control:Button) {
        super(_rendering, _control);
        var customRendering:MyosisMintRendering = cast rendering;

        visual = new luxe.NineSlice({
            name: control.name + '.visual',
            batcher: customRendering.options.batcher,
            texture : Luxe.resources.texture('assets/img/ui/gb_button.png'),
            top : 5, left : 5, right : 5, bottom : 5,
            pos: new Vector(control.x, control.y),
            size: new Vector(control.w, control.h),
            color: color,
            depth: customRendering.options.depth + control.depth,
            visible: control.visible,
        });

        visual.create(new Vector(control.x, control.y), control.w, control.h);

        var _opt: MyosisButtonOptions = _control.options.options;

        color = def(_opt.color, new Color().rgb(0x373737));
        color_hover = def(_opt.color_hover, new Color().rgb(0x445158));
        color_down = def(_opt.color_down, new Color().rgb(0x444444));
        
        control.onmouseenter.listen(function(e,c) { visual.texture = Luxe.resources.texture('assets/img/ui/gb_button_hover.png'); });
        control.onmouseleave.listen(function(e,c) { visual.texture = Luxe.resources.texture('assets/img/ui/gb_button.png'); });
        control.onmousedown.listen(function(e,c) { visual.texture = Luxe.resources.texture('assets/img/ui/gb_button_pressed.png'); });
        control.onmouseup.listen(function(e,c) { visual.texture = Luxe.resources.texture('assets/img/ui/gb_button.png'); });
    }

    override function onbounds() {
        visual.pos = new Vector(control.x, control.y);
        visual.size = new Vector(control.w, control.h);
    }

    override function onvisible(_visible:Bool) {
        visual.visible = _visible;
    }

    override function ondepth(_depth:Float) {
        var customRendering:MyosisMintRendering = cast rendering;
        visual.depth = customRendering.options.depth + _depth;
    }

    override function ondestroy() {
        visual.destroy();
        visual = null;
    }

}
