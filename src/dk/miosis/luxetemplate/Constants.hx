package dk.miosis.luxetemplate;

import  haxe.Int64;
import luxe.Color;

// @:enum
// abstract Platforms(Int) 
// {
// 	var Mac = 0;
// 	var Windows = 1;
// 	var Linux = 2;
// }

// @:enum
// abstract Gamepads(Int) 
// {
// 	var PS3 = 0;
// 	var Xbox360 = 1;
// }

// @:enum
// abstract GamepadButtons(Int) 
// {
// 	var Cross = 0;
// 	var Square = 1;
// 	var Triangle = 2;
// 	var Circle = 2;	
// }

class Constants
{
	public static var GAME_SCALE(default, never):Int = 2;

	public static var COLOR_TRANSPARENT(default, never):Color = new Color().set(1, 0, 1, 0);
	// // Game Boy palette, gray 1
	// public static var GAME_BOY_COLOR_OFF(default, never):Color = new Color().rgb(0xffffff);
	// public static var GAME_BOY_COLOR_LIGHT(default, never):Color = new Color().rgb(0xb2b2b2);
	// public static var GAME_BOY_COLOR_MEDIUM(default, never):Color = new Color().rgb(0x757575);
	// public static var GAME_BOY_COLOR_DARK(default, never):Color = new Color().rgb(0x000000);

	// Game Boy palette, gray 2
	public static var GAME_BOY_COLOR_OFF(default, never):Color = new Color().rgb(0xefefef);
	public static var GAME_BOY_COLOR_LIGHT(default, never):Color = new Color().rgb(0xb2b2b2);
	public static var GAME_BOY_COLOR_MEDIUM(default, never):Color = new Color().rgb(0x757575);
	public static var GAME_BOY_COLOR_DARK(default, never):Color = new Color().rgb(0x383838);

	// // Game Boy palette, green 1
	// public static var GAME_BOY_COLOR_OFF(default, never):Color = new Color().rgb(0x9BBC0F);
	// public static var GAME_BOY_COLOR_LIGHT(default, never):Color = new Color().rgb(0x8BAC0F);
	// public static var GAME_BOY_COLOR_MEDIUM(default, never):Color = new Color().rgb(0x306230);
	// public static var GAME_BOY_COLOR_DARK(default, never):Color = new Color().rgb(0x0F380F);

	// // Game Boy palette, green 2
	// public static var GAME_BOY_COLOR_OFF(default, never):Color = new Color().rgb(0xb7dc11);
	// public static var GAME_BOY_COLOR_LIGHT(default, never):Color = new Color().rgb(0x88a808);
	// public static var GAME_BOY_COLOR_MEDIUM(default, never):Color = new Color().rgb(0x306030);
	// public static var GAME_BOY_COLOR_DARK(default, never):Color = new Color().rgb(0x083808);

	// // Game Boy palette, yellow
	// public static var GAME_BOY_COLOR_OFF(default, never):Color = new Color().rgb(0xfff77b);
	// public static var GAME_BOY_COLOR_LIGHT(default, never):Color = new Color().rgb(0xb5ae4a);
	// public static var GAME_BOY_COLOR_MEDIUM(default, never):Color = new Color().rgb(0x6b6931);
	// public static var GAME_BOY_COLOR_DARK(default, never):Color = new Color().rgb(0x212010);

	public static var GamepadMappings:Map<String, Map<String, Int>> = 
	[
		"ps3_mac" => 
			[
				// Buttons
				"button_cross" => 0,
				"button_circle" => 1,
				"button_square" => 2,
				"button_triangle" => 3,
				"button_select" => 4,
				"button_ps" => 5,
				"button_start" => 6,
				"button_left_stick" => 7,
				"button_right_stick" => 8,				
				"button_left_shoulder" => 9,
				"button_right_shoulder" => 10,
				"dpad_up" => 11,
				"dpad_down" => 12,
				"dpad_left" => 13,
				"dpad_right" => 14,
				// Axes
				"stick_left_x" => 0,				
				"stick_left_y" => 1,
				"stick_right_x" => 2,
				"stick_right_y" => 3,				
				"trigger_left" => 4,
				"trigger_right" => 5,
			]
	];
}
