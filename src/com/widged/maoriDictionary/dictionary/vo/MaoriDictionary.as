package com.widged.maoriDictionary.dictionary.vo
{
	import com.widged.maoriDictionary.dictionary.provider.DictionaryProvider_amfphp;
	import com.widged.maoriDictionary.dictionary.provider.DictionaryProvider_mock;
	import com.widged.maoriDictionary.dictionary.provider.DictionaryProvider_sqlite;
	import com.widged.maoriDictionary.dictionary.provider.IDictionaryProvider;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class MaoriDictionary extends EventDispatcher
	{
		//	private var converter:DictionaryProviderConverter;
		private var sqlite:IDictionaryProvider;
		private var mock:IDictionaryProvider;
		private var amfphp:IDictionaryProvider;
		
		public function MaoriDictionary(target:IEventDispatcher=null)
		{
			super(target);
			// converter = new DictionaryProviderConverter();
			sqlite = new DictionaryProvider_sqlite(this);
			mock   = new DictionaryProvider_mock(this);
			amfphp = new DictionaryProvider_amfphp(this);
		}
		
		public function init():void
		{
			sqlite.init();
			amfphp.init();
		}
		
		/**
		 * Get the list of words from the database. 
		 **/
		public function listWords():void
		{
			sqlite.listWords();
		}
		
		/**
		 * Get the list of words starting with the letter from the database. 
		 * 
		 * @param letter String
		 **/
		public function listWordsForLetter(letter:String, cursor:RowsCursor):void
		{
			sqlite.listWordsForLetter(letter, cursor.start, cursor.offset);
		}
		
		/**
		 * Get the list of words matching the search key from the database. 
		 * 
		 * @param letter String
		 **/
		public function listWordsForSearchKey(key:String, cursor:RowsCursor):void
		{
			sqlite.listWordsForSearchKey(key, cursor.start, cursor.offset);
		}

		/**
		 * Gets the number of words starting with the letter 
		 * 		 
		 * @param args Array [responder:DatabaseRespodner]
		 **/
		public function countWordsForLetter(letter:String):void
		{
			sqlite.countWordsForLetter(letter);
		}
		
		/**
		 * Get the number of words matching the search key from the database. 
		 * 
		 * @param letter String
		 **/
		public function countWordsForSearchKey(key:String):void
		{
			sqlite.countWordsForSearchKey(key);
		}	
		
	}
}