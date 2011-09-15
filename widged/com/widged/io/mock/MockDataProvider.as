package com.widged.io.mock
{
    import com.widged.io.IDataProvider;
    
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;

    /**
     * A class with shared functionality for providers that load mock data at runtime.
     */    
    /*
    :NOTE: **For development purpose only!** All offline data are retrieved from the file SentenceItemData that provides 
    mock datas for a specific user and specific instance. With the current setup the same data will always be returned, 
    irrespective of the user choice or actions (the phoneme analysis doesn't take into account the actual recording).    
    */
    
    public class MockDataProvider extends EventDispatcher implements IDataProvider
    {
        public function MockDataProvider(target:IEventDispatcher=null)
        {
            super(target);
        }
    }
}