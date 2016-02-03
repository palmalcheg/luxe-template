package dk.miosis.luxetemplate;

import luxe.Color;
import luxe.Log;
import luxe.Log.*;
import luxe.Parcel;
import luxe.ParcelProgress;
import luxe.resource.Resource;
import luxe.Screen.WindowEvent;
import luxe.States;
import luxe.Vector;

import luxe.collision.shapes.Polygon;

import phoenix.Batcher;
import phoenix.Texture.FilterType;

import mint.Canvas;
import mint.focus.Focus;
import mint.render.luxe.LuxeMintRender;
import mint.render.luxe.Convert;
import mint.layout.margins.Margins;

import dk.miosis.luxetemplate.state.Game;
import dk.miosis.luxetemplate.state.Splash;
import dk.miosis.luxetemplate.system.CirclePreloader;
import dk.miosis.luxetemplate.system.MiosisPhysicsEngine;

class Main extends luxe.Game 
{
    public static var mintRenderer:LuxeMintRender;
    public static var canvas:Canvas;
    public static var focus: Focus;
    public static var ui_batcher: phoenix.Batcher;

    public static var w: Int = -1;
    public static var h: Int = -1;

    var _states:States;

    public static var physics:MiosisPhysicsEngine;

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
        log("ready");

        var promise_json = Luxe.resources.load_json("assets/parcel.json");
        promise_json.then(create_parcel_and_preloader);

        Luxe.camera.size = new Vector(w, h);
        Luxe.camera.size_mode = luxe.Camera.SizeMode.fit;

        log('Screen width: ${Luxe.screen.w}');
        log('Screen height: ${Luxe.screen.h}');

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
            x: 0, y:0, w: 100, h: 100
        });

        focus = new Focus(canvas);

        // Set up custom physics
        physics = Luxe.physics.add_engine(MiosisPhysicsEngine);
        physics.draw = false;
        physics.player_collider = Polygon.rectangle(0,0,8,8);
    }

    function create_parcel_and_preloader(json:JSONResource) 
    {
        log("create_parcel");

        var parcel = new Parcel();
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
        log("assets_loaded");

        _states = new States({ name:'states' });
        _states.add(new Splash());
        _states.add(new Game());
        _states.set("game");
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
        Luxe.camera.viewport = new luxe.Rectangle(0, 0, e.event.x, e.event.y);
    }

    override function update(dt:Float) 
    {
        _verbose("----- Main update -----");

        canvas.update(dt);
    }

    function mouseEventToWorld(e:luxe.Input.MouseEvent) 
    {
        e.pos = Luxe.camera.screen_point_to_world(e.pos);
        e.x = Std.int(e.pos.x);
        e.y = Std.int(e.pos.y);
    }
}
