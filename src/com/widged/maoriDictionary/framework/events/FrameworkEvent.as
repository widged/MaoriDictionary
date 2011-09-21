package com.widged.maoriDictionary.framework.events
{
	import com.widged.events.DataObjectEvent;

	
	public class FrameworkEvent extends DataObjectEvent
	{
		public static const DICTIONARY_SELECT:String     = "dictionarySelect";
		public static const DICTIONARY_SEARCH:String     = "dictionarySearch";
		public static const LETTER_POINTER_CHANGE:String = "letterPointerChange";

		public function FrameworkEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
	}
}