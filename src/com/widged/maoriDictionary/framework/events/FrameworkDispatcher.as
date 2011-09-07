package com.widged.maoriDictionary.framework.events
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	/**
	 *  A class for a centralized event broker. The class is made into a singleton so that it can be referenced from anywhere. 
	 *  The main purpose of having the dispatcher separate from any controller is to make it possible for the classes that instantiate it to process information from places it knows nothing about. 
	 */
	public class FrameworkDispatcher extends EventDispatcher
	{
		public function FrameworkDispatcher(enforcer:SingletonEnforcer, target:IEventDispatcher=null)
		{
			super(target);
		}
		
		/* #############################
		Singleton management
		############################# */
		private static var instance:FrameworkDispatcher ;
		public static function getInstance():FrameworkDispatcher  
		{
			if ( instance == null )
				instance = new FrameworkDispatcher(new SingletonEnforcer);
			return instance;
		}
		
	}
}

// A private class to ensure that the constructor is never called

class SingletonEnforcer {};
