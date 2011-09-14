package com.widged.maoriDictionary.framework.events
{
	import com.widged.events.DataObjectEvent;

	
	public class FrameworkEvent extends DataObjectEvent
	{
		public static const INFO_SELECT:String           = "infoSelect";
		public static const INFO_CLOSE:String            = "infoClose";
		public static const SPLASH_CLOSE:String          = "splashClose";
		public static const WORD_SELECT:String           = "wordSelected";
		public static const WORD_CLOSE:String            = "wordClose";
		public static const DICTIONARY_SEARCH:String     = "dictionarySearch";
		public static const LETTER_POINTER_CHANGE:String = "letterPointerChange";

		public function FrameworkEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
	}
}