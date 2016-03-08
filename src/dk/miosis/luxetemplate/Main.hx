package dk.miosis.luxetemplate;

import luxe.Color;
import luxe.Log;
import luxe.Log.*;
import luxe.Parcel;
import luxe.ParcelProgress;
import luxe.resource.Resource;
import luxe.Scene;
import luxe.Screen.WindowEvent;
import luxe.Sprite;
import luxe.States;
import luxe.Vector;

import luxe.collision.shapes.Polygon;

import phoenix.Batcher;
import phoenix.Texture.FilterType;

import mint.Canvas;
import mint.focus.Focus;
import mint.render.luxe.LuxeMintRender;
import mint.render.luxe.Convert;

import snow.api.Promise;

import dk.miosis.luxetemplate.component.FadeOverlay;
import dk.miosis.luxetemplate.state.BaseState;
import dk.miosis.luxetemplate.state.Game;
import dk.miosis.luxetemplate.state.Splash;
import dk.miosis.luxetemplate.system.MiosisPhysicsEngine;

class Main extends luxe.Game 
{
    public static var mint_renderer:LuxeMintRender;
    public static var canvas:Canvas;
    public static var focus: Focus;
    public static var game_batcher: phoenix.Batcher;    
    public static var ui_batcher: phoenix.Batcher;
    public static var physics:MiosisPhysicsEngine; 

    public static var w:Int = -1;
    public static var h:Int = -1;

    var next_state:String;

    var states:States;

    var overlay_scene:Scene;
    var fade_overlay_sprite:Sprite;
    var fade_overlay:FadeOverlay;  

    override function config(config:luxe.AppConfig) 
    {
        w = config.window.width;
        h = config.window.height;

        config.window.width *= Constants.GAME_SCALE;
        config.window.height *= Constants.GAME_SCALE;   

        return config;
    }

    override function ready() 
    {
        _debug("---------- Main.ready ----------");

        next_state = "splash";

        // Load assets
        var promise_json:Promise = Luxe.resources.load_json("assets/parcel.json");
        promise_json.then(load_assets);

        // Fit camera viewport to window size
        Luxe.camera.size = new Vector(w, h);
        Luxe.camera.size_mode = luxe.Camera.SizeMode.fit;

        log('Screen width: ${Luxe.screen.w}');
        log('Screen height: ${Luxe.screen.h}');

        // Set up Mint canvas
        var ui_camera = new luxe.Camera();
        ui_camera.size = new phoenix.Vector(w, h, 1);
        ui_camera.size_mode = luxe.Camera.SizeMode.fit;
        ui_batcher = Luxe.renderer.create_batcher({ name:'ui_batcher', camera: ui_camera.view });
        ui_batcher.layer = 2;
        
        Luxe.renderer.add_batch(ui_batcher);

        mint_renderer = new LuxeMintRender({ batcher:ui_batcher });
        
        canvas = new mint.Canvas({
            name:'canvas',
            rendering: mint_renderer,
            options: { color:Constants.COLOR_TRANSPARENT },
            x: 0, y:0, w: 100, h: 100
        });

        focus = new Focus(canvas);

        // Set up custom physics
        physics = Luxe.physics.add_engine(MiosisPhysicsEngine);
        physics.draw = false;
        physics.player_collider = Polygon.rectangle(0,0,8,8);

        // Subscribe to state change events
        Luxe.events.listen('change_state', on_change_state);        
    }

    function load_assets(json:JSONResource) 
    {
        _debug("---------- Main.load_assets ----------");

        var parcel:Parcel = new Parcel();
        parcel.from_json(json.asset.json);

        new ParcelProgress({
            parcel: parcel,
            background  : new Color(1,1,1,0.85),
            oncomplete: assets_loaded
        });
        
        parcel.load();        
    }

    function assets_loaded(_) 
    {
        _debug("---------- Main.assets_loaded ----------");

        // Set up fade overlay
        overlay_scene = new Scene('overlay_scene');

        fade_overlay_sprite = new Sprite({
            name: 'fade_overlay_sprite',
            scene: overlay_scene,
            size: Luxe.screen.size,
            color: Constants.GAME_BOY_COLOR_DARK,
            centered: false,
            depth:99
        });     
        fade_overlay = fade_overlay_sprite.add(new FadeOverlay({ name:'fade' }));
        
        // Go to first state
        states = new States({ name:'states' });
        states.add(new Splash());
        states.add(new Game());
        states.set(next_state);

        var state:BaseState = cast states.current_state;
        fade_overlay.fade_in(state.fade_in_time, on_fade_in_done);
    }

    function on_change_state(e)
    {
        _debug("---------- Main.on_change_state ----------");

        var state:BaseState = cast states.current_state;
        next_state = e.state;

        if (state.fade_out_time > 0)
        {
            fade_overlay.fade_out(state.fade_in_time, on_fade_out_done);    
        }
        else
        {
            on_fade_out_done();
        }
    }

    function on_fade_in_done()
    {
        _debug("---------- Main.on_fade_in_done ----------");

        var state:BaseState = cast states.current_state;
        state.post_fade_in();
    }

    function on_fade_out_done()
    {
        _debug("---------- Main.on_fade_out_done ----------");

        Luxe.scene.empty();
        states.set(next_state);
        var state:BaseState = cast states.current_state;
        fade_overlay.fade_in(state.fade_in_time, on_fade_in_done);
    }

    override function onrender() 
    {
       canvas.render();
    }

    override function onmouseup(e:luxe.Input.MouseEvent) 
    {
        canvas.mouseup(Convert.mouse_event(e));
    }

    override function onmousedown(e:luxe.Input.MouseEvent) 
    {
        canvas.mousedown(Convert.mouse_event(e));    
    }

    override function onmousemove(e:luxe.Input.MouseEvent) 
    {
        mouseEventToWorld(e);
        canvas.mousemove( Convert.mouse_event(e) );  
    }

    override function onwindowsized( e:WindowEvent ) 
    {
        Luxe.camera.viewport = new luxe.Rectangle(0, 0, e.x, e.y);
    }

    override function update(dt:Float) 
    {
        _verboser("---------- Main.update ----------");

        canvas.update(dt);
    }

    function mouseEventToWorld(e:luxe.Input.MouseEvent) 
    {
        e.pos = Luxe.camera.screen_point_to_world(e.pos);
        e.x = Std.int(e.pos.x);
        e.y = Std.int(e.pos.y);
    }
}
