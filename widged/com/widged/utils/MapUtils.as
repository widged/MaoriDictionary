/*
    (c) 2009 Widged.com - All rights reserved.
    Author:   Marielle Lange
*/
package com.widged.utils
{
    /**
    *  Utility functions for map manipulation. 
    *  No constructor. All methods are static. 
    */
   public class MapUtils
   {

     /**
      * Try and convert a string into a constant. 
      *
      * @param  map  The conversion map to use. 
      * @param  propFrom  The property in the map item that has the string to match.
      * @param  propTo  The property in the map item that has the value to return.
      * @param  match The value to match. Typically the value of a tag in the config file. 
      *
      * @return  The constant id of the given descriptor in the given map. Or -1 if the 
      *          descriptor couldn't be found in the map 
      */
      public static function fromTo(map:Array, propFrom:String, propTo:String, match:*, notFoundValue:* = null):*
      {
         for each (var obj:Object in map)
         {
            if(obj.hasOwnProperty(propFrom) && obj[propFrom] == match && obj.hasOwnProperty(propTo))
            {
               return obj[propTo];
            }
         }
         return notFoundValue;
      }     
   }
}