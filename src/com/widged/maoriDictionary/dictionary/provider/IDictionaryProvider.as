package com.widged.maoriDictionary.dictionary.provider
{
	import com.widged.io.IDataProvider;
	import com.widged.maoriDictionary.dictionary.vo.RowsCursor;
	
	public interface IDictionaryProvider extends IDataProvider
	{
		function init():void;
		function listWords():void;
		function listWordsForLetter(letter:String, start:int, offset:int):void;
		function listWordsForSearchKey(key:String, start:int, offset:int):void;
		function countWordsForLetter(letter:String):void;
		function countWordsForSearchKey(key:String):void;
		
	}
}