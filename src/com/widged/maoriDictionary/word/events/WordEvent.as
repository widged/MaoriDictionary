package com.widged.maoriDictionary.word.events
{
	import com.widged.events.DataObjectEvent;
	
	public class WordEvent extends DataObjectEvent
	{

		public static const WORD_SELECT:String           = "wordSelected";

		public function WordEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
	}
}