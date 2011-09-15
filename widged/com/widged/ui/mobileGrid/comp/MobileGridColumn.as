package com.widged.ui.mobileGrid
{
    public class MobileGridColumn
    {
        public var label:String;
        public var width:int;
        public var identifier:String;
        public var format:int;
        
        public static const FORMAT_TICK_BOX:int           = 1;
        public static const FORMAT_SCORE_BAR:int          = 2;
        public static const FORMAT_ICON:int               = 3;
        public static const FORMAT_ROUNDED_VALUE:int      = 4;
        
        public function MobileGridColumn(identifier:String, label:String, width:int, format:int = 0)
        {
            this.label      = label;
            this.width      = width;
            this.identifier = identifier;
            this.format     = format;
        }
    }
}