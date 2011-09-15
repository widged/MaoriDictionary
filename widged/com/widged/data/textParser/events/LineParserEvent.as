package com.widged.data.textParser.events
{
	import com.widged.events.DataObjectEvent;
	
	import flash.events.Event;
	
	public class LineParserEvent extends DataObjectEvent
	{
		public static const PROGRESS:String = "progress";
		public static const COMPLETE:String = "complete";
		public static const ROW_ADDED:String  = "rowAdded";

		public function LineParserEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
	}
}