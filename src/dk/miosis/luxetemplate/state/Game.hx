package dk.miosis.luxetemplate.state;

import luxe.Color;
import luxe.Input;
import luxe.Log.*;
import luxe.Sprite;
import luxe.States;
import luxe.Text;
import luxe.Vector;

import luxe.collision.shapes.Polygon;

import luxe.importers.tiled.TiledMap;
import luxe.importers.tiled.TiledObjectGroup;

import mint.Button;

import phoenix.Batcher;
import phoenix.Texture;
import phoenix.Texture.FilterType;

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

    var map:TiledMap;
    var map_scale:Int = 1;

	public function new() {
        super({ name:'game' });
    }

	override function onenter<T>(_:T) {
        trace("Entering Game state.");
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

        create_map();
        create_map_collision();
        super.onenter(_);
    }

    function create_map() 
    {         
        var map_data = Luxe.resources.text('assets/tiled/simple_160x144_8x8_map.tmx').asset.text;
        assertnull(map_data, 'Resource not found!');     
        map = new TiledMap({
            asset_path:"assets/tiled/",
            format:'tmx', 
            tiled_file_data: map_data });
        map.display({ scale:map_scale, filter:FilterType.nearest });
    }

    function create_map_collision() {
        var layerTiles = map.layer('collision');
        assertnull(layerTiles, 'Map layer _collision_ not found!');
        var bounds = layerTiles.bounds_fitted();
        trace("SNOOK");

        for(bound in bounds) {
            bound.x *= map.tile_width * map_scale;
            bound.y *= map.tile_height * map_scale;
            bound.w *= map.tile_width * map_scale;
            bound.h *= map.tile_height * map_scale;
            Main.sim.obstacle_colliders.push(Polygon.rectangle(bound.x, bound.y, bound.w, bound.h, false));
        }

    } //create_map_collision

	override function onkeyup(e:KeyEvent) {
        if(e.keycode == Key.escape) {
            Luxe.shutdown();
        }
    }

    override function update(dt:Float) {
        inputSystem.update(dt);
    }
    
}
