/*
(c) 2009 Widged.com - All rights reserved.
Author:   Marielle Lange
*/
package com.widged.io.fileStream
{
	
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	
	/**
	 *  A class to manage the loading of file content 
	 */
	public class FileQueueLoader extends EventDispatcher
	{
		
		import flash.display.Bitmap;
		import flash.display.Loader;
		import flash.events.Event;
		import flash.filesystem.File;
		import flash.filesystem.FileMode;
		import flash.filesystem.FileStream;
		import flash.net.FileFilter;
		import flash.net.URLLoader;
		import flash.net.URLLoaderDataFormat;
		import flash.net.URLRequest;
		import flash.utils.ByteArray;
		
		// status
		private var fileQueue:Array = [];
		private var isFileLoading:Boolean = false;
		
		private const FILE_BITMAP:String = "bmp";
		private const FILE_XML:String    = "xml";
		private const FILE_TEXT:String   = "txt";
		
		public function FileQueueLoader()
		{
		}
		
		/**
		 * Load the content of a xml file. Broadcast a FileLoadEvent once the content is available.
		 * The load is synchronous (blocking any interface event).
		 * 
		 * @param file The file to read
		 */
		public function loadXml(file:File):XML
		{
			// returned
			var xml:XML;
			return XML(loadText(file));
		}
		
		/**
		 * Load the content of a text file. Broadcast a FileLoadEvent once the content is available.
		 * The load is synchronous (blocking any interface event).
		 * 
		 * @param file The file to read
		 */
		public function loadText(file:File):String
		{
			// returned
			var str:String;
			// Early exit conditions
			if(!file.exists) { trace("[ERROR] File doesn't exist:", file.nativePath); return str; }
			// Reading from file stream
			var fileStream:FileStream = new FileStream();
			fileStream.open( file, FileMode.READ ); 
			str = fileStream.readUTFBytes(fileStream.bytesAvailable); 
			fileStream.close();
			isFileLoading = false;
			nextInQueue();
			return str;
		}
		
		
		
		private function nextInQueue():void
		{
			isFileLoading = false;
			if(!fileQueue.length) { return; }
			
			switch (fileQueue[0].type)
			{
				case FILE_BITMAP:
					// loadBitmap(fileQueue[0].url)	
					break;
				case FILE_XML:
					loadXml(fileQueue[0].file)	
					break;
				case FILE_TEXT:
					loadText(fileQueue[0].file)	
					break;
			}
			
		}
		
		
		/*
		
		Shorter way? 
		// The use of a load can cause security sandbox violations. 
		// Have your project set up to be published on a server (File > New > Flex Project > Application server type = PHP)
		var loaderContext:LoaderContext = new LoaderContext();
		loaderContext.checkPolicyFile = true;
		var loader:Loader = new Loader();
		loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onSheetLoaded);
		loader.load(new URLRequest(fileUrl),loaderContext); 
		}
		
		public function onSheetLoaded(event:Event):void {
		_sheetBitmap = Bitmap(event.currentTarget.content);
		dispatchEvent(new TileSetEvent(TileSetEvent.BITMAP_RESULT));
		}
		
		*/
		
		/*
		
		var urlRequest:HTTPService = new HTTPService();
		urlRequest.useProxy = false;
		urlRequest.method = "GET";
		urlRequest.url = poUrl;
		urlRequest.addEventListener(ResultEvent.RESULT, onUrlResult);
		urlRequest.addEventListener(FaultEvent.FAULT, onUrlFault);
		urlRequest.resultFormat = "text";
		urlRequest.send();
		
		*/
		
		/*
		// All this is required to avoid a security sandbox violation upon image dragging the image. 
		
		Not 100% sure this works in app mode. Possibly security sandbox issue
		May have to use
		
		var loaderContext:LoaderContext = new LoaderContext();
		loaderContext.checkPolicyFile = true;
		var loader:Loader = new Loader();
		loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onSheetLoaded);
		loader.load(new URLRequest(fileUrl),loaderContext); 
		*/		
		
		
	}
}