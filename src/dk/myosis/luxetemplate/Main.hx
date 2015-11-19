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
import mint.types.Types;
import mint.render.luxe.LuxeMintRender;
import mint.render.luxe.Convert;
import mint.layout.margins.Margins;

import dk.myosis.luxetemplate.states.Game;
import dk.myosis.luxetemplate.states.Splash;
import dk.myosis.luxetemplate.systems.PlayerInputSystem;
import dk.myosis.luxetemplate.ui.CustomButtonRenderer;
import dk.myosis.luxetemplate.ui.CustomRenderering;


class Main extends luxe.Game {

    public static var mintRenderer:LuxeMintRender;
    public static var canvas:Canvas;

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
        config.preload.fonts.push({ id:'assets/font/justabit/justabit64.fnt' });

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
            options: { color:new Color(1, 0, 1, 1) },
            x: 0, y:0, w: 100, h: 100
        });

        // var button = new Button( {
        //     parent: canvas,
        //     name: "test_button",
        //     x: 0, y:0, w:30, h: 20,
        //     text: "start",
        //     options: { color:new Color(0, 1, 0, 1) },
        //     onclick: function(e,c) {trace('Button - MouseUp! ${Luxe.time}' );}
        // } );

        // var font = Luxe.resources.font('assets/font/justabit/justabit64.fnt');
        // var txt:Text = Luxe.scene.get('test_button.label.text');
        // txt.font = font;
        // txt.point_size = 8;
        // txt.geom.texture = txt.font.pages[0];

        _states = new States({ name:'states' });
        _states.add(new Splash());
        _states.add(new Game());
        _states.set("game");

        _button = new Button({
            parent: canvas, 
            name: 'testbutton', 
            text: 'Test',
            rendering: new CustomRendering(),
            x: 0, y:0, w:30, h: 20,
            onclick: function(e,c) { trace('mint button! ${Luxe.time}' );}
        });

        _button.depth = 3;
        // _button.onmouseenter.listen(function(e,c) { trace('MouseUp: mint button ${Luxe.time}' );});

        var font = Luxe.resources.font('assets/font/justabit/justabit64.fnt');
        var txt:Text = Luxe.scene.get('testbutton.label.text');
        txt.font = font;
        txt.point_size = 16;
        txt.geom.texture = txt.font.pages[0];
    }

    override function onrender() {

        canvas.render();

        // if(debug) {
        //     for(c in canvas.children) {
        //         drawc(c);
        //     }
        // }

    }

    override function onmouseup(e) {
        trace("Main - MouseUp");
        canvas.mouseup( Convert.mouse_event(e) );
    }

    override function onmousemove(e) {
        // trace("Main - MouseMove");
        canvas.mousemove( Convert.mouse_event(e) );

        var s = 'debug:  (${Luxe.snow.os} / ${Luxe.snow.platform})\n';

        s += 'canvas nodes: ' + (canvas != null ? '${canvas.nodes}' : 'none');
        s += '\n';
        s += 'focused: ' + (canvas.focused != null ? '${canvas.focused.name} [${canvas.focused.nodes}]' : 'none');
        s += (canvas.focused != null ? ' / depth: '+canvas.focused.depth : '');
        s += '\n';
        s += 'modal: ' + (canvas.modal != null ?  canvas.modal.name : 'none');
        s += '\n';
        s += 'dragged: ' + (canvas.dragged != null ? canvas.dragged.name : 'none');
        s += '\n\n';

        trace(s);
    }

    // Scale camera's viewport accordingly when game is scaled, common and suitable for most games
    override function onwindowsized( e:WindowEvent ) {
        Luxe.camera.viewport = new luxe.Rectangle(0, 0, e.event.x, e.event.y);
    }

    override function update(dt:Float) {
        // trace("----- Main update -----");
        canvas.update(dt);
        _inputSystem.update(dt);

        // if (_button.ishovered) {
        //     trace('MouseHover: mint button ${Luxe.time}' );
        // }
    }

}
