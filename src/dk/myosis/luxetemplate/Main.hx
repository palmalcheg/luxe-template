package dk.myosis.luxetemplate;

import luxe.Camera;
import luxe.Color;
import luxe.Entity;
import luxe.Screen.WindowEvent;
import luxe.States;
import luxe.Text;
import luxe.Vector;

import mint.Button;
import mint.Canvas;
import mint.Control;
import mint.focus.Focus;
import mint.types.Types;
import mint.render.luxe.LuxeMintRender;
import mint.render.luxe.Convert;
import mint.layout.margins.Margins;

import dk.myosis.luxetemplate.states.Game;
import dk.myosis.luxetemplate.states.Splash;
import dk.myosis.luxetemplate.systems.PlayerInputSystem;
import dk.myosis.luxetemplate.ui.MyosisButtonRender;
import dk.myosis.luxetemplate.ui.MyosisMintRendering;


class Main extends luxe.Game {

    public static var mintRenderer:LuxeMintRender;
    public static var canvas:Canvas;
    public static var focus: Focus;

    public static var w: Int = -1;
    public static var h: Int = -1;

    var _inputSystem:PlayerInputSystem;
    var _states:States;

    var _button:Button;

    override function config(config:luxe.AppConfig) {
        w = config.window.width;
        h = config.window.height;
        config.window.width *= Constants.GAME_SCALE;
        config.window.height *= Constants.GAME_SCALE;
        config.preload.textures.push({ id:'assets/img/smiley.png', filter_min:nearest, filter_mag:nearest });
        config.preload.textures.push({ id:'assets/img/ui/gb_button.png', filter_min:nearest, filter_mag:nearest });        
        config.preload.textures.push({ id:'assets/img/ui/gb_button_pressed.png', filter_min:nearest, filter_mag:nearest });        
        config.preload.textures.push({ id:'assets/img/ui/gb_button_hover.png', filter_min:nearest, filter_mag:nearest });        
        config.preload.fonts.push({ id:'assets/font/justabit/justabit32.fnt' });      

        return config;
    }

    override function ready() {
        _inputSystem = new PlayerInputSystem();
        _inputSystem.registerComponent();

        Luxe.camera.size = new Vector(w, h);
        Luxe.camera.size_mode = SizeMode.fit;

        mintRenderer = new LuxeMintRender();
        
        canvas = new mint.Canvas({
            name:'canvas',
            rendering: mintRenderer,
            options: { color:Constants.GAME_BOY_COLOR_OFF },
            x: 0, y:0, w: w, h: h
        });

        focus = new Focus(canvas);

        _states = new States({ name:'states' });
        _states.add(new Splash());
        _states.add(new Game());
        _states.set("game");

        _button = new Button({
            parent: canvas, 
            name: 'testbutton', 
            text: 'test',
            rendering: new MyosisMintRendering(),
            x: 0, y:0, w:30, h: 20,
            onclick: function(e,c) { trace('mint button! ${Luxe.time}' );}
        });

        var txt:Text = Luxe.scene.get('testbutton.label.text');
        txt.font = Luxe.resources.font('assets/font/justabit/justabit32.fnt');
        txt.point_size = 16;
        txt.geom.texture = txt.font.pages[0];

        // var button2 = new Button( {
        //     parent: canvas,
        //     name: "testbutton2",
        //     x: 50, y:0, w:30, h: 20,
        //     text: "test",
        //     options: { color:new Color(0, 1, 0, 1) },
        //     onclick: function(e,c) {trace('Button - MouseUp! ${Luxe.time}' );}
        // } );

        // var txt2:Text = Luxe.scene.get('testbutton2.label.text');
        // txt2.font = Luxe.resources.font('assets/font/justabit/justabit64.fnt');
        // txt2.point_size = 16;
        // txt2.geom.texture = txt2.font.pages[0];
    }

    override function onrender() {
        canvas.render();
    }

    override function onmouseup(e:luxe.Input.MouseEvent) {
        // trace("Main - MouseUp");        
        canvas.mouseup( Convert.mouse_event(e) );
    }

    override function onmousedown(e:luxe.Input.MouseEvent) {
        // trace("Main - MouseUp: " + e);
        canvas.mousedown( Convert.mouse_event(e) );
    }

    override function onmousemove(e:luxe.Input.MouseEvent) {
        // trace("Main - MouseMove");
        mouseEventToWorld(e);
        canvas.mousemove( Convert.mouse_event(e) );
    }

    // Scale camera's viewport accordingly when game is scaled, common and suitable for most games
    override function onwindowsized( e:WindowEvent ) {
        Luxe.camera.viewport = new luxe.Rectangle(0, 0, e.event.x, e.event.y);
    }

    override function update(dt:Float) {
        // trace("----- Main update -----");
        canvas.update(dt);
        _inputSystem.update(dt);
    }

    function mouseEventToWorld(e:luxe.Input.MouseEvent) {
        e.pos = Luxe.camera.screen_point_to_world(e.pos);
        e.x = Std.int(e.pos.x);
        e.y = Std.int(e.pos.y);
    }

}
