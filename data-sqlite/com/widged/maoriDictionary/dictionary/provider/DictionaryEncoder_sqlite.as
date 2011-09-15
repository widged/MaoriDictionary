package com.widged.maoriDictionary.dictionary.provider
{
	import com.widged.io.events.ProviderErrorEvent;
	import com.widged.io.events.ProviderResultEvent;
	import com.widged.io.sqlite.SQLiteDataProvider;
	
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.filesystem.File;
	
	public class DictionaryEncoder_sqlite extends SQLiteDataProvider
	{
		
		// statements
		private const GET_WORDS:String               = "SELECT * FROM dictionary";
		private const GET_WORDS_FOR_LETTER:String    = "SELECT * FROM questions WHERE letter = :letter";
		private const GET_WORDS_FOR_SEARCHKEY:String = "SELECT * FROM dictionary WHERE id = :id";;
		private const GET_COUNT_OF_WORDS_FOR_LETTER:String = "SELECT COUNT(id) FROM SURVEYS WHERE uploaded=1";		
		
		public function DictionaryEncoder_sqlite(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function init(dbFile:File):void
		{
			openAsyncConnection(dbFile);
		}
		
		
		public function emptyTable():void
		{
			runQuery('DROP TABLE IF EXISTS "dictionary"');
			runQuery('CREATE TABLE IF NOT EXISTS "dictionary" (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE, wid TEXT DEFAULT "-" NOT NULL, definition TEXT DEFAULT "-" NOT NULL, word TEXT DEFAULT "-" NOT NULL, indice TEXT, letter TEXT DEFAULT "-" NOT NULL)');
		}
		
		/**
		 * Get the list of words from the database. 
		 **/
		public function runQuery(query:String):void
		{
			var statement:SQLStatement = toStatement(query);
			// statement.parameters[":letter"] = letter;
			executeStatement(statement, runQueryResultHandler, runQueryFaultHandler);
		}	
		

		public function runQueryResultHandler(result:*):void
		{
			dispatcher.dispatchEvent(new ProviderResultEvent(ProviderResultEvent.RESULT, result));
		}

		public function runQueryFaultHandler(msg:String):void
		{
			dispatcher.dispatchEvent(new ProviderErrorEvent(ProviderErrorEvent.FAULT, msg));
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