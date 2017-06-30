package ui;

import luxe.Scene;
import luxe.Ev;

import mint.Control;
import mint.render.luxe.LuxeMintRender;

import ui.render.NvgButton;
import ui.render.UIPixelFontLabel;

import definitions.Enums;

using nanovg.Nvg;

import luxe.Log.*;

import phoenix.Batcher.BatcherEventType;

class UIRendering extends LuxeMintRender 
{
    public var scene(default, null):Scene;

    var vg:cpp.Pointer<NvgContext>;

    var fontId:Int;

    public function new(?options:luxe.options.RenderProperties)
    {
        super(options);

        scene = new Scene('ui_scene');

        vg = Nvg.createGL(NvgMode.ANTIALIAS);

        fontId = vg.createFont("justabit48", "assets/font/DroidSans.ttf");

        options.batcher.on(BatcherEventType.prerender, startFrame);
        options.batcher.on(BatcherEventType.postrender, endFrame); 
    }

    override function get<T:Control, T1>(type:Class<T>, control:T):T1 
    {
        return cast switch(type) 
        {
            case mint.Canvas:       new mint.render.luxe.Canvas(this, cast control);
            // case mint.Label:       new mint.render.luxe.Label(this, cast control);
            // case mint.Button:      new mint.render.luxe.Button(this, cast control);
            case mint.Image:        new mint.render.luxe.Image(this, cast control);
            case mint.List:         new mint.render.luxe.List(this, cast control);
            case mint.Scroll:       new mint.render.luxe.Scroll(this, cast control);
            case mint.Panel:        new mint.render.luxe.Panel(this, cast control);
            case mint.Checkbox:     new mint.render.luxe.Checkbox(this, cast control);
            case mint.Window:       new mint.render.luxe.Window(this, cast control);
            case mint.TextEdit:     new mint.render.luxe.TextEdit(this, cast control);
            case mint.Dropdown:     new mint.render.luxe.Dropdown(this, cast control);            
            case mint.Slider:       new mint.render.luxe.Slider(this, cast control);
            case mint.Progress:     new mint.render.luxe.Progress(this, cast control);
            // Custom
            case mint.Button:       new NvgButton(this, cast control,vg,fontId);
            case mint.Label:        new UIPixelFontLabel(this, cast control);                         
            case _:                null;
        }
    }

    function endFrame(_){
        vg.restore();
		vg.endFrame();
	}
	function startFrame(_){
        var dpr = Luxe.core.app.runtime.window_device_pixel_ratio();
        var render_w = Luxe.core.app.runtime.window_width();
        var render_h = Luxe.core.app.runtime.window_height();
        var window_width = Math.floor(render_w/dpr);
        var window_height = Math.floor(render_h/dpr);
        vg.beginFrame(window_width, window_height, dpr);
        vg.save();
	}
}
