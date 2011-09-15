package com.widged.media.image.frames
{
    import com.widged.media.imageFrames.skin.ProgressBarSkin;
    
    import spark.components.Button;
    
    [Style(name="score", type="Number", inherit="no")]    
    public class ProgressBar extends Button
    {
        
        public function ProgressBar()
        {
            super();
            this.setStyle('skinClass', Class(ProgressBarSkin));
        }
        
        public function set score(value:Number):void 
        {
            this.setStyle('score', value);
        }
    }
}