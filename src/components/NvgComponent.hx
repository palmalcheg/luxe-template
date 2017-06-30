
package components;

import luxe.Log.*;
import luxe.Visual;
import mint.types.Types.MouseEvent;
import mint.Control;

import luxe.options.ComponentOptions;

class NvgComponent extends luxe.Component 
{
    public var _visual:Visual;
    var _drawFn:Float->Void;

    public function new(fn:Float->Void,?options:ComponentOptions)    {        
        super(options);
        _drawFn = fn;
    }

    override function onadded() 
    {
        _debug("---------- NvgComp.onadded ----------");

        _visual = cast entity;
        
    }

    public function fade_in(?t = 0.15, ?fn:Void->Void) 
    {
        _debug("---------- NvgComp.fade_in ----------");

        _visual.color.tween(t, { a:0 }).onComplete(fn);
    }

    public function fade_out(?t = 0.15, ?fn:Void->Void) 
    {
        _debug("---------- NvgComp.fade_out ----------");
                
        _visual.color.tween(t, { a:1 }).onComplete(fn);
    }

    override function onremoved()
    {
        _debug("---------- NvgComp.onremoved ----------");
        _debug(entity);
    }

    override function ondestroy() 
    {
        _debug("---------- NvgComp.ondestroy ----------");
        _debug(entity);        
    }

    public function set_normal(e:MouseEvent, c:Control){}; 
    public function set_hover(e:MouseEvent, c:Control){};
    public function set_down(e:MouseEvent, c:Control){};   

    public override function update(dt:Float){
        if (_drawFn !=null){
            _drawFn(dt) ;
        }
    }
	
}
