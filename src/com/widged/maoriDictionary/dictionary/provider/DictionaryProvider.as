package com.widged.maoriDictionary.dictionary.provider
{
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import com.widged.maoriDictionary.dictionary.vo.RowsCursor;
	
	public class DictionaryProvider extends EventDispatcher
	{
		//	private var converter:DictionaryProviderConverter;
		private var sqlite:IDictionaryProvider;
		private var mock:IDictionaryProvider;
		private var amfphp:IDictionaryProvider;
		
		public function DictionaryProvider(target:IEventDispatcher=null)
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
		public function listWordsForLetter(letter:String):void
		{
			sqlite.listWordsForLetter(letter);
		}
		
		/**
		 * Get the list of words matching the search key from the database. 
		 * 
		 * @param letter String
		 **/
		public function listWordsForSearchKey(key:String):void
		{
			sqlite.listWordsForSearchKey(key);
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