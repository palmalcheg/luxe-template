import luxe.Camera;
import luxe.Color;
import luxe.Input;
import luxe.Log.*;
import luxe.Parcel;
import luxe.Scene;
import luxe.Screen.WindowEvent;
import luxe.Sprite;
import luxe.States;
import luxe.Vector;

import phoenix.Batcher;

import mint.focus.Focus;
import mint.render.luxe.LuxeMintRender;

import definitions.Enums;
import components.Fader;
import entities.FadeTransitionSprite;
import states.BaseState;
import states.LoadState;
import states.Level1State;
import states.Level2State;
import states.SplashState;
import system.CGAPalette;
import ui.MiosisCanvas;

class Main extends luxe.Game  
{
    public static var main_scene:Scene;
    public static var mint_renderer:LuxeMintRender;
    public static var canvas:MiosisCanvas; // TODO : does this need to be public static
    public static var focus:Focus; // TODO : does this need to be public static
    public static var background_batcher:phoenix.Batcher;  
    public static var ui_batcher: phoenix.Batcher;    
    public static var foreground_batcher:phoenix.Batcher;
    public static var palette:CGAPalette;

    public static var w:Int = -1;
    public static var h:Int = -1;

    public static var game_scale:Float = 1.0;

    private var _states : States;
    private var _current_state : String;
    private var _next_state : String;
    private var _current_parcel : Parcel;
    private var _changeStateEventId : String;
    private var _fader : Fader;

    override function config(config:luxe.GameConfig) 
    {
        log('Config loaded as ' + Luxe.snow.config.user);

        var windowConfig = Luxe.snow.config.user.window;

        w = windowConfig.width;
        h = windowConfig.height;

        game_scale = windowConfig.scale;

        config.window.width = w * cast game_scale;
        config.window.height = h * cast game_scale;

        config.window.title = windowConfig.title;
        config.window.fullscreen = windowConfig.fullscreen;
        config.window.resizable = windowConfig.resizable;
        config.window.borderless = windowConfig.borderless;

        // Load assets for the splash screen
        config.preload.textures.push({ id : LetterMTexture, filter_min:nearest, filter_mag:nearest });
        config.preload.textures.push({ id : LetterITexture, filter_min:nearest, filter_mag:nearest });
        config.preload.textures.push({ id : LetterOTexture, filter_min:nearest, filter_mag:nearest });
        config.preload.textures.push({ id : LetterSTexture, filter_min:nearest, filter_mag:nearest });
        config.preload.jsons.push({ id : LogoAnimationJson });

        _changeStateEventId = "";
        _current_state = "";
        _next_state = "";

        return config;
    }

    override function ready() 
    {
        _debug("---------- Main.ready ----------");

        // Set background color
        Luxe.renderer.clear_color = new Color().rgb(GameBoyPalette2.Dark);

        log('Main w: ${w}');
        log('Main h: ${h}');
        log('Screen width:${w} ${Luxe.screen.w}');
        log('Screen height: ${h} ${Luxe.screen.h}');

        // Create main scene

        main_scene = new Scene("main_scene");

        // Set up cameras and batchers

        Luxe.camera.size = new Vector(w, h);
        Luxe.camera.size_mode = luxe.Camera.SizeMode.fit;

        var background_camera = new Camera({ name: 'background_camera' });
        background_camera.size = new Vector(w, h);
        background_camera.size_mode = luxe.Camera.SizeMode.fit;

        var foreground_camera = new Camera({ name : 'foreground_camera' });
        foreground_camera.size = new Vector(w, h);
        foreground_camera.size_mode = luxe.Camera.SizeMode.fit;        

        background_batcher = Luxe.renderer.create_batcher({
            layer : -1,
            name :'background_batcher',
            camera : background_camera.view
        });

        ui_batcher = Luxe.renderer.create_batcher({
            layer : 1,
            name :'ui_batcher',
            camera : background_camera.view
        });

        foreground_batcher = Luxe.renderer.create_batcher({
            layer: 3,
            name:'foreground_batcher',
            camera: foreground_camera.view
        });
        
        // Set up Mint canvas

        mint_renderer = new LuxeMintRender({ batcher:ui_batcher });

        canvas = new MiosisCanvas({
            name :'canvas',
            rendering : mint_renderer,
            options : { color:new Color(1, 1, 1, 0) },
            x: 0, y:0, w: 100, h: 100
        });
        canvas.auto_listen();

        focus = new Focus(canvas);

        // Set up fade overlay

        var fader_sprite = new FadeTransitionSprite();
        _fader = fader_sprite.add(new Fader());
        
        // Subscribe to state change events
        _changeStateEventId = Luxe.events.listen(EventTypes.ChangeState, on_change_state);

        // Go to first state
        _states = new States({ name:'states' });
        _states.add(new SplashState());
        _states.add(new LoadState());        
        _states.add(new Level1State());
        _states.add(new Level2State());        

        _current_state = StateNames.Splash;
        _next_state = StateNames.Splash;
        _states.set(_next_state);

        var state:BaseState = cast _states.current_state;
        _fader.fade_in(state.transition_in_time, on_fade_in_done);  

        palette = new CGAPalette(CGAPaletteType.CGA0High);    
    }

    function on_change_state(e)
    {
        _debug("---------- Main.on_change_state, go to state: " + e.state + "----------");

        _next_state = e.state;   

        if (e.parcel != null)
        {
            _current_parcel = e.parcel;
        }     

        var state:BaseState = cast _states.current_state;

        if (state.transition_out_time > 0)
        {
            _fader.fade_out(state.transition_out_time, on_fade_out_done);    
        }
        else
        {
            on_fade_out_done();
        }
    }

    function on_fade_in_done()
    {
        _debug("---------- Main.on_fade_in_done ----------");

        var state:BaseState = cast _states.current_state;
        state.post_fade_in();
    }

    function on_fade_out_done()
    {
        _debug("---------- Main.on_fade_out_done ----------");

        log("!!!!!!!!!!!!! _current_state = " + _current_state);
        log("!!!!!!!!!!!!! _next_state = " + _next_state);        

        _states.unset(_current_state);

        if (_current_state == StateNames.Splash)
        {// Destroy preloaded splash resources
            Luxe.resources.destroy(LetterMTexture);
            Luxe.resources.destroy(LetterITexture);
            Luxe.resources.destroy(LetterOTexture);
            Luxe.resources.destroy(LetterSTexture);            
            Luxe.resources.destroy(LogoAnimationJson);
        }

        main_scene.empty();

        if (_current_state == StateNames.Load)
        {
            // Resources for next state loaded, proceed
            _states.set(_next_state);
        }
        else
        {
            if (_current_parcel != null)
            {// Assets were loaded from a parcel (i.e. current state is not splash or load)
                _current_parcel.unload();
            }

            // Bootstrap load state to preload resources for next state
            LoadState.state_to_load = _next_state;            
            _states.set(StateNames.Load);
        }

        var state:BaseState = cast _states.current_state;
        _current_state = state.name;
        _fader.fade_in(state.transition_in_time, on_fade_in_done);                        
    }

    override function onkeyup(e:luxe.Input.KeyEvent) 
    {
        if(e.keycode == Key.escape) 
        {
            Luxe.shutdown();
        }
    }

    override function onwindowsized( e:WindowEvent ) 
    {
        Luxe.camera.viewport = new luxe.Rectangle(0, 0, e.x, e.y);
        foreground_batcher.view.viewport = new luxe.Rectangle(0, 0, e.x, e.y);
    }

    override function ondestroy() 
    {
        Luxe.events.unlisten(_changeStateEventId);

        if (_states != null)
        {
            _states.destroy();
            _states = null;            
        }

        if (_current_parcel != null)
        {
            _current_parcel.unload();
            _current_parcel = null; 
        }

        _next_state = null;
        _fader = null;
    }
}
