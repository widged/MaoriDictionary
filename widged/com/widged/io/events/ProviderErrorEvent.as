/*
(c) 2010 Marielle Lange - All rights reserved.
*/
package com.widged.io.events
{
	import flash.events.Event;
	
	public class ProviderErrorEvent extends Event
	{
		public static const FAULT:String  = "fault";
		
		private var _msg:String;
		
		public function ProviderErrorEvent(type:String, msg:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_msg = msg;
		}
		
		public function get msg():String { return _msg; }
		
		override public function clone():Event
		{
			return new ProviderErrorEvent(type, msg, bubbles, cancelable);
		}
	}
}