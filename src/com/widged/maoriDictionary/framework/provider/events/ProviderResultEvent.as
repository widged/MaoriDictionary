package com.widged.maoriDictionary.framework.provider.events
{
	import com.widged.events.DataObjectEvent;

	public class ProviderResultEvent extends DataObjectEvent
	{
		public static const RESULT:String  = "result";
		
		public function ProviderResultEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
	}
}