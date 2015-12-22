package dk.miosis.luxetemplate;

import luxe.Log;
import luxe.Log.*;
import luxe.Screen.WindowEvent;
import luxe.States;
import luxe.Vector;

import phoenix.Batcher;

import mint.Canvas;
import mint.focus.Focus;
import mint.render.luxe.LuxeMintRender;
import mint.render.luxe.Convert;
import mint.layout.margins.Margins;

import dk.miosis.luxetemplate.states.Game;
import dk.miosis.luxetemplate.states.Splash;

class Main extends luxe.Game {

    public static var mintRenderer:LuxeMintRender;
    public static var canvas:Canvas;
    public static var focus: Focus;
    public static var ui_batcher: phoenix.Batcher;

    public static var w: Int = -1;
    public static var h: Int = -1;

    var _states:States;

    override function config(config:luxe.AppConfig) {
        w = config.window.width;
        h = config.window.height;

        config.window.width *= Constants.GAME_SCALE;
        config.window.height *= Constants.GAME_SCALE;
        
        config.preload.textures.push({ id:'assets/img/pixel.png', filter_min:nearest, filter_mag:nearest });        
        config.preload.textures.push({ id:'assets/img/smiley.png', filter_min:nearest, filter_mag:nearest });
        config.preload.textures.push({ id:'assets/img/ui/gb_button.png', filter_min:nearest, filter_mag:nearest });        
        config.preload.textures.push({ id:'assets/img/ui/gb_button_pressed.png', filter_min:nearest, filter_mag:nearest });        
        config.preload.textures.push({ id:'assets/img/ui/gb_button_hover.png', filter_min:nearest, filter_mag:nearest });
        config.preload.textures.push({ id:'assets/img/ui/button2.png', filter_min:nearest, filter_mag:nearest });        
        config.preload.textures.push({ id:'assets/img/ui/button2_pressed.png', filter_min:nearest, filter_mag:nearest });       
        
        config.preload.fonts.push({ id:'assets/font/justabit/justabit32.fnt' });      

        return config;
    }

    override function ready() {
        Luxe.camera.size = new Vector(w, h);
        Luxe.camera.size_mode = luxe.Camera.SizeMode.fit;

        trace (Luxe.screen.w);
        trace (Luxe.screen.h);

        // ui_batcher = new Batcher(Luxe.renderer, 'ui_batcher');
        var ui_camera = new luxe.Camera();
        ui_camera.size = new phoenix.Vector(w, h, 1);
        ui_camera.size_mode = luxe.Camera.SizeMode.fit;
        ui_batcher = Luxe.renderer.create_batcher({ name:'ui_batcher', camera: ui_camera.view });
        ui_batcher.layer = 2;
        Luxe.renderer.add_batch(ui_batcher);

        mintRenderer = new LuxeMintRender({ batcher:ui_batcher });
        
        canvas = new mint.Canvas({
            name:'canvas',
            rendering: mintRenderer,
            options: { color:Constants.COLOR_TRANSPARENT },
            x: 0, y:0, w: w, h: h
        });

        focus = new Focus(canvas);

        _states = new States({ name:'states' });
        _states.add(new Splash());
        _states.add(new Game());
        _states.set("game");
    }

    override function onrender() {
        canvas.render();
    }

    override function onmouseup(e:luxe.Input.MouseEvent) {
        canvas.mouseup( Convert.mouse_event(e) );
    }

    override function onmousedown(e:luxe.Input.MouseEvent) {
        canvas.mousedown( Convert.mouse_event(e) );
    }

    override function onmousemove(e:luxe.Input.MouseEvent) {
        mouseEventToWorld(e);
        canvas.mousemove( Convert.mouse_event(e) );
    }

    override function onwindowsized( e:WindowEvent ) {
        Luxe.camera.viewport = new luxe.Rectangle(0, 0, e.event.x, e.event.y);
    }

    override function update(dt:Float) {
        // _verbose("----- Main update -----");
        canvas.update(dt);
    }

    function mouseEventToWorld(e:luxe.Input.MouseEvent) {
        e.pos = Luxe.camera.screen_point_to_world(e.pos);
        e.x = Std.int(e.pos.x);
        e.y = Std.int(e.pos.y);
    }

}