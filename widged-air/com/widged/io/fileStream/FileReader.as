package com.widged.io.file_air
{
	import com.widged.io.events.ProviderErrorEvent;
	import com.widged.io.events.ProviderResultEvent;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import com.widged.io.file.IFileLoader;
	
	public class FileReader_air extends EventDispatcher implements IFileLoader
	{

		public function FileReader_air(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		
		public function load(url:String, resultCallback:Function=null, errorCallback:Function=null):void
		{
			var file:File = FileUtils_air.getFile(url);
			if(!file) {
				dispatchEvent(new ProviderErrorEvent(ProviderErrorEvent.FAULT, "[FileReader_air] No file defined"));
				return;
			}
			if(!file.exists) {
				dispatchEvent(new ProviderErrorEvent(ProviderErrorEvent.FAULT, "[FileReader_air] File not found: ", file.nativePath));
				return;
			}

			var stream:FileStream = new FileStream();
			stream.addEventListener(IOErrorEvent.IO_ERROR, onStreamError);

			function onStreamError(event:IOErrorEvent):void
			{
				var msg:String = "[FileReader_air] File Error while attempting to load file : " + url;
				if ( errorCallback != null ) 
				{								
					errorCallback(msg);
				}
				else
				{
					dispatchEvent(new ProviderErrorEvent(ProviderErrorEvent.FAULT, msg));					
				}	
			}
			
			stream.open(file, FileMode.READ);
			resultHandler(stream.readUTFBytes(stream.bytesAvailable));
			stream.close();

			function resultHandler(text:String):void
			{
				if ( resultCallback != null )
				{
					resultCallback(text);
				}
				else
				{
					dispatchEvent(new ProviderResultEvent(ProviderResultEvent.RESULT, text));
				}
			}			
			
		}
		
		
	}
}