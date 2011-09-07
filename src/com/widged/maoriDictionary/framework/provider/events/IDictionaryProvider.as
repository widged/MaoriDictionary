package com.widged.maoriDictionary.framework.provider.events
{
	import com.widged.provider.IDataProvider;
	
	public interface IDictionaryProvider extends IDataProvider
	{
		function init():void;
		function listWords():void;
		function listWordsForLetter(letter:String):void;
		
	}
}