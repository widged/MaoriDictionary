package com.widged.maoriDictionary.framework.provider.events
{
	import com.widged.events.DataObjectEvent;
	
	public class ProviderEvent extends DataObjectEvent
	{
		public static const READY:String   = "ready";

		public function ProviderEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
	}
}