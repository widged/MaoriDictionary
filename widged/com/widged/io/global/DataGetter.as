/*
(c) 2010 Marielle Lange - All rights reserved.
*/
package com.widged.io.global
{
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;
    
    /**
     *  A class for a centralized event broker. The class is made into a singleton so that it can be referenced from anywhere. 
     *  The main purpose of having the dispatcher separate from any controller is to make it possible for the classes that instantiate it to process information from places it knows nothing about. 
     */
    public class DataGetter extends EventDispatcher
    {
        private var _data:*;
        
        public function DataGetter(enforcer:SingletonEnforcer, target:IEventDispatcher=null)
        {
            super(target);
        }
        
        /* #############################
        Singleton management
        ############################# */
        private static var instance:DataGetter;
        public static function getInstance():DataGetter  
        {
            if ( instance == null )
                instance = new DataGetter(new SingletonEnforcer);
            return instance;
        }
        
        public function get data():*            { return _data; }
        public function set data(value:*):void  { _data = value; }
        
    }
}

// A private class to ensure that the constructor is never called

class SingletonEnforcer {};
