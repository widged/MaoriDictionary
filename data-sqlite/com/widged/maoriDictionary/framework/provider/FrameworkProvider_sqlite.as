package com.widged.maoriDictionary.framework.provider
{
	import com.widged.maoriDictionary.framework.provider.events.IDictionaryProvider;
	import com.widged.provider.sqlite.SQLiteDataProvider;
	
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.filesystem.File;
	
	public class FrameworkProvider_sqlite extends SQLiteDataProvider implements IDictionaryProvider
	{

		// statements
		private const GET_WORDS:String               = "SELECT * FROM dictionary";
		private const GET_WORDS_FOR_LETTER:String    = "SELECT * FROM questions WHERE letter = :letter";
		private const GET_WORDS_FOR_SEARCHKEY:String = "SELECT * FROM dictionary WHERE id = :id";;
		private const GET_COUNT_OF_WORDS_FOR_LETTER:String = "SELECT COUNT(id) FROM SURVEYS WHERE uploaded=1";		

		public function FrameworkProvider_sqlite(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function init():void
		{
			trace("[FrameworkProvider_sqlite.init]")
			_dbFile = getApplicationFile("embed/db/maori_dictionary_0.1.db");
			openAsyncConnection();
		}
		
		/**
		 * Get the list of words from the database. 
		 **/
		public function listWords():void
		{
			trace("[FrameworkProvider_sqlite.listWords]");
			var statement:SQLStatement = toStatement(GET_WORDS);
			// statement.parameters[":letter"] = letter;
			executeStatement(statement, onWordsResult);
		}	

		/**
		 * Get the list of words starting with a given letter from the database. 
		 * 
		 * @param letter String
		 **/
		public function listWordsForLetter(letter:String):void
		{
			trace("[FrameworkProvider_sqlite.listWordsForLetter]", letter);
			var statement:SQLStatement = toStatement(GET_WORDS_FOR_LETTER);
			// statement.parameters[":letter"] = letter;
			executeStatement(statement, onWordsResult);
		}	
		
		public function onWordsResult(result:Object):void
		{
			trace("[FrameworkProvider_sqlite.onWordsResult]", result);
			trace(result.data);
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