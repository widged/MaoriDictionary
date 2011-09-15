/*
(c) 2010 Marielle Lange - All rights reserved.
*/
package com.widged.io.events
{
	import flash.events.Event;
	
	public class ProviderResultEvent extends Event
	{
		public static const RESULT:String  = "result";

		private var _result:*;
		
		public function ProviderResultEvent(type:String, result:* = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_result = result;
		}
		
		public function get result():* { return _result; }
		
		override public function clone():Event
		{
			return new ProviderResultEvent(type, result, bubbles, cancelable);
		}
	}
}