package ui.render;

import luxe.Color;
import luxe.Log.*;

import mint.Label;

import ui.UIRendering;

private typedef PixelFontLabelOptions = 
{
    var color_pressed:Color;
}

class UIPixelFontLabel extends mint.render.luxe.Label 
{
    public var color_pressed:Color;

    public function new(uiRendering:UIRendering, control:Label) 
    {
        super(uiRendering, control);
        
        text.font = Luxe.resources.font('assets/font/justabit/justabit32.fnt');
        text.point_size = 8;
        // text.geom.letter_snapping = true;        
        text.geom.texture = text.font.pages[0];
        text.geom.texture.filter_mag = nearest;
        text.geom.texture.filter_min = nearest;

        uiRendering.scene.add(text);  

        var label_options:PixelFontLabelOptions = control.options.options; 

        color_pressed = def(label_options.color_pressed, new Color().rgb(0xffffff));
    }
}
