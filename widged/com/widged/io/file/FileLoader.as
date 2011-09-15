package com.widged.io.file
{
	import com.widged.events.DataObjectEvent;
	import com.widged.io.events.ProviderErrorEvent;
	import com.widged.io.events.ProviderResultEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	public class FileLoader extends EventDispatcher implements IFileLoader
	{
		
		public static const RESULT:String = ResultEvent.RESULT;
		public static const FAULT:String = FaultEvent.FAULT;
		
		public function FileLoader(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function load(url:String, resultCallback:Function = null, errorCallback:Function = null):void
		{
			var urlrequest:URLRequest = new URLRequest(url);
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE,        onResult);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onError);            
			loader.load(urlrequest);
			
			function onResult(event:Event):void
			{
				removeListeners();
				var loader:URLLoader = URLLoader(event.target);
				var data:Object = loader.data;
				if ( resultCallback != null )
				{
					resultCallback(data);
				}
				else
				{
					dispatchEvent(new ProviderResultEvent(ProviderResultEvent.RESULT, data));
				}
			}
			
			function onError(event:Event):void
			{
				var msg:String = "File Error while attempting to load file : " + url;
				if ( errorCallback != null ) 
				{								
					errorCallback(msg);
				}
				else
				{
					dispatchEvent(new ProviderErrorEvent(ProviderErrorEvent.FAULT, msg));					
				}	
			}
			
			function removeListeners():void
			{
				loader.removeEventListener(Event.COMPLETE,        onResult);
				loader.removeEventListener(IOErrorEvent.IO_ERROR, onError);            
			}
			
		}
		
	}
}