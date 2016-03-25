package dk.miosis.luxetemplate.utility;

import luxe.Log.*;
class Bjorklund
{
    public var bitmaskString:String;
    public var bitmask:Int;
    var pattern:Array<Int>;
    var counts:Array<Int>;
    var remainders:Array<Int>;

    public function new() 
    {
        _debug("---------- Bjorklund.new ----------");

        counts = new Array<Int>();
        remainders = new Array<Int>();
        pattern = new Array<Int>();
    }

    public function run(steps:Int, pulses:Int):Void
    {
        _debug("---------- Bjorklund.run ----------");

        if (pulses > steps)
        {
            _debug("AAAAAAAAAAAAAAAKAÆLAKJÆALKJAL");
        }

        // Constants.clear(counts);
        // Constants.clear(remainders); 

        counts = [];
        remainders = [];
        pattern = [];
        bitmask = 0;
        bitmaskString = "";  

        var divisor = steps - pulses;

        remainders.push(pulses);
        
        var level = 0;

        do 
        {
            counts.push(Std.int(divisor / remainders[level]));
            remainders.push(divisor % remainders[level]);
            divisor = remainders[level];
            ++level;
        }
        while (remainders[level] > 1); 

        counts.push(divisor);

        build(level);

        // _debug("********* RESULT : " + bitmaskString);

        var index = bitmaskString.indexOf("1");
        bitmaskString = bitmaskString.substring(index) + bitmaskString.substring(0, index);

        _debug("********* RESULT : " + bitmaskString);
    }

    function build(level:Int):Void
    {
        // _debug("---------- Bjorklund.build ----------" + " level : " + level);

        if (level == -1)
        {
            pattern.push(0);
            bitmaskString += 0;
        }
        else if (level == -2)
        {
            pattern.push(1);
            bitmaskString += 1;
        }                
        else
        {
            for (i in 0...counts[level])
            {
                build(level - 1);
            }
            if (remainders[level] != 0)
            {
                build(level - 2);
            }
        }
    }
}
