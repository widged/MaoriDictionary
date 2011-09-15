/*
    (c) 2009 Widged.com - All rights reserved.
    Author:   Marielle Lange
*/
package com.widged.media.image
{
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import flash.system.LoaderContext;
   
      // All this is required to avoid a security sandbox violation upon image dragging the image. 
      
   public class BitmapLoader extends EventDispatcher
   {
      private var _bitmap:Bitmap;
      public function get imageBitmap():Bitmap
      {
         return _bitmap;
      }
      
      public function BitmapLoader()
      {
      }

      /**
      * Load the bytes of an image at a given url
      */
      public function load(imageUrl:String):void
      {
         // early exit conditions
         if(!imageUrl || imageUrl == "") {
            this.dispatchEvent(new BitmapLoadEvent(BitmapLoadEvent.COMPLETE, null));
            return; 
         }
         
         // loaderContext is used to avoid the securitySandbox violoation warnings
			var loaderContext:LoaderContext = new LoaderContext();
			loaderContext.checkPolicyFile = true;
	      var loader:Loader = new Loader();
	      loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onBitmapComplete);
	      loader.load(new URLRequest(imageUrl),loaderContext); 
      }
      
      /**
      * Send the bitmap data to any listening component 
      */
      private function onBitmapComplete(event:Event):void
      {
         this.dispatchEvent(new BitmapLoadEvent(BitmapLoadEvent.COMPLETE, Bitmap(event.target.content)));
      }

   }
}