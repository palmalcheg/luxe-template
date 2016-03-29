package dk.miosis.luxetemplate.component;

import luxe.Color;
import luxe.Log.*;
import luxe.Vector;
import luxe.Visual;

import luxe.options.ComponentOptions;
import luxe.utils.Maths;

import phoenix.geometry.CircleGeometry;

import dk.miosis.luxetemplate.component.EuclidianSequencer;
import dk.miosis.luxetemplate.utility.MiosisUtilities;

typedef EuclidianVisualiserOptions = 
{
    > ComponentOptions,
    @:optional var layer_distance:Float;
    @:optional var point_radius:Float;
}

class EuclidianVisualiser extends luxe.Component
{
    var _layer_count:Int;
    var _layer_distance:Float;
    var _total_radius:Float;
    var _point_radius:Float;
    var _origin:Vector;
    var _temp_point:Vector;
    var _points:Array<Vector>;
    var _base_delta_angle:Float;
    var _base_delta_half_angle:Float;
    var _palette:Array<Int>;
    var _angles:Array<Float>;
    var _circles:Array<Visual>;
    var _sweep_line:Visual;
    var _progress:Float;

    var _sequencer:EuclidianSequencer;

    public function new(?options:EuclidianVisualiserOptions) 
    {
        _debug("---------- EuclidianVisuliser.new ----------");

        // Set component options

        if (options == null) 
        {
            options = { name : "euclidian_visualizer_component"};
        } 
        else if (options.name == null)
        {
            options.name = "euclidian_visualiser_component";
        }

        // Init view variables and data structures

        _progress = 0.0;
        _origin = new Vector(0.5 * Main.w, 0.5 * Main.h);
        _temp_point = new Vector();
        _points = new Array<Vector>();
        _angles = new Array<Float>();
        _circles = new Array<Visual>();

        if (options != null && options.layer_distance != null)
        {
            _layer_distance = options.layer_distance;
        }
        else
        {
            _layer_distance = 5.0;            
        }

        if (options != null && options.point_radius != null)
        {
            _point_radius = options.point_radius;
        }
        else
        {
            _point_radius = 10.0;            
        }

        // Set palette

        _palette = new Array<Int>();

        _palette.push(0xff5db89d);
        _palette.push(0xff007034);
        _palette.push(0xff8c8535);
        _palette.push(0xffffca00);
        _palette.push(0xfff26547);

        super(options);
    }

    override public function onadded()
    {
        _sequencer = get('euclidian_sequencer_component');

        assertnull(_sequencer, 'Euclidian sequencer component not found on entity ' + entity.name); 

        _layer_count = _sequencer.get_sound_count();
        _base_delta_angle = 2 * Math.PI / _sequencer.notes_per_bar;
        _base_delta_half_angle = 0.5 * _base_delta_angle;
        _total_radius = _layer_count * _layer_distance + 10;

        for (i in 0..._sequencer.notes_per_bar)
        {
            _angles.push(i * _base_delta_angle);

            _temp_point.x = _origin.x + _total_radius * Math.cos(_angles[i] + _base_delta_half_angle);
            _temp_point.y = _origin.y + _total_radius * Math.sin(_angles[i] + _base_delta_half_angle);

            Luxe.draw.line({
                p0 : new Vector(_origin.x, _origin.y),
                p1 : _temp_point.clone(),
                color : new Color(1.0, 0.0, 0.0, 1)
                });

            for (j in 0..._layer_count)
            {
                var distance_from_origin:Float = (j + 1) * _layer_distance + 7.5;

                _temp_point.x = _origin.x + distance_from_origin * Math.cos(_angles[i]);
                _temp_point.y = _origin.y + distance_from_origin * Math.sin(_angles[i]);

                var circle_geometry = Luxe.draw.circle({
                    x : _temp_point.x,
                    y : _temp_point.y,
                    r : _point_radius,
                        // color : new Color().rgb(_palette[j])
                        color : new Color(1,1,1,1)                   
                        });
                // var circle = new Visual({ 
                //     name : 'circle_visual_' + (i * _layer_count + j),
                //     geometry : circle_geometry,
                //     // visible : false
                //     });
                // _circles.push(circle);
            }
        }

        var current_angle = 2 * Math.PI * 0.75;

        _temp_point.x = _origin.x + _total_radius * Math.cos(current_angle);
        _temp_point.y = _origin.y + _total_radius * Math.sin(current_angle);    

        _debug(_total_radius);  


        var line_geometry = Luxe.draw.line({
            p0 : _origin,
            p1 : _temp_point.clone(),
            // color : new Color().rgb(_palette[4])
            color : new Color(0.0, 1.0, 1.0, 1)
            });
        _sweep_line = new Visual({ 
            name : 'sweep_line_visual',
            geometry : line_geometry
            });
    }


    override public function update(dt:Float):Void 
    {
        // _debug("---------- EuclidianVisuliser.update ----------");

        if (_sequencer == null)
        {
            super.update(dt);
            return;
        }

        var currentAngle = 2 * Math.PI * _progress;
        var fractionalPart = currentAngle / _base_delta_angle;
        var integerPart = Std.int(fractionalPart);
        fractionalPart -= integerPart;

        for (i in 0..._angles.length)
        {
            for (j in 0..._layer_count)
            {
                var distance_from_origin:Float = (j + 1) * _layer_distance;

                _temp_point.x = _origin.x + distance_from_origin * Math.cos(_angles[i]);
                _temp_point.y = _origin.y + distance_from_origin * Math.sin(_angles[i]);

                if (_sequencer.is_note_on(i, j))
                {
                    if (integerPart == i && fractionalPart < 0.5)
                    {
                        // _pointGeometries[i * _angles.length + j].
                    }
                    else
                    {
                        // Luxe.draw.ring({
                        //     x : _temp_point.x,
                        //     y : _temp_point.y,
                        //     r : point_radius * 1.5,
                        //     color : new Color().rgb(_palette[j])
                        //     });
                    }                   
                }
            }
        }

        super.update(dt);
    }

    public function set_progress(value:Float):Void
    {
        _progress = value;
    }

    override public function onremoved():Void 
    {
        _debug("---------- EuclidianVisuliser.onremoved ----------");

        // MiosisUtilities.clear(_note_offsets);
        // _note_offsets = null;

    }
}
