package com.widged.io.file_air
{
	import com.widged.io.events.ProviderErrorEvent;
	import com.widged.io.events.ProviderResultEvent;
	import com.widged.io.events.ProviderStatusEvent;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import com.widged.io.file.IFileLoader;
	
	public class FileWriter_air extends EventDispatcher implements IFileLoader
	{
		private const FOLDER_MARKER:String = "::";
		private const FOLDER_DOCUMENTS:String = "documents";
		
		public function FileWriter_air(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function write(url:String, text:String, resultCallback:Function=null, errorCallback:Function=null):void
		{
			var file:File = FileUtils_air.getFile(url);
			var stream:FileStream = new FileStream();
			stream.addEventListener(IOErrorEvent.IO_ERROR, onStreamError);

			function onStreamError(event:IOErrorEvent):void
			{
				var msg:String = "[FileWriter_air] File Error while attempting to load file : " + url;
				if ( errorCallback != null ) 
				{								
					errorCallback(msg);
				}
				else
				{
					dispatchEvent(new ProviderErrorEvent(ProviderErrorEvent.FAULT, msg));					
				}	
			}

			stream.open(file, FileMode.WRITE);
			stream.writeUTFBytes(); // for xml: xml.toXMLString()
			stream.close();

			dispatchEvent(new ProviderStatusEvent(ProviderStatusEvent.COMPLETE));
			
		}
		
		
	}
}