/*
(c) 2010 Marielle Lange - All rights reserved.
*/
package com.widged.events
{
	import flash.events.Event;
	
	public class DataObjectEvent extends Event
	{
		private var _data:Object;
		
		public function DataObjectEvent(type:String, data:Object = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_data = data;
		}
		
		public function get data():Object { return _data; }
		
		override public function clone():Event
		{
			return new DataObjectEvent(type, data, bubbles, cancelable);
		}
	}
}