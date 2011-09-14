package com.widged.maoriDictionary.framework
{
	import com.widged.io.IDataProvider;
	import com.widged.io.events.ProviderErrorEvent;
	import com.widged.io.events.ProviderResultEvent;
	import com.widged.io.events.ProviderStatusEvent;
	import com.widged.maoriDictionary.azScroller.ScrollerAZ;
	import com.widged.maoriDictionary.dictionary.provider.DictionaryProvider;
	import com.widged.maoriDictionary.dictionary.provider.DictionaryProvider_sqlite;
	import com.widged.maoriDictionary.dictionary.provider.IDictionaryProvider;
	import com.widged.maoriDictionary.splashScreen.SplashScreen;
	import com.widged.maoriDictionary.word.WordView;
	
	import flash.display.Scene;
	
	import mx.collections.ArrayList;
	
	import spark.components.NavigatorContent;
	import spark.components.ViewNavigator;

	public class FrameworkController
	{
		import com.widged.maoriDictionary.dictionary.provider.DictionaryData;
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
			initializeDictionary();
			dispatcher = FrameworkDispatcher.getInstance();
			dispatcher.addEventListener(FrameworkEvent.SPLASH_CLOSE, onSplashClose);
		}

		// #################################
		// ##   Getters, Setters
		// #################################
		
		public function set viewNavigator( value : ViewNavigator):void { navigator = value; }
		
		// #################################
		// ##   Events, Interaction
		// #################################
		private var _hasDictionaryProvider:Boolean = false;
		private function initializeDictionary():void
		{
			dictionary  = new DictionaryProvider();
			dictionary.addEventListener(ProviderStatusEvent.READY, onReady);
			dictionary.init();
			
			function onReady(event:ProviderStatusEvent):void
			{
				dictionary.removeEventListener(ProviderStatusEvent.READY, onReady);
				_hasDictionaryProvider = true;
			}
		}
		
		private function onSplashClose(event:FrameworkEvent):void
		{
			trace('[onSplashClose]');
			dispatcher.removeEventListener(FrameworkEvent.SPLASH_CLOSE, onSplashClose);
			showListing();
		}
		

		private function onWordSelection(event:FrameworkEvent):void
		{
			dispatcher.addEventListener(FrameworkEvent.WORD_CLOSE, onWordClose);
			navigator.pushView(com.widged.maoriDictionary.word.WordView, event.data as WordItem);
		}

		private function onWordClose(event:FrameworkEvent):void
		{
			dispatcher.removeEventListener(FrameworkEvent.WORD_CLOSE, onWordClose);
			navigator.popView();
		}
		
		private function onInfoSelection(event:FrameworkEvent):void
		{
			dispatcher.removeEventListener(FrameworkEvent.INFO_SELECT, onInfoSelection);
			dispatcher.addEventListener(FrameworkEvent.INFO_CLOSE, onInfoClose);
			navigator.pushView(com.widged.maoriDictionary.splashScreen.SplashScreen, null);
		}

		private function onInfoClose(event:FrameworkEvent):void
		{
			dispatcher.addEventListener(FrameworkEvent.INFO_SELECT, onInfoSelection);
			dispatcher.removeEventListener(FrameworkEvent.INFO_CLOSE, onSplashClose);
			navigator.popView();
		}
		
		
		// #################################
		// ##   Navigation
		// #################################

		
		public function showListing():void
		{
			var letter:String = ScrollerAZ.FIRST_LETTER;
			dispatcher.addEventListener(FrameworkEvent.INFO_SELECT, onInfoSelection);
			dispatcher.addEventListener(FrameworkEvent.WORD_SELECT, onWordSelection);
			navigator.pushView(com.widged.maoriDictionary.dictionary.ListingView, {arrayList: null, vscroll: 0, letter: letter, dictionary: dictionary});
		}
		
		
	}
}