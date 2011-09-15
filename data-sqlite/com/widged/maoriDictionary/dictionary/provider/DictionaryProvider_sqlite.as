package com.widged.maoriDictionary.dictionary.provider
{
	import com.widged.io.events.ProviderResultEvent;
	import com.widged.io.sqlite.SQLiteDataProvider;
	
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.filesystem.File;
	
	public class DictionaryProvider_sqlite extends SQLiteDataProvider implements IDictionaryProvider
	{

		
		// statements
		private const GET_WORDS:String               = "SELECT * FROM dictionary";
		private const GET_WORDS_FOR_LETTER:String    = "SELECT * FROM dictionary WHERE letter = :letter";
		private const GET_WORDS_FOR_SEARCHKEY:String = "SELECT * FROM dictionary WHERE word LIKE :key OR definition LIKE :key";
		private const GET_COUNT_OF_WORDS_FOR_LETTER:String = "SELECT COUNT(id) FROM dictionary WHERE letter = :letter";		

		public function DictionaryProvider_sqlite(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function init():void
		{
			var dbFile:File = getApplicationFile("embed/db/maori_dictionary_0.2.db");
			// dbFile.url - app:/embed/db/maori_dictionary_0.1.db
			openAsyncConnection(dbFile);
		}
		
		/**
		 * Get the list of words from the database. 
		 **/
		public function listWords():void
		{
			var statement:SQLStatement = toStatement(GET_WORDS);
			executeStatement(statement, listWordsResultHandler);
		}	

		/**
		 * Get the list of words starting with a given letter from the database. 
		 * 
		 * @param letter String
		 **/
		public function listWordsForLetter(letter:String):void
		{
			var statement:SQLStatement = toStatement(GET_WORDS_FOR_LETTER);
			statement.parameters[":letter"] = letter;
			executeStatement(statement, listWordsResultHandler);
		}	

		/**
		 * Get the list of words starting with a given letter from the database. 
		 * 
		 * @param letter String
		 **/
		public function listWordsForSearchKey(key:String):void
		{
			var statement:SQLStatement = toStatement(GET_WORDS_FOR_SEARCHKEY);
			statement.parameters[":key"] = "%" + key + "%";
			executeStatement(statement, listWordsResultHandler);
		}	
		
		public function listWordsResultHandler(result:Array):void
		{
			dispatcher.dispatchEvent(new ProviderResultEvent(ProviderResultEvent.RESULT, result));
		}
		
		/**
		 * Gets the number of completed surveys from the surveys table 
		 * 		 
		 * @param args Array [responder:DatabaseRespodner]
		 **/
		public function countWordsForLetter(letter:String):void
		{
			/*
			if ( args[0] is EventDispatcher )
			{
				var sqlWrapper:SQLWrapper = this.sqlStatementFactory.newInstance(args[0], GET_NUMBER_OF_COMPLETED_SURVEYS);				
				sqlWrapper.statement.execute();
			}
			*/
		}
		
		
		
	}
}