package com.widged.maoriDictionary.framework
{
	import com.widged.maoriDictionary.framework.provider.FrameworkProvider_sqlite;
	import com.widged.maoriDictionary.framework.provider.events.IDictionaryProvider;
	import com.widged.maoriDictionary.framework.provider.events.ProviderErrorEvent;
	import com.widged.maoriDictionary.framework.provider.events.ProviderEvent;
	import com.widged.maoriDictionary.framework.provider.events.ProviderResultEvent;
	import com.widged.maoriDictionary.word.WordView;
	import com.widged.provider.IDataProvider;
	
	import flash.display.Scene;
	
	import mx.collections.ArrayList;
	
	import spark.components.NavigatorContent;
	import spark.components.ViewNavigator;

	public class FrameworkController
	{
		import com.widged.maoriDictionary.DictionaryData;
		import com.widged.maoriDictionary.framework.events.FrameworkDispatcher;
		import com.widged.maoriDictionary.framework.events.FrameworkEvent;
		import com.widged.maoriDictionary.word.vo.WordItem;
		import com.widged.maoriDictionary.dictionary.ListingView;
		
		// event bus
		private var dispatcher:FrameworkDispatcher;
		// class data
		private var wordList:Array;
		private var wordAL:ArrayList;
		private var navigator:ViewNavigator;

		public function FrameworkController()
		{
		}
		
		/**
		 * Apparently, "instantiation of a new View instance upon each request from the ViewNavigator within a MobileApplication"
		 * 
		 * At: http://custardbelly.com/blog/2010/11/15/flex-hero-persistant-data-in-mobileapplication/
		 * "The ViewNavigator, while providing some visual elements in relation to action bar content, serves as a manager for a 
		 * collection of View objects. The top-most View is visible and active, while any other View objects are represented by 
		 * a data object. Meaning, each time a View is added to the display list (via pushView()), an instance of it its class is 
		 * instantiated. Each time a View is removed from the display list (via popView() or pushView()) its instance is destroyed, 
		 * but its data model is stored in memory.
		 * 
		 * In order to save session state for a View, you must modify the data property. This property will be requested when destroying 
		 * the current instance of the View class. And the data property value will be assigned back to a newly created instance of the 
		 * same View class when navigating back to that view."
		 */
		
		
		// #################################
		// ##   Initialize
		// #################################

		private var dictionary:IDictionaryProvider;
		public function initialize():void
		{
			trace("[FrameworkController.initialize]")
			dispatcher = FrameworkDispatcher.getInstance();
			dispatcher.addEventListener(FrameworkEvent.SPLASH_CLOSE, onSplashClose);
			wordList = DictionaryData.wordList;
			wordAL = new ArrayList(wordList);
			
		}

		// #################################
		// ##   Getters, Setters
		// #################################
		
		public function set viewNavigator( value : ViewNavigator):void { navigator = value; }
		
		// #################################
		// ##   Events, Interaction
		// #################################
		
		private function onSplashClose(event:FrameworkEvent):void
		{
			trace("[FrameworkController.onSplashClose]")
			dispatcher.removeEventListener(FrameworkEvent.SPLASH_CLOSE, onSplashClose);
			showListing();
		}
		

		private function onWordSelected(event:FrameworkEvent):void
		{
			trace("[FrameworkController.onWordSelected]")
			dispatcher.addEventListener(FrameworkEvent.WORD_CLOSE, onWordClose);
			navigator.pushView(com.widged.maoriDictionary.word.WordView, event.data as WordItem);
		}

		private function onWordClose(event:FrameworkEvent):void
		{
			trace("[FrameworkController.onWordClose]", event.data);
			dispatcher.removeEventListener(FrameworkEvent.WORD_CLOSE, onWordClose);
			navigator.popView();
		}
		
		private function onDictionarySearch(event:FrameworkEvent):void
		{
			trace("[FrameworkController.onDictionarySearch]", event.data.key);
		}

		private function onLetterPointerChange(event:FrameworkEvent):void
		{
			trace("[FrameworkController.onLetterPointerChange]", event.data.letter);
		}
		
		// #################################
		// ##   Navigation
		// #################################

		
		public function showListing():void
		{
			dispatcher.addEventListener(FrameworkEvent.WORD_SELECT,           onWordSelected);
			dispatcher.addEventListener(FrameworkEvent.DICTIONARY_SEARCH,     onDictionarySearch);
			dispatcher.addEventListener(FrameworkEvent.LETTER_POINTER_CHANGE, onLetterPointerChange);
			navigator.pushView(com.widged.maoriDictionary.dictionary.ListingView, {arrayList: wordAL, list: wordList, vscroll: 0});

			trace("[FrameworkController.showListing]")
			dictionary  = new FrameworkProvider_sqlite();
			dictionary.addEventListener(ProviderEvent.READY, onReady);
			dictionary.init();
			
			function onReady(event:ProviderEvent):void
			{
				trace("-- ready");
				dictionary.addEventListener(ProviderResultEvent.RESULT, onResult);
				dictionary.addEventListener(ProviderErrorEvent.FAULT, onFault);
				dictionary.listWords();
			}
			function onResult(event:ProviderResultEvent):void
			{
				trace("-- result");
				trace(event.data);
			}
			function onFault(event:ProviderErrorEvent):void
			{
				trace("-- fault");
				trace(event.data.msg);
			}
		}
		
		
	}
}