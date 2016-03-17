package dk.miosis.luxetemplate.ui;

import luxe.Log.*;
import luxe.NineSlice;
import luxe.Text;
import luxe.Vector;

import mint.Button;
import mint.Control;
import mint.render.Render;
import mint.render.Rendering;
import mint.types.Types.MouseEvent;

import dk.miosis.luxetemplate.Constants;
import dk.miosis.luxetemplate.ui.MiosisMintRendering;

class MiosisButtonRender extends Render 
{
    var visual:NineSlice;

    public function new(_rendering:Rendering, _control:Button) 
    {
        super(_rendering, _control);
        var customRendering:MiosisMintRendering = cast rendering;

        visual = new luxe.NineSlice({
            name: control.name + '.visual',
            batcher: customRendering.options.batcher,
            texture : Luxe.resources.texture('assets/img/ui/button_normal.png'),
            top : 5, left : 5, right : 5, bottom : 5,
            pos: new Vector(control.x, control.y),
            size: new Vector(control.w, control.h),
            depth: customRendering.options.depth + control.depth,
            visible: control.visible
        });

        visual.create(new Vector(control.x, control.y), control.w, control.h);
        
        control.onmouseenter.listen(goto_hover_state);
        control.onmouseleave.listen(goto_normal_state);
        control.onmousedown.listen(goto_pressed_state);
        control.onmouseup.listen(goto_normal_state);
    }

    override function onbounds() 
    {
        visual.pos = new Vector(control.x, control.y);
        visual.size = new Vector(control.w, control.h);
    }

    override function onvisible(_visible:Bool) 
    {
        visual.visible = _visible;
    }

    override function ondepth(_depth:Float) 
    {
        var customRendering:MiosisMintRendering = cast rendering;
        visual.depth = customRendering.options.depth + _depth;
    }

    override function ondestroy() 
    {
        visual.destroy();
        visual = null;
    }

    function goto_normal_state(e:MouseEvent, c:Control) 
    {
        var b:Button = cast control;
        visual.texture = Luxe.resources.texture('assets/img/ui/button_normal.png');        

        if (e.button == none) 
        {
            // mouseleave
            var txt:Text = Luxe.scene.get('testbutton.label.text'); 
            txt.color = Constants.GAME_BOY_COLOR_DARK;
        }
    }

    function goto_hover_state(e:MouseEvent, c:Control) 
    {
        var txt:Text = Luxe.scene.get('testbutton.label.text'); 
        txt.color = Constants.GAME_BOY_COLOR_MEDIUM;
    }

    function goto_pressed_state(e:MouseEvent, c:Control) 
    {
        visual.texture = Luxe.resources.texture('assets/img/ui/button_pressed.png');
    }
}
