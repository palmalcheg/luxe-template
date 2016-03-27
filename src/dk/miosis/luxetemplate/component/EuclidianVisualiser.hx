package dk.miosis.luxetemplate.component;

import luxe.Color;
import luxe.Log.*;
import luxe.Vector;
import luxe.options.ComponentOptions;
import luxe.utils.Maths;

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
            _point_radius = 4.0;            
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
        _total_radius = _layer_count * _layer_distance;

        for (i in 0..._sequencer.notes_per_bar)
        {
            _angles.push(i * _base_delta_angle);
        }
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
            _temp_point.x = _origin.x + _total_radius * Math.cos(_angles[i] + _base_delta_half_angle);
            _temp_point.y = _origin.y + _total_radius * Math.sin(_angles[i] + _base_delta_half_angle);

            Luxe.draw.line({
                p0 : new Vector(_origin.x, _origin.y),
                p1 : new Vector(_temp_point.x, _temp_point.y),
                color : new Color(1.0, 0.0, 0.0, 1)
                });

            for (j in 0..._layer_count)
            {
                var distance_from_origin:Float = (j + 1) * _layer_distance;

                _temp_point.x = _origin.x + distance_from_origin * Math.cos(_angles[i]);
                _temp_point.y = _origin.y + distance_from_origin * Math.sin(_angles[i]);

                // if (_manager.isSoundNoteOn(i, j))
                // {
                //     if (integerPart == i && fractionalPart < 0.5)
                //     {
                //         drawCircle(_temp_point.x, _temp_point.y, _pointRadius * 1.5, _palette[j]);
                //     }
                //     else
                //     {
                //         drawCircle(_temp_point.x, _temp_point.y, _pointRadius, _palette[j]);
                //     }                   
                // }
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
