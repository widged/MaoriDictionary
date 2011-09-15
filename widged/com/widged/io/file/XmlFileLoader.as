package com.widged.io.file
{
	import com.widged.events.DataObjectEvent;
	import com.widged.io.events.ProviderResultEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
    
    public class XmlFileLoader extends FileLoader implements IFileLoader
    {
        
        public static const RESULT:String = ResultEvent.RESULT;
        public static const FAULT:String = FaultEvent.FAULT;

        public function XmlFileLoader(target:IEventDispatcher=null)
        {
            super(target);
        }

        override public function load(url:String, resultCallback:Function = null, errorCallback:Function = null):void{
			super.load(url, resultHandler);
			
			function resultHandler(result:*)
			{
				var xml:XML = XML(result)
				{
					if ( resultCallback != null )
					{
						resultCallback(xml);
					}
					else
					{
						dispatchEvent(new ProviderResultEvent(ProviderResultEvent.RESULT, xml));
					}

				}
			}
        }
               
    }
}