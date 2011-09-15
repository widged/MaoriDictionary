package com.widged.io.service
{
    
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;
    
    import mx.rpc.remoting.RemoteObject;
    
    /**
    * A class with shared functionality for providers that connect to coldfusion webservices.  
	*/
    public class ColdFusionDataProvider extends RemoteDataProvider implements IDataProvider
    {
        protected var userService:RemoteObject;
        public function ColdFusionDataProvider(target:IEventDispatcher=null)
        {
            super(target);
            userService = new RemoteObject("ColdFusion");
            userService.source = "xyz.cfc.myService";
        }
    }
}
