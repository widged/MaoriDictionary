package com.widged.media.image.frames
{
    import embed.skins.CompletionTickSkin;
    
    import spark.components.Button;
    import com.widged.media.imageFrames.skin.CompletionTickSkin;
    
    [Style(name="status", type="uint", inherit="no")]    
    public class CompletionTick extends Button
    {
        public static const NA:int     = 0;
        public static const PASSED:int = 1;
        public static const FAILED:int = 2;
        
        public function CompletionTick()
        {
            super();
            this.setStyle('skinClass', Class(CompletionTickSkin));
        }
        
        public function set status(value:int):void 
        {
            this.setStyle('status', value);
        }
    }
}