/*
    (c) 2009 Widged.com - All rights reserved.
    Author:   Marielle Lange
*/
package com.widged.utils
{
    /**
    *  Utility functions for object manipulation. All methods are static. 
    */
   public class ObjectUtils
   {
      public static function serialize(obj:Object, props:Array, title:String = 'Object'):String
      {
         var arr:Array = [];
         for (var i:int = 0; i < props.length; i++)
         {
            var prop:String = props[i];
            if(!obj.hasOwnProperty(prop)) {arr.push(prop + ": [n/a]"); continue; }
            arr.push(prop + ": " + obj[prop]);
         }
         return "[" + title + "] {" + arr.join(", ") + "}";
      }

   }
}