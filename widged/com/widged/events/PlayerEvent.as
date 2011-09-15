package com.widged.events
{
	import flash.events.Event;
	
	public class PlayerEvent extends Event
	{
		public static const LOAD:String     = "load";
		public static const START:String    = "start";
		public static const STOP:String     = "stop";

		public function PlayerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}