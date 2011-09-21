package com.widged.maoriDictionary.dictionary.provider
{
	import com.widged.io.events.ProviderResultEvent;
	import com.widged.io.sqlite.SQLiteDataProvider;
	
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.filesystem.File;
	
	public class DictionaryProvider_sqliteCursor extends SQLiteDataProvider 
	{
		
		
		// statements
		private const GET_WORDS:String               = "SELECT * FROM dictionary";
		private const GET_WORDS_FOR_LETTER:String    = "SELECT * FROM dictionary WHERE letter = :letter";
		private const GET_WORDS_FOR_SEARCHKEY:String = "SELECT * FROM dictionary WHERE word LIKE :key OR definition LIKE :key";
		private const COUNT_WORDS_FOR_LETTER:String = "SELECT COUNT(id) AS count FROM dictionary WHERE letter = :letter";		
		private const COUNT_WORDS_FOR_SEARCHKEY:String = "SELECT COUNT(id) AS count FROM dictionary WHERE word LIKE :key OR definition LIKE :key";		
		
		public function DictionaryProvider_sqliteCursor(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function init():void
		{
			if(dbFile) { return; }
			dbFile = getApplicationFile("etc/db/maori_dictionary_0.2.db");
			// dbFile.url - app:/etc/db/maori_dictionary_0.1.db
			// app = /mnt/asec on Android
			openAsyncConnection(dbFile);
		}
		
		private function addCursor(query:String, start:int, offset:int):String
		{
			return query + " LIMIT :start,:offset";			
		}
		
		
		/**
		 * Get the list of words from the database. 
		 **/
		public function listWords():void
		{
			init();
			var statement:SQLStatement = toStatement(GET_WORDS);
			executeStatement(statement, listWordsResultHandler);
		}	
		
		/**
		 * Get the list of words starting with a given letter from the database. 
		 * 
		 * @param letter String
		 **/
		public function listWordsForLetter(letter:String, start:int, offset:int):void
		{
			init();
			var query:String = addCursor(GET_WORDS_FOR_LETTER, start, offset);
			var statement:SQLStatement = toStatement(query);
			statement.parameters[":letter"] = letter;
			statement.parameters[":start"] = start;
			statement.parameters[":offset"] = offset;
			executeStatement(statement, listWordsResultHandler);
		}	
		
		/**
		 * Get the list of words matching a search key from the database. 
		 * 
		 * @param letter String
		 **/
		public function listWordsForSearchKey(key:String, start:int, offset:int):void
		{
			init();
			var query:String = addCursor(GET_WORDS_FOR_SEARCHKEY, start, offset);
			var statement:SQLStatement = toStatement(query);
			statement.parameters[":key"] = "%" + key + "%";
			executeStatement(statement, listWordsResultHandler);
		}	
		
		/**
		 * Gets the number of words starting with a given letter 
		 * 		 
		 * @param args Array [responder:DatabaseRespodner]
		 **/
		public function countWordsForLetter(letter:String):void
		{
			init();
			var statement:SQLStatement = toStatement(COUNT_WORDS_FOR_LETTER);
			statement.parameters[":letter"] = letter;
			executeStatement(statement, countWordsResultHandler);
		}
		
		/**
		 * Get the number of words matching a search key from the database. 
		 * 
		 * @param letter String
		 **/
		public function countWordsForSearchKey(key:String):void
		{
			init();
			var statement:SQLStatement = toStatement(COUNT_WORDS_FOR_SEARCHKEY);
			statement.parameters[":key"] = "%" + key + "%";
			executeStatement(statement, listWordsResultHandler);
		}	
		
		
		public function listWordsResultHandler(result:Array):void
		{
			dispatcher.dispatchEvent(new ProviderResultEvent(ProviderResultEvent.RESULT, result));
		}
		
		public function countWordsResultHandler(result:Array):void
		{
			dispatcher.dispatchEvent(new ProviderResultEvent(ProviderResultEvent.RESULT, result));
		}
		
		
		
	}
}