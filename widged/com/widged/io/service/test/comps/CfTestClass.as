package com.widged.io.service.test.comps
{
    import com.widged.user.provider.UserProvider;
    
    import flash.events.Event;
    
    import mx.containers.HBox;
    
    public class CfTestClass extends HBox
    {
        import com.widged.framework.FrameworkController;
        import com.widged.events.FrameworkDispatcher;
        import com.widged.events.DataObjectEvent;
        import com.widged.framework.events.FrameworkEvent;
        import com.jbmetrics.errorhandling.FaultHandler;
        
        import mx.collections.ItemResponder;
        import mx.rpc.AsyncToken;
        import mx.utils.ObjectProxy;

        private var frameworkDispatcher:FrameworkDispatcher;
        private var frameworkController:FrameworkController;
        protected var userProvider:UserProvider;
        
        public function CfTestClass()
        {
            super();
            this.percentWidth = 100;
            this.percentHeight = 100;
            frameworkDispatcher = FrameworkDispatcher.getInstance();
            frameworkDispatcher.addEventListener(FrameworkEvent.APPLICATION_READY, onApplicationReady);
            frameworkController = new FrameworkController();
            userProvider = new UserProvider();
        }
        private function onApplicationReady(event:Event):void
        {
        }

    }
}