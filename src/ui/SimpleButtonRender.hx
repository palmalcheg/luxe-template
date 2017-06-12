package ui;

import luxe.Color;
import luxe.Log.*;
import luxe.Scene;
import luxe.Sprite;
import luxe.Text;
import luxe.Vector;

import mint.Button;
import mint.Control;
import mint.render.Render;
import mint.types.Types.MouseEvent;

import definitions.Enums;
import ui.MiosisMintRendering;
import system.GameBoyPalette;

class SimpleButtonRender extends Render 
{
    private var _background:Sprite;
    private var _foreground:Sprite;
    private var _text:Text;  

    public function new(rendering:MiosisMintRendering, control:Button, scene:Scene) 
    {
        _debug("---------- SimpleButtonRender.new ----------");

        super(rendering, control);

        // Init visuals

        _background = new Sprite({
            name:"button_background", 
            scene:scene,
            batcher:rendering.options.batcher,
            // color:new Color().rgb(GameBoyPalette2.Medium),
            depth:rendering.options.depth + control.depth,
            visible:control.visible,
            centered:false
        });        

        _foreground = new Sprite({
            name:"button_background", 
            scene:scene,
            batcher:rendering.options.batcher,
            // color:new Color().rgb(GameBoyPalette2.Light),
            depth:rendering.options.depth + control.depth,
            visible:control.visible,
            centered:false
        });

        // Customize button label

        var labelRenderer:mint.render.luxe.Label = cast control.label.renderer;
        rendering.ui_scene.add(labelRenderer.text);
        _text = rendering.ui_scene.get(control.name + '.label.text');    
        log('Text obj:' + _text);  
        _text.font = Luxe.resources.font('assets/font/justabit/justabit32.fnt');
        // _text.color = new Color().rgb(GameBoyPalette2.Dark);
        _text.geom.letter_snapping = true;        
        _text.geom.texture = _text.font.pages[0];
        _text.geom.texture.filter_mag = nearest;
        _text.geom.texture.filter_min = nearest;
        _text.point_size = 16;

        // Subscribe to mouse events

        control.onmouseenter.listen(on_mouse_enter);
        control.onmouseleave.listen(on_mouse_leave);
        control.onmousedown.listen(on_mouse_down);
        control.onmouseup.listen(on_mouse_up);
        control.onmousemove.listen(on_mouse_move); 

        // Set size and appearance
        onbounds();
        go_to_normal_state(); 
    }

    override function onbounds() 
    {
        _background.pos = new Vector(control.x, control.y);
        _background.size = new Vector(control.w, control.h);
        
        var border_thickness = 0.5;  
        var foreground_width = _background.size.x - 2 * border_thickness;
        var foreground_height = _background.size.y - 2 * border_thickness;  

        _foreground.pos = new Vector(control.x + border_thickness, control.y + border_thickness);
        _foreground.size = new Vector(foreground_width, foreground_height);
    }

    override function onvisible(_visible:Bool) 
    {
        _debug("---------- SimpleButtonRender.onvisible ----------");

        _background.visible = _visible;      
        _foreground.visible = _visible;              
    }

    override function ondepth(depth:Float) 
    {
        var customRendering:MiosisMintRendering = cast rendering;
        _background.depth = customRendering.options.depth + depth;
        _foreground.depth = _background.depth + 1;        
    }

    override function ondestroy() 
    {
        // Unsubscribe from mouse events

        control.onmouseenter.remove(on_mouse_enter);
        control.onmouseleave.remove(on_mouse_leave);
        control.onmousedown.remove(on_mouse_down);
        control.onmouseup.remove(on_mouse_up);
        control.onmousemove.remove(on_mouse_move);  

        // Destroy visuals

        _background.destroy();
        _foreground.destroy();
        _background = null;
        _foreground = null; 
        _text = null;       
    }

    public function check_current_mouse_position(x:Float, y:Float)
    {
        _debug("x:" + x);
        _debug("y:" + y);     

        if (control.contains(x / Main.game_scale, y / Main.game_scale))
        {
            go_to_hover_state();
        }
        else
        {
            go_to_normal_state();
        }
    }

    function go_to_normal_state()
    {
        _text.color = GameBoyPalette.get_color(0);
        _background.color = GameBoyPalette.get_color(2);                 
        _foreground.color = GameBoyPalette.get_color(3);        
    }

    function go_to_hover_state()
    {
        _text.color = GameBoyPalette.get_color(0);
        _background.color = GameBoyPalette.get_color(1);         
        _foreground.color = GameBoyPalette.get_color(2);        
    }

    function go_to_pressed_state()
    {
        _text.color = GameBoyPalette.get_color(1);
        _background.color = GameBoyPalette.get_color(3);        
        _foreground.color = GameBoyPalette.get_color(2);
    }

    function on_mouse_enter(e:MouseEvent, c:Control) 
    {
        _debug("---------- MiosisButtonRender.on_mouse_enter ----------");
        go_to_hover_state();
    }

    function on_mouse_leave(e:MouseEvent, c:Control) 
    {
        _debug("---------- MiosisButtonRender.on_mouse_leave ----------");

        go_to_normal_state();
    }

    function on_mouse_down(e:MouseEvent, c:Control) 
    {
        _debug("---------- MiosisButtonRender.on_mouse_down ----------");        

        go_to_pressed_state();
    }

    function on_mouse_up(e:MouseEvent, c:Control) 
    {
        _debug("---------- MiosisButtonRender.on_mouse_up ----------");

        if (e.button == none) 
        {
            // Outside button
            _debug("OUTSIDE!!!!!!!!!!!!!!");
            go_to_normal_state();
        }   
        else
        {
            // Inside button
            _debug("INSIDE!!!!!!!!!!!!!!");            
            go_to_hover_state();
        }    
    }

    function on_mouse_move(e:MouseEvent, c:Control) 
    {
        _debug("---------- MiosisButtonRender.on_mouse_move ----------");
    }
}
