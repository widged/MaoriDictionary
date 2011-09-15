package com.widged.ui.mobileGrid.comp
{
    import flash.events.IEventDispatcher;
    import flash.events.MouseEvent;
    
    import mx.core.IVisualElement;
    
    import spark.components.DataGroup;
    import spark.components.IItemRenderer;

    [Style(name="columns", type="Array", arrayType="com.widged.ui.mobileGrid.MobileGridColumn", inherit="no")]    
    public class MobileGridBody extends DataGroup
    {
        private var _columns:Array;
        private var _eventTarget:IEventDispatcher;
        public function MobileGridBody()
        {
            super();
        }
        
        public function set columns(value:Array):void  {  _columns = value; }
        public function get columns():Array    { return _columns; }
        
        
    }
}