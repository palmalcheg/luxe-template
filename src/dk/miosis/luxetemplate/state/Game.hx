package dk.miosis.luxetemplate.state;

import luxe.Color;
import luxe.Input;
import luxe.Log.*;
import luxe.Sprite;
import luxe.States;
import luxe.Text;
import luxe.Vector;

import mint.Button;

import phoenix.Batcher;
import phoenix.Texture;

import dk.miosis.luxetemplate.Constants;
import dk.miosis.luxetemplate.entity.Player;
import dk.miosis.luxetemplate.state.BaseState;
import dk.miosis.luxetemplate.system.PlayerInputSystem;
import dk.miosis.luxetemplate.ui.MiosisButtonRender;
import dk.miosis.luxetemplate.ui.MiosisMintRendering;

class Game extends BaseState {

    var player:Player;
    var inputSystem:PlayerInputSystem;
    var button:Button;

	public function new() {
        super({ name:'game' });
    }

	override function onenter<T>(_:T) {
        // Set background color
        Luxe.renderer.clear_color = Constants.GAME_BOY_COLOR_OFF;

        player = new Player();
        inputSystem = new PlayerInputSystem();
        inputSystem.addComponentTo(player);

        button = new Button({
            parent: Main.canvas, 
            name: 'testbutton', 
            text: 'test',
            rendering: new MiosisMintRendering({ batcher: Main.ui_batcher }),
            x: 0.1 * Main.w, y:0.1 * Main.h, w:30, h: 20
        });

        var txt:Text = Luxe.scene.get('testbutton.label.text');
        txt.font = Luxe.resources.font('assets/font/justabit/justabit32.fnt');
        txt.point_size = 16;
        txt.geom.texture = txt.font.pages[0];
        txt.color = Constants.GAME_BOY_COLOR_DARK;

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

        super.onenter(_);
    }

	override function onkeyup(e:KeyEvent) {
        if(e.keycode == Key.escape) {
            Luxe.shutdown();
        }
    }

    override function update(dt:Float) {
        inputSystem.update(dt);
    }
    
}
