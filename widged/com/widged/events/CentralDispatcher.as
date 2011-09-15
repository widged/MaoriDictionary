/*
  (c) 2010 Marielle Lange - All rights reserved.
*/
package com.widged.events
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	/**
	 *  A class for a centralized event broker. The class is made into a singleton so that it can be referenced from anywhere. 
	 *  The main purpose of having the dispatcher separate from any controller is to make it possible for the classes that instantiate it to process information from places it knows nothing about. 
	 */
	public class CentralDispatcher extends EventDispatcher
	{
		public function CentralDispatcher(enforcer:SingletonEnforcer, target:IEventDispatcher=null)
		{
			super(target);
		}
		
		/* #############################
		Singleton management
		############################# */
		private static var instance:CentralDispatcher ;
		public static function getInstance():CentralDispatcher  
		{
			if ( instance == null )
				instance = new CentralDispatcher(new SingletonEnforcer);
			return instance;
		}
		
	}
}

// A private class to ensure that the constructor is never called

class SingletonEnforcer {};
