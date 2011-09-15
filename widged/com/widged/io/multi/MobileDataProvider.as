package com.widged.io.multi
{
    import com.widged.lesson.provider.ILessonProvider;
    
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;
    
    /**
    * A class to manage the provision of data on mobile devices. 
    * 
    * It takes into account the fact that the device could be disconnected from the internet at any moment and 
    * allow to switch between online and offline data access at any time, while the application is running.  
     */
    /*
    :NOTE: Replace any colfusion service call with other means of data access. With synchroneous data access the onHandlers
    shouldn't be required and the data dispatched directly. Use LessonItemProvider_productionServer for examples of how this 
    can be done. Check SentenceItemData.as for insight about what data structure and content are returned by each 
    webservice. 

    :NOTE: a dispatcher variable is set and all events should be dispatched using it. In theory, setting up the target is all 
    what would be needed to get the IEventDispatcher passed to the function used as target to the event. In practice, this 
    doesn't work reliably. Sending values through the dispatcher does.
    
    :NOTE:  This was set up for the purpose of development. With the idea that one mode or another should be chosen in any   
    production release. If both online and offline are to be used in a productin deployment, then extra functionality
    needs to be added to actively manage the synchronization of data onto the remote server once the device gets 
    back online. 


    */
    public class MobileDataProvider extends EventDispatcher
    {

        public static const USE_SERVICE:int   = 1;
        public static const USE_MOCK:int      = 2;
        public static const USE_FILE:int      = 3;
        public static const USE_SQLITE:int    = 4;

        protected var currentProvider:IEventDispatcher;
        private var _serviceProvider:IEventDispatcher;
        private var _mockProvider:IEventDispatcher;
        private var _backupProvider:IEventDispatcher;
        
        private var _accessMode:int;
        public function MobileDataProvider(target:IEventDispatcher=null)
        {
            super(target);
        }
        
        protected function set accessMode(value:int):void  { _accessMode = value; commitProvider(); }
        // :TODO: change the setup to pass a class reference instead of an instance, to avoid to have to create
        // provider instance until required. 
        protected function set serviceProvider(value:IEventDispatcher):void  { _serviceProvider = value; commitProvider(); }
        protected function set mockProvider(value:IEventDispatcher):void     { _mockProvider = value; commitProvider(); }
        // For use once the provider types start to accumulate, in case there is some issue with the provider 
        // and it is null, use this as a backup. 
        protected function set backupProvider(value:IEventDispatcher):void   { _backupProvider = value; commitProvider(); }
        
        
        
        private function commitProvider():void
        {
            switch (_accessMode)
            {
                case USE_SERVICE:
                    currentProvider = _serviceProvider; 
                    break;
                case USE_MOCK:
                default:
                    currentProvider = _mockProvider; 
                    break;
            }
            if(!currentProvider) { currentProvider = _backupProvider; }
        }
        
    }
}
