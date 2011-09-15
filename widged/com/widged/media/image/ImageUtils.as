/*
    (c) 2009 Widged - Creative Commons by-nc-sa
    Author:   Marielle Lange
*/
package com.widged.utils
{
   /**
   * Utility class for image manipulation. All methods are static
   */
   public class ImageUtils
   {
      import flash.display.DisplayObject;
      import flash.display.Bitmap;
      import flash.display.BitmapData;

      public static function render (target:DisplayObject):Bitmap
      {
         var d:BitmapData = new BitmapData(target.width, target.height);
         d.draw(target);
         return new Bitmap(d);
      }

		public static function areBitmapIdentical(bmp1:Bitmap, bmp2:Bitmap):Boolean
		{
           var bmd1:BitmapData = bmp1.bitmapData;
           var bmd2:BitmapData = bmp2.bitmapData;
           if(bmd1.compare(bmd2) == 0) {return true; }
           return false;
		}
		
		public static function duplicateImage(bmp:Bitmap):Bitmap
		{
            var data:BitmapData = bmp.bitmapData;
            return new Bitmap(data);
		}

   }
}