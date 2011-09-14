package com.widged.maoriDictionary.dictionary.provider
{
	import com.widged.maoriDictionary.dictionary.provider.DictionaryProvider_sqlite;
	import com.widged.maoriDictionary.dictionary.provider.IDictionaryProvider;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class DictionaryProvider extends EventDispatcher implements IDictionaryProvider
	{
		//	private var converter:DictionaryProviderConverter;
		private var sqlite:IDictionaryProvider;
		private var mock:IDictionaryProvider;
		
		public function DictionaryProvider(target:IEventDispatcher=null)
		{
			super(target);
			// converter = new DictionaryProviderConverter();
			sqlite = new DictionaryProvider_sqlite(this);
			mock   = new DictionaryProvider_mock(this);
		}
		
		public function init():void
		{
			sqlite.init();
		}
		
		public function listWords():void
		{
			sqlite.listWords();
		}
		
		public function listWordsForLetter(letter:String):void
		{
			sqlite.listWordsForLetter(letter);
		}
		
		public function listWordsForSearchKey(key:String):void
		{
			sqlite.listWordsForSearchKey(key);
			
		}
		
	}
}