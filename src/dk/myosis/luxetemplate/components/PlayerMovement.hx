package dk.myosis.luxetemplate.components;

import haxe.Int64;

import luxe.Component;
import luxe.Sprite;
import luxe.Vector;

class PlayerMovement extends Component
{
    // Current movement vector
	public var movement_vector:Vector;
	public var sprite:Sprite;
	public var halfSize:Float;

	public override function init() {

		movement_vector = new Vector();
		sprite = cast entity;
	}

}
