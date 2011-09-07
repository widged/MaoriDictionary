package com.widged.maoriDictionary.framework.provider.events
{
	import com.widged.events.DataObjectEvent;
	
	public class ProviderErrorEvent extends DataObjectEvent
	{
		public static const FAULT:String   = "fault";

		public function ProviderErrorEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
	}
}