package ui.render;

import luxe.Color;
import luxe.Log.*;
import luxe.Visual;
import luxe.Text;
import luxe.Vector;
import components.NvgComponent;

import mint.Button;
import mint.Control;
import mint.render.Render;
import mint.types.Types.MouseEvent;

import definitions.Enums;
import ui.UIRendering;

import nanovg.Nvg.NvgContext;

private typedef SimpleButtonColorScheme = 
{
    var background_color:Color;
    var background_color_hover:Color;
    var background_color_down:Color;
    var foreground_color:Color;
    var foreground_color_hover:Color;
    var foreground_color_down:Color;  
    var text_color:Color;
    var text_color_hover:Color;
    var text_color_down:Color;       
}

class NvgWidget extends Render 
{
    private var _background:NvgComponent;
    private var _foreground:NvgComponent;
    private var _text:Text;
    private var _color_scheme:SimpleButtonColorScheme;   

    var vg:cpp.Pointer<NvgContext>;

    public function new(uiRendering:UIRendering, control:Button,_vg:cpp.Pointer<NvgContext>) 
    {
        _debug("---------- NvgWidget.new ----------");

        vg = _vg;

        super(rendering, control);

        rendering = uiRendering;
        var labelRenderer:mint.render.luxe.Label = cast control.label.renderer;

        _text = labelRenderer.text;

        def(control.options.options.color_scheme, {});
        def(control.options.options.color_scheme.background_color, new Color().rgb(BasicColors.Red));
        def(control.options.options.color_scheme.background_color_hover, new Color().rgb(BasicColors.Red));
        def(control.options.options.color_scheme.background_color_down, new Color().rgb(BasicColors.Red));
        def(control.options.options.color_scheme.foreground_color, new Color().rgb(BasicColors.Green));                 
        def(control.options.options.color_scheme.foreground_color_hover, new Color().rgb(BasicColors.Green));
        def(control.options.options.color_scheme.foreground_color_down, new Color().rgb(BasicColors.Green));
        def(control.options.options.color_scheme.text_color, new Color().rgb(BasicColors.Blue));
        def(control.options.options.color_scheme.text_color_hover, new Color().rgb(BasicColors.Blue));
        def(control.options.options.color_scheme.text_color_down, new Color().rgb(BasicColors.Blue));                

        _color_scheme = control.options.options.color_scheme;

        // Init visuals
        _background = 
                new Visual({
                        name:"widget.background", 
                        scene:uiRendering.scene,
                        batcher:uiRendering.options.batcher,
                        depth:uiRendering.options.depth + control.depth,
                        visible:control.visible,
                        no_geometry: true
                })
         .add(new NvgComponent(null));

        _foreground = new Visual({
            name:"widget.foreground",
            scene:uiRendering.scene,
            batcher:uiRendering.options.batcher,
            depth:uiRendering.options.depth + control.depth,
            visible:control.visible,
            no_geometry: true
        }).add(new NvgComponent(drawNvg)); 

        // Subscribe to mouse events

        control.onmouseenter.listen(on_mouse_enter);
        control.onmouseleave.listen(on_mouse_leave);
        control.onmousedown.listen(on_mouse_down);
        control.onmouseup.listen(on_mouse_up);
        control.onmousemove.listen(on_mouse_move); 

        // Set size and appearance
        onbounds();
    }

    override function onbounds():Void
    {        
        _background._visual.pos = new Vector(control.x, control.y);
        _background._visual.size = new Vector(control.w, control.h);
        
        var border_thickness = 0.5;  
        var foreground_width = _background._visual.size.x - 2 * border_thickness;
        var foreground_height = _background._visual.size.y - 2 * border_thickness;  

        _foreground._visual.pos = new Vector(control.x + border_thickness, control.y + border_thickness);
        _foreground._visual.size = new Vector(foreground_width, foreground_height);
    }

    override function onvisible(_visible:Bool):Void
    {
        _debug("---------- NvgWidget.onvisible ----------");
        safeSet(function(c) { c._visual.visible = _visible; });
    }

    private function safeSet (f:NvgComponent->Void) {
        var nonNullComponents = [_foreground,_background].filter(function(c) return c!=null);
        for(comp in nonNullComponents) {
            f(comp);
        }
    }

    override function ondepth(depth:Float):Void
    {
        var uiRendering = cast rendering;
        _background._visual.depth = uiRendering.options.depth + depth;
        _foreground._visual.depth = _background._visual.depth + 1;        
    }

    override function ondestroy():Void
    {
        // Unsubscribe from mouse events

        control.onmouseenter.remove(on_mouse_enter);
        control.onmouseleave.remove(on_mouse_leave);
        control.onmousedown.remove(on_mouse_down);
        control.onmouseup.remove(on_mouse_up);
        control.onmousemove.remove(on_mouse_move);  

        // Destroy visuals
        
        safeSet(function(c) { c.ondestroy(); });

        _background = null;
        _foreground = null; 
        _text = null;
        _color_scheme = null;
    }   

    private function set_normal_colors(e:MouseEvent, c:Control):Void
    {
        safeSet(function(comp) { comp.set_normal(e, c); });
    }

    private function set_hover_colors(e:MouseEvent, c:Control):Void
    {
        safeSet(function(comp) { comp.set_hover(e, c); }); 
    }

    private function set_down_colors(e:MouseEvent, c:Control):Void
    {
       safeSet(function(comp) { comp.set_down(e, c); });      
    }

    private function on_mouse_enter(e:MouseEvent, c:Control):Void
    {
        // _debug("---------- NvgWidget.on_mouse_enter ----------");
        set_hover_colors(e,c);
    }

    function on_mouse_leave(e:MouseEvent, c:Control) 
    {
        // _debug("---------- NvgWidget.on_mouse_leave ----------");

        set_normal_colors(e,c);
    }

    function on_mouse_down(e:MouseEvent, c:Control) 
    {
        // _debug("---------- NvgWidget.on_mouse_down ----------");        

        set_down_colors(e,c);
    }

    function on_mouse_up(e:MouseEvent, c:Control) 
    {
        // _debug("---------- NvgWidget.on_mouse_up ----------");

        if (e.button == none) 
        {
            // Outside button
            // _debug("OUTSIDE!!!!!!!!!!!!!!");
            set_normal_colors(e,c);
        }   
        else
        {
            // Inside button
            // _debug("INSIDE!!!!!!!!!!!!!!");            
            set_hover_colors(e,c);
        }    
    }

    function on_mouse_move(e:MouseEvent, c:Control) 
    {
        _debug("---------- NvgWidget.on_mouse_move ----------");
    }

    public function drawNvg(dt:Float) {
    }
}
