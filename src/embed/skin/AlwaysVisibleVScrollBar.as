package embed.skin
{
    import spark.components.VScrollBar;
    
    /**
     * A Scroller with interactionMode="touch" fades the scrollbars away
     * after they are shown for a brief period of time.  This class
     * overrides that behavior to never fade away the VScrollBar. 
     */
    public class AlwaysVisibleVScrollBar extends VScrollBar
    {
        override public function set alpha(value:Number):void {
            //trace('ignore alpha', value);
        }
        
        override public function set visible(value:Boolean):void {
            //trace('ignore visible', value);
        }
        
        override public function set includeInLayout(value:Boolean):void {
            //trace('ignore includeInLayout', value);
        }
        
        override public function set scaleX(value:Number):void {
            //trace('ignore scaleX', value);
        }
        
        override public function set scaleY(value:Number):void {
            //trace('ignore scaleY', value);
        }
    }
}