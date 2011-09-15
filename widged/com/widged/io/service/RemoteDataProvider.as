package com.widged.io.service
{
	import com.widged.io.global.DataGetter;
    
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;
    
    /**
    * A class with shared functionality for providers that connect to remote webservices.
    *   
    * To group all services requests in a separate provider class rather than make "RemoteObject" calls in the ui component 
    * itself esnures that: 
    * (1) it is easy to set-up a separate project that allows for the easy testing of each service call, with 
    *     feedback on performance speed (see Provider-testServer, RemoteColdFusionTest.mxml App for an illustration ); 
    * (2) it is easy to set-up a separate project that will run the application using mock data instead of service calls 
    *     (see Provider-mock for an illustration).
    * 
    * Provider classes are best thought as a plugin that can be added and removed to the frameworks at will. It should have no 
    * knowledge whatsoever of framework-specific information like data models or framework events. 
    * 
    * Likewise, they should not be accessed by any other means than via the [Section]Controller or the equivalent service 
    * testing class.
    *  
    * All events should be custom and meant to target the UserController only.    
    */
    public class RemoteDataProvider extends EventDispatcher implements IDataProvider
    {
        public function RemoteDataProvider(target:IEventDispatcher=null)
        {
            super(target);
        }
        
        protected function getServerIP():String
        {
            var config:ConfigVO = DataGetter.getInstance().config;
            var serverIP:String = config ? config.serverIP : null;
            return serverIP;
        }
            
    }
}