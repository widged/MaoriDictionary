/*
    (c) 2009 Widged.com - All rights reserved.
    Author:   Marielle Lange
*/
package com.widged.media.image
{
   import flash.display.Bitmap;
   import flash.events.Event;

   public class BitmapLoadEvent extends Event
   {

      public static const COMPLETE:String = "bitmapComplete";
      
      public var bitmap:Bitmap;

      public function BitmapLoadEvent(type:String, bmp:Bitmap)
      {
         super(type, false, false);
         this.bitmap = bmp;
      }

     /**
     * Override of the clone function of the Event class. 
     * Such an override is required whenever creating a new class
     */
     override public function clone():Event {
           return new BitmapLoadEvent(type, bitmap);
     }         
      
   }
}