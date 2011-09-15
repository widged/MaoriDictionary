/*
(c) 2010 Marielle Lange - All rights reserved.
*/
package com.widged.io.events
{
	import flash.events.Event;
	
	public class ProviderStatusEvent extends Event
	{
		public static const READY:String     = "ready";
		public static const COMPLETE:String  = "complete";
		public static const STARTED:String   = "started";
		
		private var _msg:String;
		
		public function ProviderStatusEvent(type:String, msg:String = "", bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_msg = msg;
		}
		
		public function get msg():String { return _msg; }
		
		override public function clone():Event
		{
			return new ProviderStatusEvent(type, msg, bubbles, cancelable);
		}
	}
}