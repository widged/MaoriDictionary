package com.widged.maoriDictionary.dictionary.provider
{
	import com.widged.io.events.ProviderResultEvent;
	import com.widged.io.service.AmfPhpDataProvider;
	import com.widged.io.service.RemoteDataProvider;
	import com.widged.io.sqlite.SQLiteDataProvider;
	import com.widged.maoriDictionary.dictionary.vo.RowsCursor;
	
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.filesystem.File;
	import flash.net.NetConnection;
	import flash.net.Responder;
	
	import mx.utils.ObjectUtil;
	
	public class DictionaryProvider_amfphp extends AmfPhpDataProvider implements IDictionaryProvider
	{
		
		
		public function DictionaryProvider_amfphp(target:IEventDispatcher=null)
		{
			super(target);
		}

		public function init():void
		{
			trace("[AMFPHP.init]");
			open("http://localhost/maoriDict/amfphp/gateway.php");
		}
		
		/**
		 * Get the list of words from the database. 
		 **/
		public function listWords():void
		{
			trace("[AMFPHP.listWords");
			gateway.call( "MaoriDictionary.listWords", new Responder(listWordsResultHandler, onFault));
		}	
		
		
		/**
		 * Get the list of words starting with a given letter from the database. 
		 * 
		 * @param letter String
		 **/
		public function listWordsForLetter(letter:String, start:int, offset:int):void
		{
			gateway.call( "MaoriDictionary.listWordsForLetter", new Responder(listWordsResultHandler, onFault), letter, start, offset);
		}	
		
		/**
		 * Get the list of words starting with a given letter from the database. 
		 * 
		 * @param letter String
		 **/
		public function listWordsForSearchKey(key:String, start:int, offset:int):void
		{
			gateway.call( "MaoriDictionary.listWordsForSearchKey", new Responder(listWordsResultHandler, onFault), key);
		}	
		
		public function listWordsResultHandler(result:Array):void
		{
			// trace("[Result]", ObjectUtil.toString(result));
			dispatcher.dispatchEvent(new ProviderResultEvent(ProviderResultEvent.RESULT, result));
		}
		
		/**
		 * Gets the number of completed surveys from the surveys table 
		 * 		 
		 * @param args Array [responder:DatabaseRespodner]
		 **/
		public function countWordsForLetter(letter:String):void
		{
			gateway.call( "MaoriDictionary.countWordsForLetter", new Responder(listWordsResultHandler, onFault), letter);
		}

		
		public function countWordsForSearchKey(key:String):void
		{
			gateway.call( "MaoriDictionary.countWordsForSearchKey", new Responder(listWordsResultHandler, onFault), key);
		}	
		
		public function onFault( fault : Object ) : void
		{
			trace("[ERROR]", ObjectUtil.toString(fault) );
		}
		
		
	}
}