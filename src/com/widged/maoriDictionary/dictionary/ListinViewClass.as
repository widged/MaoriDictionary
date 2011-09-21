package com.widged.maoriDictionary.dictionary
{
	import com.widged.maoriDictionary.word.WordPopup;
	import com.widged.maoriDictionary.word.events.WordEvent;
	import com.widged.maoriDictionary.word.vo.WordItem;
	
	import flash.events.Event;
	
	import spark.components.View;
	
	public class ListinViewClass extends View
	{
		public function ListinViewClass()
		{
			super();
		}
		
		// #################################
		// ##  Word Details
		// #################################
		
		private var wordPopup:WordPopup;
		protected function onWordSelection(event:WordEvent):void
		{
			event.stopPropagation();
			wordPopup = new WordPopup();
			wordPopup.item = event.data as WordItem;
			wordPopup.addEventListener(Event.CLOSE, onWordClose);
			addElement(wordPopup);
		}
		
		private function onWordClose(event:Event):void
		{
			wordPopup.removeEventListener(Event.CLOSE, onWordClose);
			removeElement(wordPopup);
			wordPopup = null;
		}			
		
		// #################################
		// ##  Info windows
		// #################################
		
		private var infoPopup:InfoPopup;
		protected function onInfoClick(event:Event):void
		{
			event.stopPropagation();
			infoPopup = new InfoPopup();
			infoPopup.addEventListener(Event.CLOSE, onInfoClose);
			this.addElement(infoPopup);
		}
		
		private function onInfoClose(event:Event):void
		{
			infoPopup.removeEventListener(Event.CLOSE, onInfoClose);
			removeElement(infoPopup);
			infoPopup = null;
		}			
	}
}