/*
    (c) 2009 Widged.com - All rights reserved.
    Author:   Marielle Lange
*/
package com.widged.utils
{
    /**
    *  Utility functions for date manipulation. All methods are static. 
    */
   public class DateUtils
   {
      public static function fromYYYYMMDD(dateText:String, sep:String = ""):Date
      {
         var date:Date;
         var y:int, m:int, d:int;
         if(sep && sep.length) 
         {
            var arr:Array = dateText.split(sep);
            if(arr.length != 3) { throw new Error("dateText doesn't have the expected format." + dateText + " ("+ "YYYY" + sep + "MM" + sep + "DD" + ")"); }
            y = parseInt(arr[0]);
            m = parseInt(arr[1]) - 1;
            d = parseInt(arr[2]);
         }
         else
         {
            if(dateText.length != 8) { throw new Error("dateText doesn't have the expected format." + dateText + " ("+ "YYYY" + sep + "MM" + sep + "DD" + ")"); }
            y = parseInt(dateText.substr(0,4));
            m = parseInt(dateText.substr(5,2));
            d = parseInt(dateText.substr(7,2));
         }
         return new Date(y, m, d);
      }

      public static function toYYYYMMDD(date:Date, sep:String = ""):String
      {
         var y:String = date.fullYear.toString();
         var m:String = int(date.month + 1).toString(); if(m.length < 2) {m = "0" + m; }
         var d:String = date.date.toString(); if(d.length < 2) {d = "0" + d; }
         return y+ sep + m + sep + d;
      }

   }
}