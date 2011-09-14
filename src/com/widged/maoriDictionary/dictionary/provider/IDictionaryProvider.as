package com.widged.maoriDictionary.dictionary.provider
{
	import com.widged.io.IDataProvider;
	
	public interface IDictionaryProvider extends IDataProvider
	{
		function init():void;
		function listWords():void;
		function listWordsForLetter(letter:String):void;
		function listWordsForSearchKey(key:String):void;
		
	}
}