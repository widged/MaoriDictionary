package com.widged.io.sqlite
{
	import com.widged.io.IDataProvider;
	import com.widged.io.events.ProviderErrorEvent;
	import com.widged.io.events.ProviderStatusEvent;
	import com.widged.io.events.ProviderResultEvent;
	
	import flash.data.SQLConnection;
	import flash.data.SQLMode;
	import flash.data.SQLStatement;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;

	
	/**
	 * A class with shared functionality for providers that connect to sqlite databases
	 */

	public class SQLiteDataProvider extends EventDispatcher implements IDataProvider
	{
		
		protected var dbFile:File;
		protected var asyncConn:SQLConnection;		
		protected var dispatcher:IEventDispatcher;
		
		public function SQLiteDataProvider(target:IEventDispatcher=null)
		{
			super(target);
			dispatcher = target ? target : this;
		}
		
		protected function getStorageFile(fileName:String):File
		{
			return File.applicationStorageDirectory.resolvePath(fileName);			
		}

		protected function getApplicationFile(filePath:String):File
		{
			return File.applicationDirectory.resolvePath(filePath);			
		}
		
		
				
		/**
		 * Create the asynchronous connection to the database, then create the tables
		 **/
		protected function openAsyncConnection(dbFile:File):void
		{
			if ( !dbFile.exists )
			{
				var msg:String = "Database file not found: " + (dbFile ? dbFile.nativePath : "NULL");
				dispatcher.dispatchEvent(new ProviderErrorEvent(ProviderErrorEvent.FAULT, msg)); 
			}		
			
			asyncConn = new SQLConnection();
			asyncConn.addEventListener(SQLEvent.OPEN, onConnOpen);
			asyncConn.addEventListener(SQLErrorEvent.ERROR, onConnError);
			asyncConn.openAsync(dbFile, SQLMode.CREATE);
			
			function onConnOpen(se:SQLEvent):void
			{
				removeListeners();
				dispatcher.dispatchEvent(new ProviderStatusEvent(ProviderStatusEvent.READY, "SQL Connection successfully opened. SQLiteProvider:0001"));
			}
					
			function onConnError(see:SQLErrorEvent):void
			{
				removeListeners();
				dispatcher.dispatchEvent(new ProviderErrorEvent(ProviderErrorEvent.FAULT, "SQL Error while attempting to open database. SQLiteProvider:0002"));
			}
				
			function removeListeners():void
			{
				asyncConn.removeEventListener(SQLEvent.OPEN, onConnOpen);
				asyncConn.removeEventListener(SQLErrorEvent.ERROR, onConnError);
			}
		}
		
		public function close():void
		{
			if(asyncConn) { asyncConn.close(); }
		}
		
		protected function toStatement(query:String):SQLStatement
		{
			var statement:SQLStatement = new SQLStatement();
			statement.sqlConnection = asyncConn;
			statement.text = query;
			return statement;
		}
		
		protected function executeStatement(statement:SQLStatement, resultCallback:Function = null, errorCallback:Function = null):void
		{
			if ( !asyncConn || !asyncConn.connected ) 
			{
				dispatcher.dispatchEvent(new ProviderErrorEvent(ProviderErrorEvent.FAULT, "SQL connection not opened. SQLiteProvider:0003"));
				return;
			}
			
			statement.addEventListener(SQLEvent.RESULT,onResult);
			statement.addEventListener(SQLErrorEvent.ERROR,onError);
			
			function onResult(event:SQLEvent):void
			{
				removeListeners();
				var data:Array = statement.getResult().data;
				if ( resultCallback != null )
				{
					resultCallback(data);
				}
				else
				{
					dispatcher.dispatchEvent(new ProviderResultEvent(ProviderResultEvent.RESULT, data));
				}
					
			}
			
			function onError(event:SQLErrorEvent):void
			{
				removeListeners();
				var msg:String = "Couldnt' execute the SQL statement: " + statement.text + ". [ERROR] " + event.error ;
				if ( errorCallback != null ) 
				{								
					errorCallback(msg);
				}
				else
				{
					dispatcher.dispatchEvent(new ProviderErrorEvent(ProviderErrorEvent.FAULT, msg));
					
				}	
			}	
			
			function removeListeners():void
			{
				statement.removeEventListener(SQLEvent.RESULT, onResult);
				statement.removeEventListener(SQLErrorEvent.ERROR, onError);
			}
			
			statement.execute();
			
		}
		
		
	}
}