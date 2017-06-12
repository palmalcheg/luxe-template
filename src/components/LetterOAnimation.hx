package components;

import luxe.Log.*;
import luxe.components.sprite.SpriteAnimation;
import luxe.options.ComponentOptions;

class LetterOAnimation extends SpriteAnimation 
{
    public function new(?_options:ComponentOptions) 
    {
        _debug("---------- LetterOAnimation.new ----------");  

        def(_options, { name :'animation' });  
        def(_options.name, 'animation');    

        super(_options);
    }

    override function init() 
    {
        _debug("---------- LetterOAnimation.init ----------");        

        var anim_json = Luxe.resources.json('assets/json/animation/splash_anim.json');
        add_from_json_object(anim_json.asset.json);
        animation = 'splash';
        play();
    }

    override function onremoved()
    {
        _debug("---------- LetterOAnimation.onremoved ----------");
    }

    override function ondestroy()
    {
        _debug("---------- LetterOAnimation.ondestroy ----------");
    }
}
