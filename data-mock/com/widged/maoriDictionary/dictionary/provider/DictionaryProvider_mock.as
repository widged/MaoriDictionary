package com.widged.maoriDictionary.dictionary.provider
{
	import com.widged.io.events.ProviderResultEvent;
	import com.widged.io.sqlite.SQLiteDataProvider;
	import com.widged.maoriDictionary.dictionary.vo.RowsCursor;
	
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.filesystem.File;
	
	public class DictionaryProvider_mock extends SQLiteDataProvider implements IDictionaryProvider
	{
		
		public function DictionaryProvider_mock(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function init():void { }
		
		public function listWords():void
		{
			dispatcher.dispatchEvent(new ProviderResultEvent(ProviderResultEvent.RESULT, DictionaryData.wordList));
		}	
		
		public function listWordsForLetter(letter:String):void
		{
			dispatcher.dispatchEvent(new ProviderResultEvent(ProviderResultEvent.RESULT, DictionaryData.wordList));
		}	
		
		
		public function listWordsForSearchKey(key:String):void
		{
			//
		}

		public function countWordsForLetter(letter:String):void
		{
			dispatcher.dispatchEvent(new ProviderResultEvent(ProviderResultEvent.RESULT, DictionaryData.wordList.length));
		}

		public function countWordsForSearchKey(key:String):void
		{
			dispatcher.dispatchEvent(new ProviderResultEvent(ProviderResultEvent.RESULT, DictionaryData.wordList.length));
		}	
		
		
	}
}