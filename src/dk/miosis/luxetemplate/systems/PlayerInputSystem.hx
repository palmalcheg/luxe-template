package dk.miosis.luxetemplate.systems;

import luxe.Input;
import luxe.Objects;
import luxe.Sprite;
import luxe.Vector;

import dk.miosis.luxetemplate.entities.Player;
import dk.miosis.luxetemplate.components.PlayerMovement;

class PlayerInputSystem extends luxe.Objects {

	var components:Array<PlayerMovement>;

	public function new() {
        super();

		components = new Array<PlayerMovement>();

        // Bind keys
        Luxe.input.bind_key('a', Key.key_a);
        Luxe.input.bind_key('left', Key.left);
        Luxe.input.bind_key('d', Key.key_d);
        Luxe.input.bind_key('right', Key.right);
		Luxe.input.bind_key('w', Key.key_w);
        Luxe.input.bind_key('up', Key.up);
		Luxe.input.bind_key('s', Key.key_s);
        Luxe.input.bind_key('down', Key.down);
  	}

	public function addComponentTo(player:Player):PlayerMovement {
		var component = new PlayerMovement();
		component.halfSize = player.size.x * 0.5;
		player.add(component);
		components.push(component);
		return component;
	}

	public function update(dt:Float) {
		if (components == null) {
			return;
		}

		for (i in 0 ... components.length) {

			components[i].movement_vector.set_xyz(0, 0, 0); // Reset

			if(Luxe.input.inputdown('a') || Luxe.input.inputdown('left')) {
				components[i].movement_vector.x = -1;
			}

			if(Luxe.input.inputdown('d') || Luxe.input.inputdown('right')) {
				components[i].movement_vector.x = 1;
			}

			if(Luxe.input.inputdown('w') || Luxe.input.inputdown('up')) {
				components[i].movement_vector.y = -1;
			}

			if(Luxe.input.inputdown('s') || Luxe.input.inputdown('down')) {
				components[i].movement_vector.y = 1;
			}

			components[i].movement_vector.normalize();
			components[i].pos.add(components[i].movement_vector);

			if (components[i].pos.x < components[i].halfSize) {
				components[i].pos.x = components[i].halfSize;
			}

			if (components[i].pos.x > (Main.w - components[i].halfSize)) {
				components[i].pos.x = Main.w - components[i].halfSize;
			}

			if (components[i].pos.y < components[i].halfSize) {
				components[i].pos.y = components[i].halfSize;
			}

			if (components[i].pos.y > (Main.h - components[i].halfSize)) {
				components[i].pos.y = Main.h - components[i].halfSize;
			}
		}
	}
	
}
