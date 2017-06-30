package ui.render;

import components.*;

import mint.Button;
import ui.UIRendering;

using nanovg.Nvg;

class NvgButton extends NvgWidget {

    var fontId:Int;

    public function new(uiRendering:UIRendering, control:Button, vg:cpp.Pointer<NvgContext>,font:Int){       
        super(uiRendering,control,vg); 
        fontId = font;      
    }

    public override function drawNvg(dt:Float)
    {        
        var x = sx;
        var y = sy;
        var w = sw;
        var h = sh;
        var cornerRadius = 3.0;
        
        // Window
        vg.beginPath();
        vg.roundedRect(x,y, w,h, cornerRadius);
        vg.fillColor(Nvg.rgba(28,30,34,192));
        vg.fill();

        // Drop shadow
        var shadowPaint = vg.boxGradient(x,y+2, w,h, cornerRadius*2, 10, Nvg.rgba(0,0,0,128), Nvg.rgba(0,0,0,0));
        vg.beginPath();
        vg.rect(x-10,y-10, w+20,h+30);
        vg.roundedRect(x,y, w,h, cornerRadius);
        vg.pathWinding(NvgSolidity.HOLE);
        vg.fillPaint(shadowPaint);
        vg.fill();

        // Header
        var headerPaint = vg.linearGradient(x,y,x,y+15, Nvg.rgba(255,255,255,8), Nvg.rgba(0,0,0,16));
        vg.beginPath();
        vg.roundedRect(x+1,y+1, w-2,30, cornerRadius-1);
        vg.fillPaint(headerPaint);
        vg.fill();

        vg.beginPath();
        vg.moveTo(x+0.5, y+0.5+30);
        vg.lineTo(x+0.5+w-1, y+0.5+30);
        vg.strokeColor(Nvg.rgba(0,0,0,32));
        vg.stroke();

        vg.fontSize(18.0);
        vg.fontFaceId(fontId);
        vg.textAlign(NvgAlign.ALIGN_CENTER|NvgAlign.ALIGN_MIDDLE);

        vg.fontBlur(2);
        vg.fillColor(Nvg.rgba(0,0,0,128));
        vg.text(x+w/2,y+16+1, _text.text, null);

        vg.fontBlur(0);
        vg.fillColor(Nvg.rgba(220,220,220,160));
        vg.text(x+w/2,y+16, _text.text, null);
    }
    

}