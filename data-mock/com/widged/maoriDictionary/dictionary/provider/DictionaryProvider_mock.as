package com.widged.maoriDictionary.dictionary.provider
{
	import com.widged.io.events.ProviderResultEvent;
	import com.widged.io.sqlite.SQLiteDataProvider;
	
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
		
		/**
		 * Get the list of words from the database. 
		 **/
		public function listWords():void
		{
			dispatcher.dispatchEvent(new ProviderResultEvent(ProviderResultEvent.RESULT, DictionaryData.wordList));
		}	
		
		/**
		 * Get the list of words starting with a given letter from the database. 
		 * 
		 * @param letter String
		 **/
		public function listWordsForLetter(letter:String):void
		{
		}	
		
		/**
		 * Gets the number of completed surveys from the surveys table 
		 * 		 
		 * @param args Array [responder:DatabaseRespodner]
		 **/
		public function countWordsForLetter(letter:String):void
		{
			dispatcher.dispatchEvent(new ProviderResultEvent(ProviderResultEvent.RESULT, DictionaryData.wordList.length));
		}
		
		public function listWordsForSearchKey(key:String):void
		{
			//
			
		}
		
		
	}
}