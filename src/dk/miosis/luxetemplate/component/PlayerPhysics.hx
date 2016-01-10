package dk.miosis.luxetemplate.component;

import luxe.Component;
import luxe.Input;
import luxe.Log.*;
import luxe.Sprite;
import luxe.Vector;

class PlayerPhysics extends Component
{
	var max_vel = 50;
    var air_vel = 60;
    var move_spd = 600;
    var jump_force = 200;
    var damp = 0.72;
    var damp_air = 0.9;
    var jumpsAvailable:Int = 0;

	var movement_vector:Vector;
	var sprite:Sprite;
	var halfSize:Float;

	public override function init() 
	{
		movement_vector = new Vector();
		sprite = cast entity;

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

	public override function update(dt:Float) 
	{
		movement_vector.set_xyz(0, 0, 0); // Reset

		if(Luxe.input.inputdown('a') || Luxe.input.inputdown('left')) 
		{
			movement_vector.x = -1;
		}

		if(Luxe.input.inputdown('d') || Luxe.input.inputdown('right')) 
		{
			movement_vector.x = 1;
		}

		if(Luxe.input.inputdown('w') || Luxe.input.inputdown('up')) 
		{
			movement_vector.y = -1;
		}

		if(Luxe.input.inputdown('s') || Luxe.input.inputdown('down')) 
		{
			movement_vector.y = 1;
		}

		movement_vector.normalize();
		pos.add(movement_vector);

		if (pos.x < halfSize) 
		{
			pos.x = halfSize;
		}

		if (pos.x > (Main.w - halfSize)) 
		{
			pos.x = Main.w - halfSize;
		}

		if (pos.y < halfSize) 
		{
			pos.y = halfSize;
		}

		if (pos.y > (Main.h - halfSize)) 
		{
			pos.y = Main.h - halfSize;
		}
	}
}
