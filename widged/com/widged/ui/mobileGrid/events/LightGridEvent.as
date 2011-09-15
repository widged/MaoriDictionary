package com.widged.ui.mobileGrid.events
{
	import com.widged.events.DataObjectEvent;
    
    public class MobileGridEvent extends DataObjectEvent
    {
        public static const ITEM_CLICK:String = "itemClick;"
            

        public function MobileGridEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(type, data, bubbles, cancelable);
        }
    }
}