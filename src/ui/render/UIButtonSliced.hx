package ui.render;

import luxe.Log.*;
import luxe.NineSlice;
import luxe.Scene;
import luxe.Vector;

import mint.Button;
import mint.Control;
import mint.render.Render;
import mint.render.Rendering;
import mint.types.Types.MouseEvent;

import ui.UIRendering;

class UIButtonSliced extends Render 
{
    private var visual:NineSlice;

    public function new(_rendering:Rendering, _control:Button, _scene:Scene) 
    {
        _debug("---------- UIButtonSliced.new ----------");

        super(_rendering, _control);
        var customRendering:UIRendering = cast rendering;

        // log(control.x);
        // log(control.y);
        // log(control.w);
        // log(control.h);        

        visual = new luxe.NineSlice({
            scene:_scene,
            name:control.name + '.visual',
            batcher:customRendering.options.batcher,
            texture:Luxe.resources.texture('assets/texture/ui/gb_button_normal.png'),
            top:5, left:5, right:5, bottom:5,
            pos:new Vector(control.x, control.y),
            size:new Vector(control.w, control.h),
            depth:customRendering.options.depth + control.depth,
            visible:control.visible
        });
        visual.create(new Vector(control.x, control.y), control.w, control.h);
        
        control.onmouseenter.listen(on_mouse_enter);
        control.onmouseleave.listen(on_mouse_leave);
        control.onmousedown.listen(on_mouse_down);
        control.onmouseup.listen(on_mouse_up);
        control.onmousemove.listen(on_mouse_move);  
    }

    override function onbounds() 
    {
        visual.pos = new Vector(control.x, control.y);
        visual.size = new Vector(control.w, control.h);
    }

    override function onvisible(_visible:Bool) 
    {
        _debug("---------- UIButtonSliced.onvisible ----------");

        visual.visible = _visible;      
    }

    override function ondepth(_depth:Float) 
    {
        var customRendering:UIRendering = cast rendering;
        visual.depth = customRendering.options.depth + _depth;
    }

    override function ondestroy() 
    {
        control.onmouseenter.remove(on_mouse_enter);
        control.onmouseleave.remove(on_mouse_leave);
        control.onmousedown.remove(on_mouse_down);
        control.onmouseup.remove(on_mouse_up);
        control.onmousemove.remove(on_mouse_move);  

        visual.destroy();
        visual = null;
    }

    // public function check_current_mouse_position(x:Float, y:Float)
    // {
    //     _debug("x:" + x);
    //     _debug("y:" + y);     

    //     if (control.contains(x / Main.game_scale, y / Main.game_scale))
    //     {
    //         _debug("HOVER!!!!!!!!!!!!!!");
    //         visual.texture = Luxe.resources.texture('assets/texture/ui/gb_button_hover.png');
    //     }
    // }

    function on_mouse_enter(e:MouseEvent, c:Control) 
    {
        // _debug("---------- MiosisButtonRender.on_mouse_enter ----------");

        visual.texture = Luxe.resources.texture('assets/texture/ui/gb_button_hover.png');
    }

    function on_mouse_leave(e:MouseEvent, c:Control) 
    {
        // _debug("---------- MiosisButtonRender.on_mouse_leave ----------");

        visual.texture = Luxe.resources.texture('assets/texture/ui/gb_button_normal.png');        
    }

    function on_mouse_down(e:MouseEvent, c:Control) 
    {
        // _debug("---------- MiosisButtonRender.on_mouse_down ----------");
                
        visual.texture = Luxe.resources.texture('assets/texture/ui/gb_button_pressed.png');
    }

    function on_mouse_up(e:MouseEvent, c:Control) 
    {
        // _debug("---------- MiosisButtonRender.on_mouse_up ----------");

        if (e.button == none) 
        {
            visual.texture = Luxe.resources.texture('assets/texture/ui/gb_button_normal.png');        
        }   
        else
        {
            visual.texture = Luxe.resources.texture('assets/texture/ui/gb_button_hover.png');
        }    
    }

    function on_mouse_move(e:MouseEvent, c:Control) 
    {
        // _debug("---------- MiosisButtonRender.on_mouse_move ----------");

        visual.texture = Luxe.resources.texture('assets/texture/ui/gb_button_hover.png');
    }
}
